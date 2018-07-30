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

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:built_collection/built_collection.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/models/serializers.dart';

class WebClient {
  static const allConferencesUrl =
      'https://s3-eu-west-1.amazonaws.com/thewebsites/futureVoxxed.json';

  const WebClient();

  Future<BuiltList<Conference>> fetchConferences() async {
    final response = await http.get(allConferencesUrl);

    if (response.statusCode != 200) {
      print('Failed to fetch conferences, status: ${response.statusCode}');
      return BuiltList<Conference>([]);
    }

    return serializers.deserialize(
      json.decode(response.body),
      specifiedType: Conference.listSerializationType,
    );
  }
}
