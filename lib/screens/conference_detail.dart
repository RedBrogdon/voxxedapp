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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/widgets/avatar.dart';
import 'package:voxxedapp/widgets/main_drawer.dart';
import 'package:voxxedapp/widgets/speaker_item.dart';

class SpeakerPane extends StatelessWidget {
  const SpeakerPane(this.conferenceId);

  final int conferenceId;

  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, List<Speaker>>(
      converter: (state) {
        return state.speakers.containsKey(conferenceId)
            ? (state.speakers[conferenceId].toList()..sort())
            : <Speaker>[];
      },
      builder: (context, dispatcher, model) {
        final theme = Theme.of(context);

        var children = <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Speakers', style: theme.textTheme.subhead),
          ),
        ];

        if (model == null || model.length == 0) {
          children.add(
            Text(
              'Not yet determined.',
              style:
                  theme.textTheme.body1.copyWith(fontStyle: FontStyle.italic),
            ),
          );
        } else {
          var count = 0;
          for (final speaker in model) {
            children.add(SpeakerItem(speaker, conferenceId,
                alternateColor: count % 2 == 0));
            count++;
          }
        }

        return ListView(
          children: children,
        );
      },
    );
  }
}

class ConferenceInfoPanel extends StatelessWidget {
  const ConferenceInfoPanel(this.conferenceId);

  final int conferenceId;

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

  List<Widget> _buildTrackList(
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
          GestureDetector(
            onTap: () {
              String dest = '/conference/$conferenceId/track/${track.id}';
              Navigator.of(context).pushNamed(dest);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color:
                      count % 2 == 0 ? Color(0x08000000) : Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 8.0,
                ),
                child: Row(
                  children: [
                    Avatar(
                      width: 50.0,
                      height: 50.0,
                      imageUrl: track.imageURL,
                      placeholderIcon: Icons.assignment,
                      errorIcon: Icons.error,
                      square: true,
                    ),
                    SizedBox(width: 12.0),
                    Text(track.name, style: theme.textTheme.subhead),
                  ],
                ),
              ),
            ),
          ),
        );

        count++;
      }
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelSubscriber<AppState, Conference>(
      converter: (state) => state.conferences[conferenceId],
      builder: (context, dispatcher, conference) => ListView(
            children: <Widget>[
              _buildHeader(context, conference, theme),
              SizedBox(height: 12.0),
              _buildInfoBlock(context, conference, theme),
              SizedBox(height: 12.0),
            ]..addAll(_buildTrackList(context, conference, theme)),
          ),
    );
  }
}

class ConferenceDetailScreen extends StatefulWidget {
  final int conferenceId;

  const ConferenceDetailScreen(this.conferenceId);

  @override
  _ConferenceDetailScreenState createState() {
    return new _ConferenceDetailScreenState();
  }
}

class _ConferenceDetailScreenState extends State<ConferenceDetailScreen> {
  int navBarSelection = 0;

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (navBarSelection == 0) {
      body = ConferenceInfoPanel(widget.conferenceId);
    } else if (navBarSelection == 1) {
      body = Center(
        child: Text('Not Yet Implemented'),
      );
    } else {
      body = SpeakerPane(widget.conferenceId);
    }

    return Scaffold(
      appBar: AppBar(
        title: ViewModelSubscriber<AppState, String>(
          converter: (state) => state.conferences[widget.conferenceId].name,
          builder: (context, dispatcher, name) => Text(name),
        ),
      ),
      drawer: MainDrawer(),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => navBarSelection = index),
        currentIndex: navBarSelection,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('Info'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Schedule'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Speakers'),
          ),
        ],
      ),
    );
  }
}
