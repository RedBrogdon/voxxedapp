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

typedef void NewRouteCallback(
    Route<dynamic> route, Route<dynamic> previousRoute);

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

/// A Bloc for manipulating a [Navigator].
///
/// This class will push and pop named [Route]s on a [Navigator] in response to
/// incoming [Action]s. It interacts only with the middleware stream, and does
/// not make any changes to app state.
class NavigationBloc extends SimpleBloc<AppState> {
  NavigationBloc(this.navigatorKey) : assert(navigatorKey != null);

  // Minimum time the splash screen should be displayed.
  static const int _minimumSplashScreenTime = 2000;

  // Delayed future responsible for transitioning away from the splash screen.
  Future<void> _leaveSplashScreen;

  // Key to the [Navigator] widget this Bloc manages.
  final GlobalKey<NavigatorState> navigatorKey;

  void _handleLeaveSplashScreen(
      AppState state, LeaveSplashScreenAction action) {
    if (_leaveSplashScreen == null) {
      final timeSplashHasBeenUp =
          DateTime.now().millisecondsSinceEpoch - state.launchTime;

      final remainingTime = (timeSplashHasBeenUp < _minimumSplashScreenTime)
          ? _minimumSplashScreenTime - timeSplashHasBeenUp
          : 0;

      final destination = '/conference/${state.selectedConferenceId}';

      _leaveSplashScreen = Future.delayed(Duration(milliseconds: remainingTime),
          () => navigatorKey.currentState?.pushReplacementNamed(destination));
    }
  }

  @override
  FutureOr<Action> middleware(
      DispatchFunction dispatcher, AppState state, Action action) {
    if (action is PopRouteAction) {
      navigatorKey.currentState?.pop();
    } else if (action is PushNamedRouteAction) {
      navigatorKey.currentState?.pushNamed(action.routeName);
    } else if (action is PushNamedReplacementRouteAction) {
      navigatorKey.currentState?.pushReplacementNamed(action.routeName);
    } else if (action is PopAndPushNamedRouteAction) {
      navigatorKey.currentState?.popAndPushNamed(action.routeName);
    } else if (action is LeaveSplashScreenAction) {
      _handleLeaveSplashScreen(state, action);
    }

    return action;
  }
}
