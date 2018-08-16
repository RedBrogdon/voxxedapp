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
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/util/logger.dart';

class WebClient {
  static const _requestTimeoutDuration = Duration(seconds: 10);

  const WebClient();

  String createAllConferencesUrl() =>
      'https://beta.voxxeddays.com/backend/api/voxxeddays/events/future/voxxed';

  Future<BuiltList<Conference>> fetchConferences() async {
    final response = await http
        .get(createAllConferencesUrl())
        .timeout(_requestTimeoutDuration)
        .catchError((_) {
      String msg = 'Timed out fetching conferences.';
      log.warning(msg);
      throw Exception(msg);
    });

    if (response.statusCode != 200) {
      final msg = 'Failed to fetch conferences, status: ${response.statusCode}';
      log.warning(msg);
      throw Exception(msg);
    }

    final parsedJson = json.decode(response.body);
    final deserialized = serializers.deserialize(
      parsedJson,
      specifiedType: Conference.listSerializationType,
    );

    return deserialized;
  }

  String createSingleConferenceUrl(int id) =>
      'https://beta.voxxeddays.com/backend/api/voxxeddays/events/$id';

  Future<Conference> fetchConference(int id) async {
    final response = await http
        .get(createSingleConferenceUrl(id))
        .timeout(_requestTimeoutDuration)
        .catchError((_) {
      String msg = 'Timed out fetching conference $id.';
      log.warning(msg);
      throw Exception(msg);
    });

    if (response.statusCode != 200) {
      final msg = 'Failed to fetch conference $id, status: ${response
          .statusCode}';
      log.warning(msg);
      throw Exception(msg);
    }

    final parsedJson = json.decode(response.body);
    final deserialized =
        serializers.deserializeWith(Conference.serializer, parsedJson);
    return deserialized;
  }

  String createAllSpeakersUrl(String cfpVersion) =>
      'https://$cfpVersion.confinabox.com/api/conferences/$cfpVersion/speakers';

  Future<BuiltList<Speaker>> fetchSpeakers(String cfpVersion) async {
    final response = await http
        .get(createAllSpeakersUrl(cfpVersion))
        .timeout(_requestTimeoutDuration)
        .catchError((_) {
      String msg = 'Timed out fetching speakers for $cfpVersion.';
      log.warning(msg);
      throw Exception(msg);
    });

    if (response.statusCode != 200) {
      final msg =
          'Failed to fetch speakers for $cfpVersion, status: ${response.statusCode}';
      log.warning(msg);
      throw Exception(msg);
    }

    final parsedJson = json.decode(response.body);
    final deserialized = serializers.deserialize(
      parsedJson,
      specifiedType: Speaker.listSerializationType,
    );

    return deserialized;
  }
}
