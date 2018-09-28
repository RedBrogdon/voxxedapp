// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_slot.dart';

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

Serializer<ScheduleSlot> _$scheduleSlotSerializer =
    new _$ScheduleSlotSerializer();

class _$ScheduleSlotSerializer implements StructuredSerializer<ScheduleSlot> {
  @override
  final Iterable<Type> types = const [ScheduleSlot, _$ScheduleSlot];
  @override
  final String wireName = 'ScheduleSlot';

  @override
  Iterable serialize(Serializers serializers, ScheduleSlot object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'slotId',
      serializers.serialize(object.slotId,
          specifiedType: const FullType(String)),
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
      'roomName',
      serializers.serialize(object.roomName,
          specifiedType: const FullType(String)),
      'day',
      serializers.serialize(object.day, specifiedType: const FullType(String)),
      'fromTime',
      serializers.serialize(object.fromTime,
          specifiedType: const FullType(String)),
      'fromTimeMillis',
      serializers.serialize(object.fromTimeMillis,
          specifiedType: const FullType(int)),
      'toTime',
      serializers.serialize(object.toTime,
          specifiedType: const FullType(String)),
      'toTimeMillis',
      serializers.serialize(object.toTimeMillis,
          specifiedType: const FullType(int)),
    ];
    if (object.scheduleBreak != null) {
      result
        ..add('scheduleBreak')
        ..add(serializers.serialize(object.scheduleBreak,
            specifiedType: const FullType(ScheduleBreak)));
    }
    if (object.talk != null) {
      result
        ..add('talk')
        ..add(serializers.serialize(object.talk,
            specifiedType: const FullType(Talk)));
    }

    return result;
  }

  @override
  ScheduleSlot deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScheduleSlotBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'slotId':
          result.slotId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'roomId':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'roomName':
          result.roomName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'day':
          result.day = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fromTime':
          result.fromTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fromTimeMillis':
          result.fromTimeMillis = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'toTime':
          result.toTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'toTimeMillis':
          result.toTimeMillis = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'scheduleBreak':
          result.scheduleBreak.replace(serializers.deserialize(value,
              specifiedType: const FullType(ScheduleBreak)) as ScheduleBreak);
          break;
        case 'talk':
          result.talk.replace(serializers.deserialize(value,
              specifiedType: const FullType(Talk)) as Talk);
          break;
      }
    }

    return result.build();
  }
}

class _$ScheduleSlot extends ScheduleSlot {
  @override
  final String slotId;
  @override
  final String roomId;
  @override
  final String roomName;
  @override
  final String day;
  @override
  final String fromTime;
  @override
  final int fromTimeMillis;
  @override
  final String toTime;
  @override
  final int toTimeMillis;
  @override
  final ScheduleBreak scheduleBreak;
  @override
  final Talk talk;

  factory _$ScheduleSlot([void updates(ScheduleSlotBuilder b)]) =>
      (new ScheduleSlotBuilder()..update(updates)).build();

  _$ScheduleSlot._(
      {this.slotId,
      this.roomId,
      this.roomName,
      this.day,
      this.fromTime,
      this.fromTimeMillis,
      this.toTime,
      this.toTimeMillis,
      this.scheduleBreak,
      this.talk})
      : super._() {
    if (slotId == null) {
      throw new BuiltValueNullFieldError('ScheduleSlot', 'slotId');
    }
    if (roomId == null) {
      throw new BuiltValueNullFieldError('ScheduleSlot', 'roomId');
    }
    if (roomName == null) {
      throw new BuiltValueNullFieldError('ScheduleSlot', 'roomName');
    }
    if (day == null) {
      throw new BuiltValueNullFieldError('ScheduleSlot', 'day');
    }
    if (fromTime == null) {
      throw new BuiltValueNullFieldError('ScheduleSlot', 'fromTime');
    }
    if (fromTimeMillis == null) {
      throw new BuiltValueNullFieldError('ScheduleSlot', 'fromTimeMillis');
    }
    if (toTime == null) {
      throw new BuiltValueNullFieldError('ScheduleSlot', 'toTime');
    }
    if (toTimeMillis == null) {
      throw new BuiltValueNullFieldError('ScheduleSlot', 'toTimeMillis');
    }
  }

