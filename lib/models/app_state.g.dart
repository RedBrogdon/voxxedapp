// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'conferences',
      serializers.serialize(object.conferences,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(Conference)])),
      'speakers',
      serializers.serialize(object.speakers,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(int),
            const FullType(BuiltList, const [const FullType(Speaker)])
          ])),
      'schedules',
      serializers.serialize(object.schedules,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(int),
            const FullType(BuiltList, const [const FullType(Schedule)])
          ])),
      'sessionNotifications',
      serializers.serialize(object.sessionNotifications,
          specifiedType: const FullType(
              BuiltMap, const [const FullType(String), const FullType(int)])),
      'lastNotificationId',
      serializers.serialize(object.lastNotificationId,
          specifiedType: const FullType(int)),
      'selectedConferenceId',
      serializers.serialize(object.selectedConferenceId,
          specifiedType: const FullType(int)),
      'readyToGo',
      serializers.serialize(object.readyToGo,
          specifiedType: const FullType(bool)),
      'willNeverBeReadyToGo',
      serializers.serialize(object.willNeverBeReadyToGo,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'conferences':
          result.conferences.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(Conference)
              ])) as BuiltMap);
          break;
        case 'speakers':
          result.speakers.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(BuiltList, const [const FullType(Speaker)])
              ])) as BuiltMap);
          break;
        case 'schedules':
          result.schedules.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(BuiltList, const [const FullType(Schedule)])
              ])) as BuiltMap);
          break;
        case 'sessionNotifications':
          result.sessionNotifications.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(int)
              ])) as BuiltMap);
          break;
        case 'lastNotificationId':
          result.lastNotificationId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'selectedConferenceId':
          result.selectedConferenceId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'readyToGo':
          result.readyToGo = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'willNeverBeReadyToGo':
          result.willNeverBeReadyToGo = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final BuiltMap<int, Conference> conferences;
  @override
  final BuiltMap<int, BuiltList<Speaker>> speakers;
  @override
  final BuiltMap<int, BuiltList<Schedule>> schedules;
  @override
  final BuiltMap<String, int> sessionNotifications;
  @override
  final int lastNotificationId;
  @override
  final int selectedConferenceId;
  @override
  final bool readyToGo;
  @override
  final bool willNeverBeReadyToGo;
  @override
  final int launchTime;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.conferences,
      this.speakers,
      this.schedules,
      this.sessionNotifications,
      this.lastNotificationId,
      this.selectedConferenceId,
      this.readyToGo,
      this.willNeverBeReadyToGo,
      this.launchTime})
      : super._() {
    if (conferences == null) {
      throw new BuiltValueNullFieldError('AppState', 'conferences');
    }
    if (speakers == null) {
      throw new BuiltValueNullFieldError('AppState', 'speakers');
    }
    if (schedules == null) {
      throw new BuiltValueNullFieldError('AppState', 'schedules');
    }
    if (sessionNotifications == null) {
      throw new BuiltValueNullFieldError('AppState', 'sessionNotifications');
    }
    if (lastNotificationId == null) {
      throw new BuiltValueNullFieldError('AppState', 'lastNotificationId');
    }
    if (selectedConferenceId == null) {
      throw new BuiltValueNullFieldError('AppState', 'selectedConferenceId');
    }
    if (readyToGo == null) {
      throw new BuiltValueNullFieldError('AppState', 'readyToGo');
    }
    if (willNeverBeReadyToGo == null) {
      throw new BuiltValueNullFieldError('AppState', 'willNeverBeReadyToGo');
    }
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        conferences == other.conferences &&
        speakers == other.speakers &&
        schedules == other.schedules &&
        sessionNotifications == other.sessionNotifications &&
        lastNotificationId == other.lastNotificationId &&
        selectedConferenceId == other.selectedConferenceId &&
        readyToGo == other.readyToGo &&
        willNeverBeReadyToGo == other.willNeverBeReadyToGo &&
        launchTime == other.launchTime;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, conferences.hashCode),
                                    speakers.hashCode),
                                schedules.hashCode),
                            sessionNotifications.hashCode),
                        lastNotificationId.hashCode),
                    selectedConferenceId.hashCode),
                readyToGo.hashCode),
            willNeverBeReadyToGo.hashCode),
        launchTime.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('conferences', conferences)
          ..add('speakers', speakers)
          ..add('schedules', schedules)
          ..add('sessionNotifications', sessionNotifications)
          ..add('lastNotificationId', lastNotificationId)
          ..add('selectedConferenceId', selectedConferenceId)
          ..add('readyToGo', readyToGo)
          ..add('willNeverBeReadyToGo', willNeverBeReadyToGo)
          ..add('launchTime', launchTime))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  MapBuilder<int, Conference> _conferences;
  MapBuilder<int, Conference> get conferences =>
      _$this._conferences ??= new MapBuilder<int, Conference>();
  set conferences(MapBuilder<int, Conference> conferences) =>
      _$this._conferences = conferences;

  MapBuilder<int, BuiltList<Speaker>> _speakers;
  MapBuilder<int, BuiltList<Speaker>> get speakers =>
      _$this._speakers ??= new MapBuilder<int, BuiltList<Speaker>>();
  set speakers(MapBuilder<int, BuiltList<Speaker>> speakers) =>
      _$this._speakers = speakers;

  MapBuilder<int, BuiltList<Schedule>> _schedules;
  MapBuilder<int, BuiltList<Schedule>> get schedules =>
      _$this._schedules ??= new MapBuilder<int, BuiltList<Schedule>>();
  set schedules(MapBuilder<int, BuiltList<Schedule>> schedules) =>
      _$this._schedules = schedules;

  MapBuilder<String, int> _sessionNotifications;
  MapBuilder<String, int> get sessionNotifications =>
      _$this._sessionNotifications ??= new MapBuilder<String, int>();
  set sessionNotifications(MapBuilder<String, int> sessionNotifications) =>
      _$this._sessionNotifications = sessionNotifications;

  int _lastNotificationId;
  int get lastNotificationId => _$this._lastNotificationId;
  set lastNotificationId(int lastNotificationId) =>
      _$this._lastNotificationId = lastNotificationId;

  int _selectedConferenceId;
  int get selectedConferenceId => _$this._selectedConferenceId;
  set selectedConferenceId(int selectedConferenceId) =>
      _$this._selectedConferenceId = selectedConferenceId;

  bool _readyToGo;
  bool get readyToGo => _$this._readyToGo;
  set readyToGo(bool readyToGo) => _$this._readyToGo = readyToGo;

  bool _willNeverBeReadyToGo;
  bool get willNeverBeReadyToGo => _$this._willNeverBeReadyToGo;
  set willNeverBeReadyToGo(bool willNeverBeReadyToGo) =>
      _$this._willNeverBeReadyToGo = willNeverBeReadyToGo;

  int _launchTime;
  int get launchTime => _$this._launchTime;
  set launchTime(int launchTime) => _$this._launchTime = launchTime;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _conferences = _$v.conferences?.toBuilder();
      _speakers = _$v.speakers?.toBuilder();
      _schedules = _$v.schedules?.toBuilder();
      _sessionNotifications = _$v.sessionNotifications?.toBuilder();
      _lastNotificationId = _$v.lastNotificationId;
      _selectedConferenceId = _$v.selectedConferenceId;
      _readyToGo = _$v.readyToGo;
      _willNeverBeReadyToGo = _$v.willNeverBeReadyToGo;
      _launchTime = _$v.launchTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              schedules: schedules.build(),
              sessionNotifications: sessionNotifications.build(),
              lastNotificationId: lastNotificationId,
              selectedConferenceId: selectedConferenceId,
              readyToGo: readyToGo,
              willNeverBeReadyToGo: willNeverBeReadyToGo,
              launchTime: launchTime);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'conferences';
        conferences.build();
        _$failedField = 'speakers';
        speakers.build();
        _$failedField = 'schedules';
        schedules.build();
        _$failedField = 'sessionNotifications';
        sessionNotifications.build();
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
