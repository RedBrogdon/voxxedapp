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

import 'package:built_collection/built_collection.dart';
import 'package:voxxedapp/data/web_client.dart';
import 'package:voxxedapp/models/schedule.dart';
import 'package:voxxedapp/models/schedule_slot.dart';

class ScheduleRepository {
  final WebClient webClient;

  const ScheduleRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<Schedule>> refreshSchedules(
      String cfpUrl, String cfpVersion) async {
    final speakers = await webClient.fetchSchedules(cfpUrl, cfpVersion);
    return BuiltList<Schedule>(speakers);
  }

  Future<BuiltList<ScheduleSlot>> refreshScheduleSlots(
      String cfpUrl, String cfpVersion, String uuid) async {
    return await webClient.fetchScheduleSlots(cfpUrl, cfpVersion, uuid);
  }
}
