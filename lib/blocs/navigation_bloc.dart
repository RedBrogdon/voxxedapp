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

import 'package:flutter/widgets.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:rebloc/rebloc.dart';

typedef void NewRouteCallback(Route<dynamic> route,
    Route<dynamic> previousRoute);

class StartObservingNavigationAction extends Action {}

class StopObservingNavigationAction extends Action {}

class DidPushNamedRouteAction extends Action {
  final String routeName;

  DidPushNamedRouteAction(this.routeName);
}

class PushNamedRouteAction extends Action {
  final String routeName;

  PushNamedRouteAction(this.routeName);
}

class PushNamedReplacementRouteAction extends Action {
  final String routeName;

  PushNamedReplacementRouteAction(this.routeName);
}

class LeaveSplashScreenAction extends Action {}

class PopRouteAction extends Action {}

class PopAndPushNamedRouteAction extends Action {
  final String routeName;

  PopAndPushNamedRouteAction(this.routeName);
}

// A NavigatorObserver designed to work with NavigationBloc.
//
// This observer accepts a callback in its constructor, which is invoked anytime
// it receives a `didPush` event from the Navigator it observes.
class _NavigationBlocObserver extends NavigatorObserver {
  final NewRouteCallback onActiveRouteChanged;

  _NavigationBlocObserver({this.onActiveRouteChanged});

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (onActiveRouteChanged != null) {
      onActiveRouteChanged(route, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    if (onActiveRouteChanged != null) {
      onActiveRouteChanged(newRoute, oldRoute);
    }
  }
}

/// A Bloc for observing and manipulating a [Navigator].
///
/// This class is capable of dispatching an [Action] when a [Navigator] widget
/// pushes a new route, which can be useful for example, in automatically
/// kicking off network requests absed on user navigation. It can also pop and
/// push routes based on [Action]s it receives from the dispatch stream.
class NavigationBloc extends SimpleBloc<AppState> {
  static const int _minimumSplashScreenTime = 2000;

  Future<void> _leaveSplashScreen;

  NavigationBloc() {
    observer = _NavigationBlocObserver(onActiveRouteChanged: _onDidPush);
  }

  /// NavigatorObserver that should be given the the Navigator observed by this
  /// Bloc.
  _NavigationBlocObserver observer;

  // Dispatcher that can be used to dispatch actions to the Store for which this
  // Bloc acts as middleware. This is set to a valid dispatch function when a
  // StartObservingNavigationAction is received, and reset to null when a
  // StopObservingNavigationAction is received.
  DispatchFunction _dispatcher;

  void _onDidPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (_dispatcher != null && route?.settings?.name != null) {
      _dispatcher(DidPushNamedRouteAction(route.settings.name));
    }
  }

  Action _handleLeaveSplashScreen(AppState state,
      LeaveSplashScreenAction action) {
    if (_leaveSplashScreen == null) {
      final timeSplashHasBeenUp = DateTime
          .now()
          .millisecondsSinceEpoch - state.launchTime;

      final remainingTime = (timeSplashHasBeenUp < _minimumSplashScreenTime)
          ? _minimumSplashScreenTime - timeSplashHasBeenUp
          : 0;

      final destination = '/conference/${state.selectedConferenceId}';

      _leaveSplashScreen = Future.delayed(
          Duration(milliseconds: remainingTime),
              () => observer.navigator?.pushReplacementNamed(destination));
    }

    return action;
  }

  @override
  FutureOr<Action> middleware(DispatchFunction dispatcher, AppState state,
      Action action) {
    if (action is StartObservingNavigationAction) {
      _dispatcher = dispatcher;
    } else if (action is StopObservingNavigationAction) {
      _dispatcher = null;
    } else if (action is PopRouteAction) {
      observer.navigator?.pop();
    } else if (action is PushNamedRouteAction) {
      observer.navigator?.pushNamed(action.routeName);
    } else if (action is PushNamedReplacementRouteAction) {
      observer.navigator?.pushReplacementNamed(action.routeName);
    } else if (action is PopAndPushNamedRouteAction) {
      observer.navigator?.popAndPushNamed(action.routeName);
    } else if (action is LeaveSplashScreenAction) {
      return _handleLeaveSplashScreen(state, action);
    }

    return action;
  }
}
