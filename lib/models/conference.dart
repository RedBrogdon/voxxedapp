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
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:voxxedapp/models/enums.dart';
import 'package:voxxedapp/models/session_type.dart';
import 'package:voxxedapp/models/track.dart';
import 'package:voxxedapp/models/language.dart';

part 'conference.g.dart';

abstract class Conference implements Built<Conference, ConferenceBuilder> {
  static Serializer<Conference> get serializer => _$conferenceSerializer;

  static const listSerializationType =
      const FullType(BuiltList, [FullType(Conference)]);

  int get id;

  String get name;

  String get website;

  String get imageURL;

  String get fromDate;

  String get endDate;

  EventType get eventType;

  @nullable
  String get description;

  @nullable
  String get scheduleURL;

  @nullable
  String get eventImagesURL;

  @nullable
  String get youTubeURL;

  @nullable
  String get cfpURL;

  @nullable
  bool get archived;

  @nullable
  bool get cfpActive;

  @nullable
  int get locationId;

  @nullable
  String get locationName;

  @nullable
  String get timezone;

  @nullable
  String get cfpFromDate;

  @nullable
  String get cfpEndDate;

  @nullable
  String get cfpVersion;

  BuiltList<Track> get tracks;

  BuiltList<Language> get languages;

  BuiltList<SessionType> get sessionTypes;

  Conference._();

  factory Conference([updates(ConferenceBuilder b)]) = _$Conference;
}
