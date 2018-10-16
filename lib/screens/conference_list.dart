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
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/conference.dart';

class ConferenceListViewModel {
  final BuiltMap<int, Conference> conferences;

  ConferenceListViewModel(AppState state) : conferences = state.conferences;

  @override
  int get hashCode => conferences.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ConferenceListViewModel &&
              runtimeType == other.runtimeType &&
              conferences == other.conferences;
}

class ConferenceListScreen extends StatelessWidget {
  Widget _buildListItem(
      BuildContext context, Conference conference, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: GestureDetector(
        onTap: onTap,
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
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 10.0,
                  ),
                  color: Colors.white,
                  child: Text(
                    conference.name,
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
              ),
              Positioned(
                top: 10.0,
                right: 0.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 10.0,
                  ),
                  color: Color(0xa0000000),
                  child: Text(
                    '${conference.fromDate} - ${conference.endDate}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
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
      body: ViewModelSubscriber<AppState, ConferenceListViewModel>(
        converter: (state) => ConferenceListViewModel(state),
        builder: (context, dispatcher, viewModel) {
          List<Conference> conferences = viewModel.conferences.values.toList();
          return ListView.builder(
            itemCount: conferences.length,
            itemBuilder: (context, i) {
              return _buildListItem(
                context,
                conferences[i],
                () {
                  int id = conferences[i].id;
                  Navigator.of(context).pop(id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
