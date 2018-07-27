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

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:voxxedapp/models/enums.dart';

part 'conference.g.dart';

abstract class Conference implements Built<Conference, ConferenceBuilder> {
  static Serializer<Conference> get serializer =>
      _$conferenceSerializer;

  int get id;

  String get name;

  EventType get eventType;

  String get fromDate;

  String get endDate;

  String get imageURL;

  String get website;

  Conference._();

  factory Conference([updates(ConferenceBuilder b)]) =
  _$Conference;
}
