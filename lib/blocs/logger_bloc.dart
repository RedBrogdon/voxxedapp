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

import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/rebloc.dart';
import 'package:voxxedapp/util/logger.dart';

class LoggerBloc extends Bloc<AppState, AppStateBuilder> {
  @override
  Stream<MiddlewareContext<AppState, AppStateBuilder>> applyMiddleware(
      Stream<MiddlewareContext<AppState, AppStateBuilder>> input) {
    return input.transform(
      StreamTransformer.fromHandlers(
        handleData: (context, sink) {
          log.info('ACTION: ${context.action.runtimeType}');
          sink.add(context);
        },
      ),
    );
  }
}
