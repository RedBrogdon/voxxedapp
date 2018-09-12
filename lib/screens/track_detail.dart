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
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/track.dart';
import 'package:voxxedapp/widgets/avatar.dart';

class TrackDetailScreen extends StatelessWidget {
  const TrackDetailScreen(this.conferenceId, this.trackId);

  final int trackId;
  final conferenceId;

  Widget _createDescription(Track track, TextTheme theme) {
    if (track.description != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: Text(
          track.description,
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

    return ViewModelSubscriber<AppState, Track>(
      converter: (state) => state.conferences[conferenceId].tracks
          .firstWhere((t) => t.id == trackId),
      builder: (context, dispatcher, track) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Conference track details'),
          ),
          body: ListView(
            children: [
              SizedBox(height: 24.0),
              Center(
                child: Avatar(
                  imageUrl: track.imageURL,
                  placeholderIcon: Icons.assignment,
                  errorIcon: Icons.error,
                  width: 150.0,
                  height: 150.0,
                  square: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  track.name,
                  style: theme.headline,
                ),
              ),
              _createDescription(track, theme),
              SizedBox(height: 24.0),
            ],
          ),
        );
      },
    );
  }
}
