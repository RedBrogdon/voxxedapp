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

import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/models/app_state.dart';

class ToggleFavoriteAction extends Action {
  final String talkId;

  ToggleFavoriteAction(this.talkId);
}

class FavoritesBloc extends SimpleBloc<AppState> {
  @override
  AppState reducer(state, action) {
    if (action is ToggleFavoriteAction) {
      if (state.favoriteSessions.contains(action.talkId)) {
        return state.rebuild((b) => b.favoriteSessions.removeWhere((s) => s == action.talkId));
      } else {
        return state.rebuild((b) => b.favoriteSessions.add(action.talkId));
      }
    }

    return state;
  }
}
