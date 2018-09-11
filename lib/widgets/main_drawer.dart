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

class MainDrawer extends StatelessWidget {
  const MainDrawer();

  static const issuesUrl = 'https://github.com/redbrogdon/voxxedapp/issues';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'VoxxedDays',
                    style: theme.textTheme.display1.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'From developers, For developers',
                    style: theme.textTheme.subhead.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Select a conference'),
            onTap: () async {
              // Show the conference list to get a selection, then navigate to
              // it.
              int id = await Navigator.of(context).pushNamed('/conferences');
              Navigator.of(context).pushReplacementNamed('/conference/$id');
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About this app'),
            onTap: () {
              Navigator.of(context).pushNamed('/about');
            },
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text('Report an issue'),
            onTap: () async {
              if (await launcher.canLaunch(issuesUrl)) {
                await launcher.launch(issuesUrl);
              }
            },
          ),
        ],
      ),
    );
  }
}
