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

class Store<S extends bv.Built<S, B>, B extends bv.Builder<S, B>> {
  final _actionsController = StreamController<Action>();
  final BehaviorSubject<S> states;
  Stream<Action> _actions;

  Store({
    @required S initialState,
    List<Bloc> blocs,
  }) : states = BehaviorSubject<S>(seedValue: initialState) {
    _actions = _actionsController.stream;

    for (Bloc bloc in blocs) {
      _actions = _actions.transform(
        StreamTransformer.fromHandlers(
            handleData: (Action data, EventSink<Action> sink) {
          if (bloc.middle(this, data)) {
            sink.add(data);
          }
        }),
      );
    }

    S newState = states.value;

    for (Bloc bloc in blocs) {
      _actions = _actions.transform(
        StreamTransformer.fromHandlers(
            handleData: (Action data, EventSink<Action> sink) {
          final builder = bloc.reduce(this, newState, data);
          if (builder != null) {
            newState = builder.build();
          }
        }),
      );
    }

    // Need this to make the stream run.
    _actions.listen((_) {});
  }

  get dispatch => _actionsController.add;
}

abstract class Bloc<S extends bv.Built<S, B>, B extends bv.Builder<S, B>> {
  B reduce(Store<S, B> store, S state, Action action) {
    return state.toBuilder();
  }

  bool middle(Store<S, B> store, Action action) {
    return true;
  }
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
