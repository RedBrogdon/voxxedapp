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
import 'package:voxxedapp/models/speaker.dart';

class SpeakerItem extends StatelessWidget {
  final Speaker speaker;
  final bool alternateColor;

  const SpeakerItem(
    this.speaker, {
    this.alternateColor,
  });

  Widget _createFailIcon(IconData iconData) {
    return Container(
      color: Color(0x40000000),
      child: Icon(
        iconData,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/speaker/${speaker.uuid}'),
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
                  child: speaker.avatarURL != null
                      ? CachedNetworkImage(
                          imageUrl: speaker.avatarURL,
                          placeholder: _createFailIcon(Icons.person),
                          errorWidget: _createFailIcon(Icons.error),
                          height: 50.0,
                          width: 50.0,
                          fit: BoxFit.cover,
                        )
                      : _createFailIcon(Icons.person),
                ),
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
