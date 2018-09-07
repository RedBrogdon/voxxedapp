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
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/serializers.dart';

class AppStateLocalStorage {
  static const String filename = 'app_state';

  const AppStateLocalStorage();

  Future<AppState> loadAppState() async {
    final file = await _getAppStateDataFile();

    if (await file.exists()) {
      final jsonStr = await file.readAsString();
      return serializers.deserializeWith(
          AppState.serializer, json.decode(jsonStr));
    }

    return null;
  }

  Future<File> saveAppState(AppState state) async {
    final file = await _getAppStateDataFile();

    return file.writeAsString(
      json.encode(serializers.serialize(state)),
    );
  }

  Future<File> _getAppStateDataFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/VoxxedApp--$filename.json');
  }

  Future<Null> clear() async {
    final file = await _getAppStateDataFile();

    if (await file.exists()) {
      await file.delete();
    }
  }
}
