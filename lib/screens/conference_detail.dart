//// Copyright 2018, Devoxx
////
//// Licensed under the Apache License, Version 2.0 (the "License");
//// you may not use this file except in compliance with the License.
//// You may obtain a copy of the License at
////
//// http://www.apache.org/licenses/LICENSE-2.0
////
//// Unless required by applicable law or agreed to in writing, software
//// distributed under the License is distributed on an "AS IS" BASIS,
//// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//// See the License for the specific language governing permissions and
//// limitations under the License.

import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/widgets/main_drawer.dart';
import 'package:voxxedapp/widgets/speaker_item.dart';

class ConferenceDetailViewModel {
  final Conference conference;
  final BuiltList<Speaker> speakers;

  ConferenceDetailViewModel(AppState state, int conferenceId)
      : this.conference = state.conferences[conferenceId],
        this.speakers = state.speakers.containsKey(conferenceId)
            ? state.speakers[conferenceId]
            : BuiltList<Speaker>();
}

class ConferenceDetailScreen extends StatelessWidget {
  final int id;

  const ConferenceDetailScreen(this.id);

  Widget _createFailIcon(IconData iconData) {
    return Container(
      color: Color(0x40000000),
      child: Icon(
        iconData,
        color: Colors.grey,
      ),
    );
  }

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
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Conference tracks', style: theme.textTheme.subhead),
      ),
    ];

    if (conference.tracks == null || conference.tracks.length == 0) {
      children.add(
        Text(
          'Not yet determined.',
          style: theme.textTheme.body1.copyWith(fontStyle: FontStyle.italic),
        ),
      );
    } else {
      var count = 0;
      for (final track in conference.tracks) {
        children.add(
          DecoratedBox(
            decoration: BoxDecoration(
                color: count % 2 == 0 ? Color(0x08000000) : Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                    ),
                    padding: const EdgeInsets.all(2.0),
                    height: 50.0,
                    width: 50.0,
                    child: track.imageURL != null
                        ? CachedNetworkImage(
                            imageUrl: track.imageURL,
                            placeholder: _createFailIcon(Icons.assignment),
                            errorWidget: _createFailIcon(Icons.error),
                            height: 50.0,
                            width: 50.0,
                            fit: BoxFit.cover,
                          )
                        : _createFailIcon(Icons.assignment),
                  ),
                  SizedBox(width: 12.0),
                  Text(track.name, style: theme.textTheme.body1),
                ],
              ),
            ),
          ),
        );

        count++;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  Widget _buildSpeakerList(
      BuildContext context, BuiltList<Speaker> speakers, ThemeData theme) {
    var children = <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Speakers', style: theme.textTheme.subhead),
      ),
    ];

    if (speakers == null || speakers.length == 0) {
      children.add(
        Text(
          'Not yet determined.',
          style: theme.textTheme.body1.copyWith(fontStyle: FontStyle.italic),
        ),
      );
    } else {
      var count = 0;
      for (final speaker in speakers) {
        children.add(SpeakerItem(speaker, alternateColor: count % 2 == 0));
        count++;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Voxxed Day details'),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: ViewModelSubscriber<AppState, ConferenceDetailViewModel>(
          converter: (state) => ConferenceDetailViewModel(state, id),
          builder: (context, dispatcher, viewModel) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildHeader(context, viewModel.conference, theme),
                SizedBox(height: 12.0),
                _buildInfoBlock(context, viewModel.conference, theme),
                SizedBox(height: 12.0),
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
