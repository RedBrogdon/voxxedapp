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

class Accumulator<S extends bv.Built<S, B>, B extends bv.Builder<S, B>> {
  final Action action;
  final S state;

  const Accumulator(this.action, this.state);
}

class Store<S extends bv.Built<S, B>, B extends bv.Builder<S, B>> {
  final _dispatchController = StreamController<Action>();
  final BehaviorSubject<S> states;

  Store({
    @required S initialState,
    List<Bloc> blocs,
  }) : states = BehaviorSubject<S>(seedValue: initialState) {
    final reducerController = StreamController<Accumulator<S, B>>();
    var reducerStream = reducerController.stream;
    var dispatchStream = _dispatchController.stream;

    for (Bloc bloc in blocs) {
      dispatchStream = dispatchStream.transform(
        StreamTransformer.fromHandlers(
            handleData: (Action data, EventSink<Action> sink) {
          if (bloc.middle(this, data)) {
            sink.add(data);
          }
        }),
      );

      reducerStream = reducerStream.transform(
        StreamTransformer.fromHandlers(handleData:
            (Accumulator<S, B> data, EventSink<Accumulator<S, B>> sink) {
          final builder = bloc.reduce(this, data.state, data.action);
          sink.add(Accumulator(data.action, builder?.build() ?? data.state));
        }),
      );
    }

    // Need this to make the stream run.
    reducerController.addStream(dispatchStream
        .map<Accumulator<S, B>>((a) => Accumulator(a, states.value)));
    reducerStream.listen((a) => states.add(a.state));
  }

  get dispatch => _dispatchController.add;
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

typedef Widget ViewModelBuilder<
    S extends bv.Built<S, B>,
    B extends bv.Builder<S, B>,
    V extends ViewModel<S, B>>(BuildContext context, V viewModel);
typedef V ViewModelConverter<
    S extends bv.Built<S, B>,
    B extends bv.Builder<S, B>,
    V extends ViewModel<S, B>>(Store dispatcher, S state);

class ViewModelSubscriber<S extends bv.Built<S, B>, B extends bv.Builder<S, B>,
    V extends ViewModel<S, B>> extends StatefulWidget {
  final Store store;
  final BehaviorSubject<S> stream;
  final ViewModelConverter<S, B, V> converter;
  final ViewModelBuilder<S, B, V> builder;

  ViewModelSubscriber({
    @required this.store,
    @required this.stream,
    @required this.converter,
    @required this.builder,
  });

  @override
  _ViewModelSubscriberState createState() =>
      _ViewModelSubscriberState<S, B, V>();
}

class _ViewModelSubscriberState<
    S extends bv.Built<S, B>,
    B extends bv.Builder<S, B>,
    V extends ViewModel<S, B>> extends State<ViewModelSubscriber<S, B, V>> {
  V _latestViewModel;
  StreamSubscription<V> _subscription;

  @override
  void initState() {
    super.initState();
    _latestViewModel = widget.converter(widget.store, widget.stream.value);
    _subscription = widget.stream
        .map<V>((s) => widget.converter(widget.store, s))
        .distinct()
        .listen((viewModel) {
      setState(() => _latestViewModel = viewModel);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _subscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _latestViewModel);
  }
}

class ViewModel<S extends bv.Built<S, B>, B extends bv.Builder<S, B>> {
  final Store<S, B> store;

  const ViewModel(this.store);
}
