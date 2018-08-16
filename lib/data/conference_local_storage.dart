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
import 'dart:io';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voxxedapp/models/serializers.dart';

class ConferenceLocalStorage {
  static const String filename = 'conferences';

  const ConferenceLocalStorage();

  Future<BuiltList<Conference>> loadConferences() async {
    final file = await _getConferenceDataFile();

    if (await file.exists()) {
      final jsonStr = await file.readAsString();
      return serializers.deserialize(json.decode(jsonStr),
          specifiedType: Conference.listSerializationType);
    }

    return BuiltList<Conference>();
  }

  Future<File> saveConferences(BuiltList<Conference> conferences) async {
    final file = await _getConferenceDataFile();

    return file.writeAsString(
      json.encode(
        serializers.serialize(conferences,
            specifiedType: Conference.listSerializationType),
      ),
    );
  }

  Future<File> _getConferenceDataFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/VoxxedApp--$filename.json');
  }

  Future<Null> clear() async {
    final file = await _getConferenceDataFile();

    if (await file.exists()) {
      await file.delete();
    }
  }
}
