import 'package:built_collection/built_collection.dart';

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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/blocs/schedule_bloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/models/schedule.dart';
import 'package:voxxedapp/models/schedule_slot.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/widgets/avatar.dart';
import 'package:voxxedapp/widgets/main_drawer.dart';
import 'package:voxxedapp/widgets/schedule_slot_item.dart';
import 'package:voxxedapp/widgets/speaker_item.dart';
import 'package:voxxedapp/util/string_utils.dart' as strutils;
import 'package:voxxedapp/widgets/track_item.dart';

class SpeakerPanel extends StatelessWidget {
  const SpeakerPanel(this.conferenceId);

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Not yet determined.',
                style:
                    theme.textTheme.body1.copyWith(fontStyle: FontStyle.italic),
              ),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Not yet determined.',
            style: theme.textTheme.body1.copyWith(fontStyle: FontStyle.italic),
          ),
        ),
      );
    } else {
      var count = 0;
      for (final track in conference.tracks) {
        children.add(
            TrackItem(track, conferenceId, alternateColor: count % 2 == 0));
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

class ScheduleSlotViewModel {
  final int conferenceId;
  final speakers = <Speaker>[];
  ScheduleSlot slot;
  bool isFavorite;

  ScheduleSlotViewModel(
      AppState state, this.conferenceId, String day, String id) {
    // Find a slot for the given conference with a Talk Id that matches id.
    final slot = state.schedules[conferenceId]
        ?.firstWhere((sch) => sch.day == day, orElse: () => null)
        ?.slots
        ?.firstWhere((s) => s.talk?.id == id, orElse: () => null);

    if (slot == null) {
      throw ArgumentError(
          'ScheduleSlotViewModel couldn\'t locate slot $id for conference $conferenceId.');
    }

    if (slot.talk != null) {
      isFavorite = state.favoriteSessions.contains(slot.talk.id);
    } else {
      isFavorite = false;
    }

    for (final uuid in slot.talk.speakerUuids) {
      final speaker = state.speakers[conferenceId]
          ?.firstWhere((s) => s.uuid == uuid, orElse: () => null);
      if (speaker != null) {
        speakers.add(speaker);
      }
    }
  }

  @override
  int get hashCode {
    int hash = slot.hashCode ^ conferenceId.hashCode;
    for (final speaker in speakers) {
      hash ^= speaker.hashCode;
    }
    return hash;
  }

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;

    if (other is ScheduleSlotViewModel) {
      if (conferenceId != other.conferenceId ||
          slot != slot ||
          speakers?.length != other.speakers?.length) {
        return false;
      }

      if (speakers != null && speakers.length > 0) {
        for (int i = 0; i < speakers.length; i++) {
          if (speakers[i] != other.speakers[i]) return false;
        }
      }

      return true;
    }

    return false;
  }
}

class SchedulePanel extends StatelessWidget {
  const SchedulePanel(this.conferenceId);

  final int conferenceId;

  List<Widget> _buildScheduleWidgets(Schedule sched, ThemeData theme) {
    final widgets = <Widget>[];

    widgets.add(
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          strutils.capitalize(sched.day),
          style: theme.textTheme.headline,
        ),
      ),
    );

    for (final slot in sched.slots) {
      widgets.add(ViewModelSubscriber<AppState, ScheduleSlotViewModel>(
        converter: (state) => ScheduleSlotViewModel(state, conferenceId,
            slot.day, slot.talk?.id ?? slot.scheduleBreak.id),
        builder: (context, dispatcher, viewModel) {
          return ScheduleSlotItem(slot, conferenceId, viewModel.speakers, isFavorite: viewModel.isFavorite);
        },
      ));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelSubscriber<AppState, BuiltList<Schedule>>(
      converter: (state) => state.schedules[conferenceId],
      builder: (context, dispatcher, schedules) {
        final children = <Widget>[];

        for (Schedule sched in schedules) {
          children.addAll(_buildScheduleWidgets(sched, theme));
          children.add(SizedBox(height: 16.0));
        }

        return ListView(
          children: children,
        );
      },
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
      body = SchedulePanel(widget.conferenceId);
    } else {
      body = SpeakerPanel(widget.conferenceId);
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
      bottomNavigationBar: ViewModelSubscriber<AppState, String>(
        converter: (state) => state.conferences[widget.conferenceId].name,
        builder: (context, dispatcher, viewModel) {
          return BottomNavigationBar(
            onTap: (index) {
              if (index == 1) {
                dispatcher(RefreshSchedulesAction(widget.conferenceId));
              }
              setState(() => navBarSelection = index);
            },
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
          );
        },
      ),
    );
  }
}
