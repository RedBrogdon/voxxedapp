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

part 'track.g.dart';

abstract class Track implements Built<Track, TrackBuilder> {
  static Serializer<Track> get serializer => _$trackSerializer;

  int get id;

  String get name;

  String get description;

  @nullable
  String get imageURL;

  @nullable
  int get categoryId;

  @nullable
  String get categoryName;

  Track._();

  factory Track([updates(TrackBuilder b)]) = _$Track;
}
