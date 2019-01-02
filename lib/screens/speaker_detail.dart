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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebloc/rebloc.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:voxxedapp/blocs/speaker_bloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/widgets/avatar.dart';
import 'package:voxxedapp/widgets/invalid_navigation_notice.dart';

class SpeakerDetailScreen extends StatelessWidget {
  const SpeakerDetailScreen(this.conferenceId, this.uuid);

  final String uuid;
  final conferenceId;

  List<Widget> _createInfoRows(Speaker speaker, TextTheme theme) {
    final widgets = <Widget>[];

    if (speaker.company != null) {
      widgets.addAll([
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Text(
            'Company',
            style: theme.subhead.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: Text(
            '${speaker.company}',
            style: theme.body1,
          ),
        ),
      ]);
    }

    if (speaker.twitter != null) {
      widgets.addAll([
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Text(
            'Twitter',
            style: theme.subhead.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: GestureDetector(
            onTap: () async {
              // Twitter prefers the '@' left off in their urls.
              final url = 'http://twitter.com/${speaker.twitter.substring(1)}';
              if (await launcher.canLaunch(url)) {
                await launcher.launch(url);
              }
            },
            child: Text(
              '${speaker.twitter}',
              style: theme.body1.copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ]);
    }

    if (speaker.blog != null) {
      widgets.addAll([
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Text(
            'Blog',
            style: theme.subhead.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: GestureDetector(
            onTap: () async {
              if (await launcher.canLaunch(speaker.blog)) {
                await launcher.launch(speaker.blog);
              }
            },
            child: Text(
              '${speaker.blog}',
              style: theme.body1.copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ]);
    }

    return widgets;
  }

  Widget _createBio(Speaker speaker, TextTheme theme) {
    if (speaker.bio != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: Text(
          speaker.bio,
          style: theme.body1,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return FirstBuildDispatcher<AppState>(
      action: RefreshSpeakerForConferenceAction(conferenceId, uuid),
      child: ViewModelSubscriber<AppState, Speaker>(
        converter: (state) => state.speakers[conferenceId]
            .firstWhere((s) => s.uuid == uuid, orElse: () => null),
        builder: (context, dispatcher, speaker) {
          if (speaker == null) {
            return InvalidNavigationNotice(
              'Unknown speaker',
              'A record for the selected speaker could not be found '
                  'or is no longer valid',
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Speaker details'),
            ),
            body: ListView(
              children: [
                SizedBox(height: 24.0),
                Center(
                  child: Avatar(
                    imageUrl: speaker.avatarURL,
                    placeholderIcon: Icons.person,
                    errorIcon: Icons.error,
                    width: 150.0,
                    height: 150.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    speaker.fullName,
                    style: theme.headline,
                  ),
                ),
                _createBio(speaker, theme),
              ]
                ..addAll(_createInfoRows(speaker, theme))
                ..add(SizedBox(height: 24.0)),
            ),
          );
        },
      ),
    );
  }
}
