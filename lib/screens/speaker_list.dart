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

import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/widgets/main_drawer.dart';
import 'package:voxxedapp/widgets/speaker_item.dart';

class SpeakerListViewModel {
  final List<Speaker> speakers = [];

  SpeakerListViewModel(AppState state) {
    // Add the speakers from state's conf:speaker map to a single list for
    // display. They should be deduped using uuid.
    for (final list in state.speakers.values) {
      for (final speaker in list) {
        if (!speakers.any((s) => s.uuid == speaker.uuid)) {
          speakers.add(speaker);
        }
      }
    }

    // Sort list by last and first names.
    speakers.sort((a, b) {
      if (a.lastName == b.lastName) {
        return a.firstName.compareTo(b.firstName);
      } else {
        return a.lastName.compareTo(b.lastName);
      }
    });
  }

  @override
  int get hashCode {
    int hash = 0;
    for (final speaker in speakers) {
      hash ^= speaker.hashCode;
    }
    return hash;
  }

  @override
  bool operator ==(other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is SpeakerListViewModel) {
      if (this.speakers.length != other.speakers.length) {
        return false;
      }

      for (int i = 0; i < this.speakers.length; i++) {
        if (this.speakers[i] != other.speakers[i]) {
          return false;
        }
      }

      // Same length and elements.
      return true;
    }

    return false;
  }
}

class SpeakerListScreen extends StatelessWidget {
  Widget _buildSpeakerList(
      BuildContext context, BuiltList<Speaker> speakers, ThemeData theme) {
    var children = <Widget>[];

    if (speakers == null || speakers.length == 0) {
      children.add(
        Center(
          child: Text(
            'No speaker information is currently available.',
            style: theme.textTheme.body1.copyWith(fontStyle: FontStyle.italic),
          ),
        ),
      );
    } else {
      var count = 0;
      for (final speaker in speakers) {
        children.add(
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed('/speaker/${speaker.uuid}'),
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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2.0),
                      height: 50.0,
                      width: 50.0,
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
                    SizedBox(width: 12.0),
                    Text('${speaker.firstName} ${speaker.lastName}',
                        style: theme.textTheme.body1),
                  ],
                ),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Speaker list'),
      ),
      drawer: const MainDrawer(),
      body: ViewModelSubscriber<AppState, SpeakerListViewModel>(
        converter: (state) => SpeakerListViewModel(state),
        builder: (dispatcher, context, model) {
          return ListView.builder(
            itemCount: model.speakers.length,
            itemBuilder: (context, i) => SpeakerItem(
                  model.speakers[i],
                  alternateColor: i % 2 == 0,
                ),
          );
        },
      ),
    );
  }
}
