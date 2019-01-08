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

  // Due to the way GitHub's issue templates work, I don't believe it's possible
  // to point someone directly at the correct template. So these are identical
  // for now. If I learn of a better solution, they'll be updated.
  static const issuesUrl =
      'https://github.com/devoxx/voxxedapp/issues/new/choose';
  static const newFeatureUrl =
      'https://github.com/devoxx/voxxedapp/issues/new/choose';

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
              // whatever conference they select (a null id indicates the user
              // backed out without selecting one).
              int id = await Navigator.of(context).pushNamed('/conferences');
              if (id != null) {
                Navigator.of(context).pushReplacementNamed('/conference/$id');
              }
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
          ListTile(
            leading: Icon(Icons.add_comment),
            title: Text('Request a feature for this app'),
            onTap: () async {
              if (await launcher.canLaunch(newFeatureUrl)) {
                await launcher.launch(newFeatureUrl);
              }
            },
          ),
        ],
      ),
    );
  }
}
