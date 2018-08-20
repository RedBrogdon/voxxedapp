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

import 'package:logging/logging.dart';

final Logger log = new Logger('VoxLog')
  ..onRecord.listen((LogRecord rec) {
    print('VOXLOG ${rec.level.name}: ${rec.message}');
  });

void logObject(String msg, Object o) {
  log.info(msg);
  for (String line in o.toString().split('\n')) {
    log.info('-- $line');
  }
}
