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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class AboutScreen extends StatelessWidget {
  static const String gitHubUrl = 'https://github.com/redbrogdon/voxxedapp';
  static const String flutterUrl = 'https://flutter.io';

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About the Voxxed Days app',
                style: textTheme.headline,
              ),
              SizedBox(height: 16.0),
              Text(
                'This open source app was created by the Voxxed Days team in '
                    'partnership with the Flutter community. If you like it, '
                    'you can join the team of contributors who keep it running',
                style: textTheme.subhead,
              ),
              SizedBox(height: 16.0),
              RaisedButton(
                onPressed: () async {
                  if (await launcher.canLaunch(gitHubUrl)) {
                    await launcher.launch(gitHubUrl);
                  }
                },
                child: Text('SEE THIS APP\'S SOURCE'),
              ),
              SizedBox(height: 24.0),
              Text(
                'Flutter is Google\'s open source mobile SDK for creating '
                    'native iOS and Android apps from a single codebase.',
                style: textTheme.subhead,
              ),
              SizedBox(height: 16.0),
              RaisedButton(
                onPressed: () async {
                  if (await launcher.canLaunch(flutterUrl)) {
                    await launcher.launch(flutterUrl);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlutterLogo(),
                    SizedBox(width: 8.0),
                    Text('LEARN MORE ABOUT FLUTTER'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
