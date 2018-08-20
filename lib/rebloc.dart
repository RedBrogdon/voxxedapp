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
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class Action {
  const Action();
}

class Accumulator<S> {
  final Action action;
  final S state;

  const Accumulator(this.action, this.state);

  Accumulator<S> copyWith(S newState) => Accumulator(this.action, newState);
}

typedef void DispatchFunction(Action action);

class MiddlewareContext<S> {
  final DispatchFunction dispatcher;
  final S state;
  final Action action;

  const MiddlewareContext(this.dispatcher, this.state, this.action);
}

class Store<S> {
  final _dispatchController = StreamController<MiddlewareContext<S>>();
  final BehaviorSubject<S> states;

  Store({
    @required S initialState,
    List<Bloc> blocs = const [],
  }) : states = BehaviorSubject<S>(seedValue: initialState) {
    final reducerController = StreamController<Accumulator<S>>();
    var reducerStream = reducerController.stream;
    var dispatchStream = _dispatchController.stream;

    for (Bloc bloc in blocs) {
      dispatchStream = bloc.applyMiddleware(dispatchStream);
      reducerStream = bloc.applyReducer(reducerStream);
    }

    reducerController.addStream(dispatchStream.map<Accumulator<S>>(
        (context) => Accumulator(context.action, states.value)));
    reducerStream.listen((a) => states.add(a.state));
  }

  get dispatcher => (Action action) => _dispatchController
      .add(MiddlewareContext(dispatcher, states.value, action));
}

abstract class Bloc<S> {
  Stream<MiddlewareContext<S>> applyMiddleware(
          Stream<MiddlewareContext<S>> input) =>
      input;

  Stream<Accumulator<S>> applyReducer(Stream<Accumulator<S>> input) => input;
}

class StoreProvider<S> extends StatelessWidget {
  final Store<S> store;
  final Widget child;

  StoreProvider({
    @required this.store,
    @required this.child,
    Key key,
  }) : super(key: key);

  static Store<S> of<S>(
    BuildContext context, {
    bool rebuildOnChange = false,
  }) {
    final Type type = _type<_InheritedStoreProvider<S>>();

    Widget widget = rebuildOnChange
        ? context.inheritFromWidgetOfExactType(type)
        : context.ancestorWidgetOfExactType(type);

    if (widget == null) {
      throw Exception('Couldn\'t find an StoreProvider of the correct type.');
    } else {
      return (widget as _InheritedStoreProvider<S>).store;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStoreProvider<S>(store: store, child: child);
  }

  static Type _type<T>() => T;
}

class _InheritedStoreProvider<S> extends InheritedWidget {
  final Store<S> store;

  _InheritedStoreProvider({Key key, Widget child, this.store})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStoreProvider<S> oldWidget) =>
      (oldWidget.store != store);
}

typedef Widget ViewModelWidgetBuilder<S, V extends ViewModel<S>>(
    BuildContext context, V viewModel);

typedef V ViewModelConverter<S, V extends ViewModel<S>>(
    DispatchFunction dispatcher, S state);

class ViewModelSubscriber<S, V extends ViewModel<S>> extends StatelessWidget {
  final ViewModelConverter<S, V> converter;
  final ViewModelWidgetBuilder<S, V> builder;

  ViewModelSubscriber({
    @required this.converter,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    Store<S> store = StoreProvider.of<S>(context);
    return _ViewModelStreamBuilder<S, V>(
        dispatcher: store.dispatcher,
        stream: store.states,
        converter: converter,
        builder: builder);
  }
}

class _ViewModelStreamBuilder<S, V extends ViewModel<S>>
    extends StatefulWidget {
  final DispatchFunction dispatcher;
  final BehaviorSubject<S> stream;
  final ViewModelConverter<S, V> converter;
  final ViewModelWidgetBuilder<S, V> builder;

  _ViewModelStreamBuilder({
    @required this.dispatcher,
    @required this.stream,
    @required this.converter,
    @required this.builder,
  });

  @override
  _ViewModelStreamBuilderState createState() =>
      _ViewModelStreamBuilderState<S, V>();
}

class _ViewModelStreamBuilderState<S, V extends ViewModel<S>>
    extends State<_ViewModelStreamBuilder<S, V>> {
  V _latestViewModel;
  StreamSubscription<V> _subscription;

  @override
  void initState() {
    super.initState();
    _latestViewModel = widget.converter(widget.dispatcher, widget.stream.value);
    _subscription = widget.stream
        .map<V>((s) => widget.converter(widget.dispatcher, s))
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

class ViewModel<S> {
  final DispatchFunction dispatcher;

  const ViewModel(this.dispatcher);
}
