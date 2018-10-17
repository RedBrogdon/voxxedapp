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
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/widgets/avatar.dart';

class SpeakerItem extends StatelessWidget {
  final Speaker speaker;
  final int conferenceId;
  final bool alternateColor;

  const SpeakerItem(
    this.speaker,
    this.conferenceId, {
    this.alternateColor,
  });

  String get dest =>
      '/conference/$conferenceId/speaker/300'; //${speaker.uuid}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

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
            children: [
              Avatar(
                imageUrl: speaker.avatarURL,
                placeholderIcon: Icons.person,
                errorIcon: Icons.error,
                width: 50.0,
                height: 50.0,
              ),
              SizedBox(width: 12.0),
              Text(
                '${speaker.firstName} ${speaker.lastName}',
                style: theme.subhead,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
