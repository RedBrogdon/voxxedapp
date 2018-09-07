import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/models/app_state.dart';

class SplashScreenViewModel {
  final bool readyToGo;
  final bool willNeverBeReadyToGo;
  final int selectedConferenceId;

  SplashScreenViewModel(AppState state)
      : readyToGo = state.readyToGo,
        willNeverBeReadyToGo = state.willNeverBeReadyToGo,
        selectedConferenceId = state.selectedConferenceId;

  @override
  int get hashCode {
    return readyToGo.hashCode ^
        willNeverBeReadyToGo.hashCode ^
        selectedConferenceId;
  }

  @override
  bool operator ==(other) {
    return other is SplashScreenViewModel &&
        this.readyToGo == other.readyToGo &&
        this.willNeverBeReadyToGo == other.willNeverBeReadyToGo &&
        this.selectedConferenceId == other.selectedConferenceId;
  }
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() {
    return new SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  static const _displayMilliseconds = 2000;
  final _timeOfCreation = DateTime.now().millisecondsSinceEpoch;
  Future<void> _redirectFuture;

  // TODO(redbrogdon): This seems like a terrible hack. Consider
  // building a ReblocRouter or something.
  void _checkAndBuildFuture(SplashScreenViewModel model) {
    if (model.readyToGo && _redirectFuture == null) {
      Duration delay;
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      // If this widget has been around for at least [_displayMilliseconds],
      // navigate to the conference details screen immediately. Otherwise
      // delay for the remaining time, and then do the navigation. This
      // guarantees the splash is up long enough for people to see the logo.
      if (currentTime - _timeOfCreation > _displayMilliseconds) {
        delay = Duration.zero;
      } else {
        final remainingTime =
            _displayMilliseconds + _timeOfCreation - currentTime;
        delay = Duration(milliseconds: remainingTime);
      }

      String destination = '/conference/${model.selectedConferenceId}';
      _redirectFuture = Future.delayed(
          delay, () => Navigator.of(context).pushReplacementNamed(destination));
    }
  }

  Widget _createStatusText(SplashScreenViewModel model, TextTheme theme) {
    String msg;

    if (model.willNeverBeReadyToGo) {
      msg = 'Failed to load conferences from the server. Please check your '
          'network access and try again later.';
    } else if (model.readyToGo) {
      msg = 'Ready to go!';
    } else {
      msg = '... loading ...';
    }

    return Text(msg, style: theme.subhead.copyWith(color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ViewModelSubscriber<AppState, SplashScreenViewModel>(
      converter: (state) => SplashScreenViewModel(state),
      builder: (context, dispatcher, model) {
        _checkAndBuildFuture(model);

        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'VoxxedDays',
                        style: theme.textTheme.display3.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'From developers, For developers',
                        style: theme.textTheme.headline.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10.0,
                left: 0.0,
                right: 0.0,
                child: Center(
                  child: _createStatusText(model, theme.textTheme),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
