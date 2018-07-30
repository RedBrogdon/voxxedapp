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

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:voxxedapp/blocs/conference_bloc.dart';
import 'package:voxxedapp/models/conference.dart';

class ConferenceListScreen extends StatefulWidget {
  @override
  _ConferenceListScreenState createState() => _ConferenceListScreenState();
}

class _ConferenceListScreenState extends State<ConferenceListScreen> {
  Widget _buildTitleText(BuildContext context, Conference conference) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      color: Colors.white,
      child: Text(
        conference.name,
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  Widget _buildDateText(BuildContext context, Conference conference) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      color: Color(0xa0000000),
      child: Text(
        '${conference.fromDate} - ${conference.endDate}',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Conference conference) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/conference/${conference.id}');
        },
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(height: 300.0),
          child: Stack(
            children: [
              Positioned(
                top: 0.0,
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Image.network(
                  conference.imageURL,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x00000000),
                        Color(0x80000000),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                child: _buildTitleText(context, conference),
              ),
              Positioned(
                top: 10.0,
                right: 0.0,
                child: _buildDateText(context, conference),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Voxxed Days'),
      ),
      body: StreamBuilder<BuiltList<Conference>>(
        stream: ConferenceBlocProvider.of(context).conferences,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.hasData ? snapshot.data.length : 0,
            itemBuilder: (context, i) => _buildListItem(
                  context,
                  snapshot.data[i],
                ),
          );
        },
      ),
    );
  }
}
