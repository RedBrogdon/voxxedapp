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

abstract class Action {
  const Action();
}

class Accumulator<S extends bv.Built<S, B>, B extends bv.Builder<S, B>> {
  final Action action;
  final S state;

  const Accumulator(this.action, this.state);

  Accumulator<S, B> copyWith(S newState) => Accumulator(this.action, newState);
}

typedef void DispatchFunction(Action action);

class MiddlewareContext<S extends bv.Built<S, B>, B extends bv.Builder<S, B>> {
  final DispatchFunction dispatch;
  final S state;
  final Action action;

  const MiddlewareContext(this.dispatch, this.state, this.action);
}

class Store<S extends bv.Built<S, B>, B extends bv.Builder<S, B>> {
  final _dispatchController = StreamController<MiddlewareContext<S, B>>();
  final BehaviorSubject<S> states;

  Store({
    @required S initialState,
    List<Bloc> blocs = const [],
  }) : states = BehaviorSubject<S>(seedValue: initialState) {
    final reducerController = StreamController<Accumulator<S, B>>();
    var reducerStream = reducerController.stream;
    var dispatchStream = _dispatchController.stream;

    for (Bloc bloc in blocs) {
      dispatchStream = bloc.applyMiddleware(dispatchStream);
      reducerStream = bloc.applyReducer(reducerStream);
    }

    reducerController.addStream(dispatchStream.map<Accumulator<S, B>>(
        (context) => Accumulator(context.action, states.value)));
    reducerStream.listen((a) => states.add(a.state));
  }

  get dispatch => (Action action) => _dispatchController
      .add(MiddlewareContext(dispatch, states.value, action));
}

abstract class Bloc<S extends bv.Built<S, B>, B extends bv.Builder<S, B>> {
  Stream<MiddlewareContext<S, B>> applyMiddleware(
          Stream<MiddlewareContext<S, B>> input) =>
      input;

  Stream<Accumulator<S, B>> applyReducer(Stream<Accumulator<S, B>> input) =>
      input;
}

class StoreProvider<S extends bv.Built<S, B>, B extends bv.Builder<S, B>>
    extends StatelessWidget {
  final Store<S, B> store;
  final Widget child;

  StoreProvider({
    @required this.store,
    @required this.child,
    Key key,
  }) : super(key: key);

  static Store<S, B> of<S extends bv.Built<S, B>, B extends bv.Builder<S, B>>(
    BuildContext context, {
    bool rebuildOnChange = false,
  }) {
    final Type type = _type<_InheritedStoreProvider<S, B>>();

    Widget widget = rebuildOnChange
        ? context.inheritFromWidgetOfExactType(type)
        : context.ancestorWidgetOfExactType(type);

    if (widget == null) {
      throw Exception('Couldn\'t find an StoreProvider of the correct type.');
    } else {
      return (widget as _InheritedStoreProvider<S, B>).store;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStoreProvider<S, B>(store: store, child: child);
  }

  static Type _type<T>() => T;
}

class _InheritedStoreProvider<S extends bv.Built<S, B>,
    B extends bv.Builder<S, B>> extends InheritedWidget {
  final Store<S, B> store;

  _InheritedStoreProvider({Key key, Widget child, this.store})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStoreProvider<S, B> oldWidget) =>
      (oldWidget.store != store);
}

typedef Widget ViewModelWidgetBuilder<
    S extends bv.Built<S, B>,
    B extends bv.Builder<S, B>,
    V extends ViewModel<S, B>>(BuildContext context, V viewModel);

typedef V ViewModelConverter<
    S extends bv.Built<S, B>,
    B extends bv.Builder<S, B>,
    V extends ViewModel<S, B>>(DispatchFunction dispatch, S state);

class ViewModelSubscriber<S extends bv.Built<S, B>, B extends bv.Builder<S, B>,
    V extends ViewModel<S, B>> extends StatelessWidget {
  final ViewModelConverter<S, B, V> converter;
  final ViewModelWidgetBuilder<S, B, V> builder;

  ViewModelSubscriber({
    @required this.converter,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    Store<S, B> store = StoreProvider.of<S, B>(context);
    return _ViewModelStreamBuilder<S, B, V>(
        dispatch: store.dispatch,
        stream: store.states,
        converter: converter,
        builder: builder);
  }
}

class _ViewModelStreamBuilder<
    S extends bv.Built<S, B>,
    B extends bv.Builder<S, B>,
    V extends ViewModel<S, B>> extends StatefulWidget {
  final DispatchFunction dispatch;
  final BehaviorSubject<S> stream;
  final ViewModelConverter<S, B, V> converter;
  final ViewModelWidgetBuilder<S, B, V> builder;

  _ViewModelStreamBuilder({
    @required this.dispatch,
    @required this.stream,
    @required this.converter,
    @required this.builder,
  });

  @override
  _ViewModelStreamBuilderState createState() =>
      _ViewModelStreamBuilderState<S, B, V>();
}

class _ViewModelStreamBuilderState<
    S extends bv.Built<S, B>,
    B extends bv.Builder<S, B>,
    V extends ViewModel<S, B>> extends State<_ViewModelStreamBuilder<S, B, V>> {
  V _latestViewModel;
  StreamSubscription<V> _subscription;

  @override
  void initState() {
    super.initState();
    _latestViewModel = widget.converter(widget.dispatch, widget.stream.value);
    _subscription = widget.stream
        .map<V>((s) => widget.converter(widget.dispatch, s))
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
  final DispatchFunction dispatch;

  const ViewModel(this.dispatch);
}
