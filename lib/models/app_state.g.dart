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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$AppState extends AppState {
  @override
  final BuiltList<Conference> conferences;
  @override
  final BuiltMap<int, BuiltList<Speaker>> speakers;
  @override
  final int selectedConferenceId;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.conferences, this.speakers, this.selectedConferenceId})
      : super._() {
    if (conferences == null)
      throw new BuiltValueNullFieldError('AppState', 'conferences');
    if (speakers == null)
      throw new BuiltValueNullFieldError('AppState', 'speakers');
    if (selectedConferenceId == null)
      throw new BuiltValueNullFieldError('AppState', 'selectedConferenceId');
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! AppState) return false;
    return conferences == other.conferences &&
        speakers == other.speakers &&
        selectedConferenceId == other.selectedConferenceId;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, conferences.hashCode), speakers.hashCode),
        selectedConferenceId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('conferences', conferences)
          ..add('speakers', speakers)
          ..add('selectedConferenceId', selectedConferenceId))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  ListBuilder<Conference> _conferences;
  ListBuilder<Conference> get conferences =>
      _$this._conferences ??= new ListBuilder<Conference>();
  set conferences(ListBuilder<Conference> conferences) =>
      _$this._conferences = conferences;

  MapBuilder<int, BuiltList<Speaker>> _speakers;
  MapBuilder<int, BuiltList<Speaker>> get speakers =>
      _$this._speakers ??= new MapBuilder<int, BuiltList<Speaker>>();
  set speakers(MapBuilder<int, BuiltList<Speaker>> speakers) =>
      _$this._speakers = speakers;

  int _selectedConferenceId;
  int get selectedConferenceId => _$this._selectedConferenceId;
  set selectedConferenceId(int selectedConferenceId) =>
      _$this._selectedConferenceId = selectedConferenceId;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _conferences = _$v.conferences?.toBuilder();
      _speakers = _$v.speakers?.toBuilder();
      _selectedConferenceId = _$v.selectedConferenceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              conferences: conferences.build(),
              speakers: speakers.build(),
              selectedConferenceId: selectedConferenceId);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'conferences';
        conferences.build();
        _$failedField = 'speakers';
        speakers.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
