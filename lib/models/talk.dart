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

part 'talk.g.dart';

abstract class Talk implements Built<Talk, TalkBuilder> {
  static Serializer<Talk> get serializer => _$talkSerializer;

  static const listSerializationType =
      const FullType(BuiltList, [FullType(Talk)]);

  String get id;

  String get title;

  String get talkType;

  String get track;

  String get lang;

  String get summary;

  BuiltList<String> get speakerUuids;

  Talk._();

  factory Talk([updates(TalkBuilder b)]) = _$Talk;
}
