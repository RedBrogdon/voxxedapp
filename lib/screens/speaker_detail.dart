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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/util/logger.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class SpeakerDetailScreen extends StatelessWidget {
  final String uuid;

  const SpeakerDetailScreen(this.uuid);

  Speaker _locateSpeaker(AppState state, String uuid) {
    for (final speakerList in state.speakers.values) {
      if (speakerList.any((s) => s.uuid == uuid)) {
        return speakerList.firstWhere((s) => s.uuid == uuid);
      }
    }

    final msg = 'Couldn\'t find speaker $uuid.';
    log.severe(msg);
    throw ArgumentError(msg);
  }

  List<Widget> _createInfoRows(Speaker speaker, TextTheme theme) {
    final widgets = <Widget>[];

    if (speaker.company != null) {
      widgets.addAll([
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Text(
            'Company',
            style: theme.subhead.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            bottom: 24.0,
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
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Text(
            'Twitter',
            style: theme.subhead.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            bottom: 24.0,
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

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Speaker details'),
      ),
      body: ViewModelSubscriber<AppState, Speaker>(
        converter: (state) => _locateSpeaker(state, uuid),
        builder: (context, dispatcher, speaker) {
          return ListView(
            children: [
              SizedBox(height: 24.0),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(2.0),
                  height: 150.0,
                  width: 150.0,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: speaker.avatarURL ??
                          'http://via.placeholder.com/50x50',
                      placeholder: CircularProgressIndicator(),
                      errorWidget: Icon(Icons.error),
                      height: 50.0,
                      width: 50.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${speaker.firstName} ${speaker.lastName}',
                  style: theme.headline,
                ),
              ),
            ]..addAll(_createInfoRows(speaker, theme)),
          );
        },
      ),
    );
  }
}
