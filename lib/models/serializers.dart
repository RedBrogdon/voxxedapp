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

library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:voxxedapp/models/enums.dart';
import 'package:voxxedapp/models/conference.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  EventType,
  Conference,
])

final Serializers serializers =
(_$serializers.toBuilder()
  ..addBuilderFactory(  // TODO(redbrogdon): remove this
      const FullType(BuiltList, [FullType(Conference)]),
          () => new ListBuilder<Conference>())
  ..addPlugin(StandardJsonPlugin())).build();