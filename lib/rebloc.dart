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

import 'package:flutter/foundation.dart';
import 'package:built_value/built_value.dart' as bv;
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:voxxedapp/models/app_state.dart';

// TODO(redbrogdon): make actions built.

abstract class Action {
  const Action();
}

typedef bv.Builder<S, B> Reducer<S extends bv.Built<S, B>,
    B extends bv.Builder<S, B>, A>(S state, A action);

class Store<S extends bv.Built<S, B>, B extends bv.Builder<S, B>> {
  final _actionsController = StreamController<Action>();
  final BehaviorSubject<S> states;

  Store({
    @required S initialState,
    List<Bloc> blocs,
  }) : states = BehaviorSubject<S>(seedValue: initialState) {
    for (Bloc bloc in blocs) {

    }
  }

  get actions => _actionsController.stream;

  get dispatch => _actionsController.sink;
}

class Middleware<S, T> extends StreamTransformer<S, T> {

  @override
  Stream<T> bind(Stream<S> stream) {

  }
}

abstract class Bloc<S extends bv.Built<S, B>, B extends bv.Builder<S, B>> {
  Map<Type, Future<bool> Function(Sink<Action>, S, Action)> get middleware;

  Map<Type, bv.Builder<S, B> Function(S, Action)> get reducer;
}

class StoreProvider extends InheritedWidget {
  final Store<AppState, AppStateBuilder> store;

  StoreProvider({
    @required this.store,
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Store<AppState, AppStateBuilder> of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(StoreProvider) as StoreProvider)
          .store;
}
