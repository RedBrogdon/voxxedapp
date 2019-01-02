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
import 'package:voxxedapp/blocs/favorites_bloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/schedule_slot.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/models/track.dart';
import 'package:voxxedapp/util/string_utils.dart' as strutils;
import 'package:voxxedapp/widgets/invalid_navigation_notice.dart';
import 'package:voxxedapp/widgets/speaker_item.dart';
import 'package:voxxedapp/widgets/track_item.dart';

class TalkDetailViewModel {
  ScheduleSlot slot;
  final speakers = <Speaker>[];
  Track track;
  bool isFavorite;

  // Use the provided arguments to locate the correct schedule slot in [state],
  // or throw an error if it cannot be located.
  TalkDetailViewModel(AppState state, int conferenceId, String talkId) {
    slot = state.schedules[conferenceId]
        ?.firstWhere((sch) => sch.slots.any((s) => s.talk?.id == talkId),
            orElse: () => null)
        ?.slots
        ?.firstWhere((s) => s.talk?.id == talkId, orElse: () => null);

    if (slot != null) {
      track = state.conferences[conferenceId].tracks
          .firstWhere((t) => t.name == slot.talk.track, orElse: () => null);

      for (final uuid in slot.talk.speakerUuids) {
        final speaker = state.speakers[conferenceId]
            ?.firstWhere((s) => s.uuid == uuid, orElse: () => null);
        if (speaker != null) {
          speakers.add(speaker);
        }
      }

      isFavorite = state.sessionNotifications.containsKey(talkId);
    }
  }

  @override
  int get hashCode {
    int hash = slot.hashCode ^ track.hashCode ^ isFavorite.hashCode;

    if (speakers != null) {
      for (final speaker in speakers) {
        hash = hash ^ speaker.hashCode;
      }
    }

    return hash;
  }

  @override
  bool operator ==(other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is TalkDetailViewModel) {
      if (slot != other.slot ||
          track != other.track ||
          isFavorite != other.isFavorite ||
          speakers?.length != other.speakers?.length) {
        return false;
      }

      if (speakers != null && speakers.length > 0) {
        for (int i = 0; i < speakers.length; i++) {
          if (speakers[i] != other.speakers[i]) {
            return false;
          }
        }
      }
    }

    return false;
  }
}

class TalkDetailScreen extends StatelessWidget {
  const TalkDetailScreen(this.conferenceId, this.talkId);

  final conferenceId;
  final String talkId;

  String _convertLanguageCode(String code) {
    switch (code.toLowerCase()) {
      case 'en':
        return 'English';
      case 'fr':
      default:
        return 'French';
    }
  }

  String _createTimeString(TalkDetailViewModel model) {
    if (model.slot.day == null ||
        model.slot.fromTime == null ||
        model.slot.toTime == null) {
      return '';
    }

    return '${strutils.capitalize(model.slot.day)}, ${model.slot.fromTime}'
        ' to ${model.slot.toTime}';
  }

  List<Widget> _createInfoRows(TalkDetailViewModel model, TextTheme theme) {
    final widgets = <Widget>[];

    widgets.addAll([
      Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
        child: Text(
          model.slot.talk.title,
          style: theme.headline,
        ),
      ),
    ]);

    widgets.add(
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _createTimeString(model),
                style: theme.subhead.copyWith(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.slot.roomName ?? '',
              style: theme.subhead.copyWith(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    widgets.addAll([
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: Text(
          model.slot.talk.talkType,
          style: theme.subhead.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: Text(
          _convertLanguageCode(model.slot.talk.lang),
          style: theme.subhead.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    ]);

    widgets.add(
      Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
        child: Text(
          model.slot.talk.summary,
          style: theme.body1,
        ),
      ),
    );

    if (model.track != null) {
      widgets.addAll([
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Text(
            'Track',
            style: theme.subhead.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        TrackItem(model.track, conferenceId, alternateColor: true),
        SizedBox(height: 8.0),
      ]);
    }

    if (model.speakers.length > 0) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Text(
            model.speakers.length > 1 ? 'Speakers' : 'Speaker',
            style: theme.subhead.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    int rowCount = 0;

    for (final speaker in model.speakers) {
      widgets.add(
        SpeakerItem(
          speaker,
          conferenceId,
          alternateColor: rowCount % 2 == 0,
        ),
      );
    }

    widgets.add(SizedBox(height: 16.0));

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ViewModelSubscriber<AppState, TalkDetailViewModel>(
      converter: (state) => TalkDetailViewModel(state, conferenceId, talkId),
      builder: (context, dispatcher, model) {
        if (model.slot == null) {
          // Talk was not found.
          return InvalidNavigationNotice(
            'Talk not found',
            'The selected conference session could not be found. '
                'or is no longer valid',
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Talk details'),
          ),
          body: ListView(
            children: _createInfoRows(model, textTheme),
          ),
          floatingActionButton: Builder(
            // Needed to get a context w/ Scaffold.
            builder: (context) => FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text(model.isFavorite
                            ? 'Removing this talk from your list of favorites.'
                            : 'Adding this talk to your list of favorites.'),
                      ),
                    );
                    dispatcher(ToggleFavoriteAction(conferenceId, talkId));
                  },
                  child: Icon(model.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                ),
          ),
        );
      },
    );
  }
}
