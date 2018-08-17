// Copyright 2018, Devoxx
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:voxxedapp/blocs/conference_bloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/widgets/main_drawer.dart';

typedef Widget ViewModelBuilder<V extends ViewModel>(BuildContext context, V viewModel);
typedef V ViewModelConverter<S, V extends ViewModel<S>>(Dispatcher<S> dispatcher, S state);

class ViewModelSubscriber<S, V extends ViewModel<S>> extends StatefulWidget {
  final Dispatcher<S> dispatcher;
  final BehaviorSubject<S> stream;
  final ViewModelConverter<S, V> converter;
  final ViewModelBuilder<V> builder;

  ViewModelSubscriber({
    @required this.dispatcher,
    @required this.stream,
    @required this.converter,
    @required this.builder,
  });

  @override
  _ViewModelSubscriberState createState() => _ViewModelSubscriberState<S, V>();
}

class _ViewModelSubscriberState<S, V extends ViewModel<S>>
    extends State<ViewModelSubscriber<S, V>> {
  V _latestViewModel;
  StreamSubscription<V> _subscription;

  @override
  void initState() {
    super.initState();
    _latestViewModel = widget.converter(widget.dispatcher, widget.stream.value);
    _subscription = widget.stream
        .map<V>((s) => widget.converter(widget.dispatcher, s))
        .distinct()
        .listen((viewModel) {
      setState(() => _latestViewModel = viewModel);
    });
  }


  @override
  void dispose() {
    _subscription.cancel();
    _subscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _latestViewModel);
  }
}

class ViewModel<S> {
  final Dispatcher<S> dispatcher;

  const ViewModel(this.dispatcher);
}

class ConferenceDetailsViewModel extends ViewModel<AppState> {
  final Conference conference;
  final BuiltList<Speaker> speakers;

  const ConferenceDetailsViewModel._(
      Dispatcher<AppState> dispatcher, this.conference, this.speakers)
      : super(dispatcher);

  factory ConferenceDetailsViewModel.fromAppState(
      Dispatcher<AppState> dispatcher, AppState state, int conferenceId) {
    return ConferenceDetailsViewModel._(
        dispatcher,
        state.conferences
            .firstWhere((c) => c.id == conferenceId, orElse: () => null),
        state.speakers.containsKey(conferenceId)
            ? state.speakers[conferenceId]
            : BuiltList<Speaker>());
  }
}

class ConferenceDetailScreen extends StatelessWidget {
  final int id;

  const ConferenceDetailScreen(this.id);

  Widget _buildHeader(
      BuildContext context, Conference conference, ThemeData theme) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: 200.0),
      child: Stack(
        children: [
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            bottom: 0.0,
            child: Image.network(
              conference.imageURL,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 10.0,
              ),
              color: Colors.white,
              child: Text(
                conference.name,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBlock(
      BuildContext context, Conference conference, ThemeData theme) {
    String dateStr;

    if (conference.fromDate == null && conference.endDate == null) {
      dateStr = 'Not yet determined';
    } else if (conference.fromDate == conference.endDate) {
      dateStr = conference.fromDate;
    } else {
      dateStr = '${conference.fromDate} to ${conference.endDate}';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            conference.locationName ?? 'Location not yet determined',
            style: theme.textTheme.subhead,
          ),
          SizedBox(height: 4.0),
          Text(
            dateStr,
            style: theme.textTheme.subhead.copyWith(
              color: Color(0xff808080),
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 8.0),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              conference.description ?? 'No description provided.',
              style: theme.textTheme.body1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackList(
      BuildContext context, Conference conference, ThemeData theme) {
    var children = <Widget>[
      Text('Conference tracks', style: theme.textTheme.subhead),
    ];

    if (conference.tracks == null || conference.tracks.length == 0) {
      children.add(Text(
        'No track information provided.',
        style: theme.textTheme.body1,
      ));
    } else {
      for (final track in conference.tracks) {
        children.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: [
                Image.network(
                  track.imageURL ?? 'http://via.placeholder.com/50x50',
                  height: 50.0,
                  width: 50.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 4.0),
                Text(track.name, style: theme.textTheme.body1),
              ],
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  Widget _buildSpeakerList(
      BuildContext context, BuiltList<Speaker> speakers, ThemeData theme) {
    return Text('${speakers.length}');
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Current Voxxed Days'),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: ViewModelSubscriber<AppState, ConferenceDetailsViewModel>(
          dispatcher: ConferenceBlocProvider.of(context),
          stream: ConferenceBlocProvider.of(context).appStates,
          converter: (dispatcher, state) =>
              ConferenceDetailsViewModel.fromAppState(dispatcher, state, id),
          builder: (context, viewModel) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildHeader(context, viewModel.conference, theme),
                Divider(height: 2.0),
                _buildInfoBlock(context, viewModel.conference, theme),
                Divider(height: 2.0),
                _buildTrackList(context, viewModel.conference, theme),
                _buildSpeakerList(context, viewModel.speakers, theme),
              ],
            );
          },
        ),
      ),
    );
  }
}
