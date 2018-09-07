import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/models/app_state.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() {
    return new SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  static const _displayMilliseconds = 2000;
  final _timeOfCreation = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ViewModelSubscriber<AppState, bool>(
      converter: (state) => state.readyToGo,
      builder: (context, dispatcher, ready) {
        // TODO(redbrogdon): This seems like a terrible hack. Consider
        // building a ReblocRouter or something.

        if (ready) {
          Duration delay;
          final currentTime = DateTime.now().millisecondsSinceEpoch;

          // If this widget has been around for at least [_displayMilliseconds],
          // navigate to the conference details screen immediately. Otherwise
          // delay for the remaining time, and then do the navigation. This
          // guarantees the splash is up long enough for people to see the logo.
          if (currentTime - _timeOfCreation >
              _displayMilliseconds) {
            delay = Duration.zero;
          } else {
            final remainingTime = _displayMilliseconds + _timeOfCreation - currentTime;
            delay = Duration(milliseconds: remainingTime);
          }

          Future.delayed(delay,
              () => Navigator.of(context).pushReplacementNamed('/conference/32'));
        }

        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
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
        );
      },
    );
  }
}
