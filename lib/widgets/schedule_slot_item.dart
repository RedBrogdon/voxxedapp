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
import 'package:voxxedapp/models/schedule_slot.dart';
import 'package:voxxedapp/models/speaker.dart';

class TalkItem extends StatelessWidget {
  final ScheduleSlot slot;
  final int conferenceId;
  final List<Speaker> speakers;
  final bool alternateColor;
  final bool isFavorite;

  const TalkItem(
    this.slot,
    this.conferenceId,
    this.speakers,
    this.alternateColor,
    this.isFavorite,
  );

  String get dest => '/conference/$conferenceId/talk/${slot.talk.id}';

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    var speakerText = StringBuffer();

    for (final speaker in speakers) {
      if (speakerText.length > 0) {
        speakerText.write(', ');
      }

      speakerText.write(speaker.fullName);
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(dest);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: alternateColor ? Color(0x08000000) : Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        isFavorite
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.favorite_border),
                              )
                            : Container(),
                        Expanded(
                          child: Text(
                            slot.talk.title,
                            style: textTheme.subhead.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      speakerText.length > 0
                          ? speakerText.toString()
                          : 'Speaker not yet confirmed',
                      style:
                          textTheme.body1.copyWith(fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 4.0),
                    Text(slot.roomName),
                  ],
                ),
              ),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }
}

class BreakItem extends StatelessWidget {
  final ScheduleSlot slot;

  const BreakItem(
    this.slot,
  );

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xffd0d0d0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 8.0,
        ),
        child: Center(
          child: Text(
            slot.talk.title,
            style: Theme.of(context).textTheme.subhead.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}

class ScheduleSlotItem extends StatelessWidget {
  final ScheduleSlot slot;
  final List<Speaker> speakers;
  final int conferenceId;
  final bool alternateColor;
  final bool isFavorite;

  const ScheduleSlotItem(
    this.slot,
    this.conferenceId,
    this.speakers, {
    this.alternateColor = false,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    if (slot.talk != null) {
      // If the talk object isn't null, the slot is guaranteed to be a talk.
      return TalkItem(slot, conferenceId, speakers, alternateColor, isFavorite);
    } else {
      // Otherwise, it's a break.
      return BreakItem(slot);
    }
  }
}
