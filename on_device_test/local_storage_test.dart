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

import 'package:test_api/test_api.dart';

// This file is meant to be run from the command line like this:
//
// flutter run on_device_test/local_storage_test.dart
//
// This is necessary because the tests here require access to a working form of
// local storage, which is only available on a device or emulator.
void main() {
  group('Main test group', () {
    test('This test always passes.', () async {});
  });
}
