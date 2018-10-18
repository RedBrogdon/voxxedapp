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

part 'speaker.g.dart';

abstract class Speaker
    implements Built<Speaker, SpeakerBuilder>, Comparable<dynamic> {
  static Serializer<Speaker> get serializer => _$speakerSerializer;

  static const listSerializationType =
      const FullType(BuiltList, [FullType(Speaker)]);

  String get uuid;

  @nullable
  String get firstName;

  @nullable
  String get lastName;

  @nullable
  String get lang;

  @nullable
  String get bioAsHtml;

  @nullable
  String get bio;

  @nullable
  String get company;

  @nullable
  String get blog;

  @nullable
  String get avatarURL;

  @nullable
  String get twitter;

  String get fullName {
    final firstStr = firstName ?? '';
    final lastStr = lastName ?? '';
    final midStr = (firstStr.length > 0 && lastStr.length > 0) ? ' ' : '';
    return '$firstStr$midStr$lastStr';
  }

  Speaker._();

  factory Speaker([updates(SpeakerBuilder b)]) = _$Speaker;

  @override
  int compareTo(dynamic other) {
    if (!identical(this, other) && other is Speaker) {
      if (lastName == other.lastName) {
        if (firstName == null && other.firstName == null) {
          return 0;
        } else if (firstName == null) {
          return -1;
        } else {
          return firstName.compareTo(other.firstName);
        }
      } else {
        if (lastName == null && other.lastName == null) {
          return 0;
        } else if (lastName == null) {
          return -1;
        } else {
          return lastName.compareTo(other.lastName);
        }
      }
    }

    // If identical or of different types, return equality, because who knows?
    return 0;
  }
}