  @override
  ScheduleSlot rebuild(void updates(ScheduleSlotBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleSlotBuilder toBuilder() => new ScheduleSlotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleSlot &&
        slotId == other.slotId &&
        roomId == other.roomId &&
        roomName == other.roomName &&
        day == other.day &&
        fromTime == other.fromTime &&
        fromTimeMillis == other.fromTimeMillis &&
        toTime == other.toTime &&
        toTimeMillis == other.toTimeMillis &&
        scheduleBreak == other.scheduleBreak &&
        talk == other.talk;
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
                                $jc(
                                    $jc($jc(0, slotId.hashCode),
                                        roomId.hashCode),
                                    roomName.hashCode),
                                day.hashCode),
                            fromTime.hashCode),
                        fromTimeMillis.hashCode),
                    toTime.hashCode),
                toTimeMillis.hashCode),
            scheduleBreak.hashCode),
        talk.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ScheduleSlot')
          ..add('slotId', slotId)
          ..add('roomId', roomId)
          ..add('roomName', roomName)
          ..add('day', day)
          ..add('fromTime', fromTime)
          ..add('fromTimeMillis', fromTimeMillis)
          ..add('toTime', toTime)
          ..add('toTimeMillis', toTimeMillis)
          ..add('scheduleBreak', scheduleBreak)
          ..add('talk', talk))
        .toString();
  }
}

class ScheduleSlotBuilder
    implements Builder<ScheduleSlot, ScheduleSlotBuilder> {
  _$ScheduleSlot _$v;

  String _slotId;
  String get slotId => _$this._slotId;
  set slotId(String slotId) => _$this._slotId = slotId;

  String _roomId;
  String get roomId => _$this._roomId;
  set roomId(String roomId) => _$this._roomId = roomId;

  String _roomName;
  String get roomName => _$this._roomName;
  set roomName(String roomName) => _$this._roomName = roomName;

  String _day;
  String get day => _$this._day;
  set day(String day) => _$this._day = day;

  String _fromTime;
  String get fromTime => _$this._fromTime;
  set fromTime(String fromTime) => _$this._fromTime = fromTime;

  int _fromTimeMillis;
  int get fromTimeMillis => _$this._fromTimeMillis;
  set fromTimeMillis(int fromTimeMillis) =>
      _$this._fromTimeMillis = fromTimeMillis;

  String _toTime;
  String get toTime => _$this._toTime;
  set toTime(String toTime) => _$this._toTime = toTime;

  int _toTimeMillis;
  int get toTimeMillis => _$this._toTimeMillis;
  set toTimeMillis(int toTimeMillis) => _$this._toTimeMillis = toTimeMillis;

  ScheduleBreakBuilder _scheduleBreak;
  ScheduleBreakBuilder get scheduleBreak =>
      _$this._scheduleBreak ??= new ScheduleBreakBuilder();
  set scheduleBreak(ScheduleBreakBuilder scheduleBreak) =>
      _$this._scheduleBreak = scheduleBreak;

  TalkBuilder _talk;
  TalkBuilder get talk => _$this._talk ??= new TalkBuilder();
  set talk(TalkBuilder talk) => _$this._talk = talk;

  ScheduleSlotBuilder();

  ScheduleSlotBuilder get _$this {
    if (_$v != null) {
      _slotId = _$v.slotId;
      _roomId = _$v.roomId;
      _roomName = _$v.roomName;
      _day = _$v.day;
      _fromTime = _$v.fromTime;
      _fromTimeMillis = _$v.fromTimeMillis;
      _toTime = _$v.toTime;
      _toTimeMillis = _$v.toTimeMillis;
      _scheduleBreak = _$v.scheduleBreak?.toBuilder();
      _talk = _$v.talk?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleSlot other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ScheduleSlot;
  }

  @override
  void update(void updates(ScheduleSlotBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ScheduleSlot build() {
    _$ScheduleSlot _$result;
    try {
      _$result = _$v ??
          new _$ScheduleSlot._(
              slotId: slotId,
              roomId: roomId,
              roomName: roomName,
              day: day,
              fromTime: fromTime,
              fromTimeMillis: fromTimeMillis,
              toTime: toTime,
              toTimeMillis: toTimeMillis,
              scheduleBreak: _scheduleBreak?.build(),
              talk: _talk?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'scheduleBreak';
        _scheduleBreak?.build();
        _$failedField = 'talk';
        _talk?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ScheduleSlot', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
