// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_break.dart';

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

Serializer<ScheduleBreak> _$scheduleBreakSerializer =
    new _$ScheduleBreakSerializer();

class _$ScheduleBreakSerializer implements StructuredSerializer<ScheduleBreak> {
  @override
  final Iterable<Type> types = const [ScheduleBreak, _$ScheduleBreak];
  @override
  final String wireName = 'ScheduleBreak';

  @override
  Iterable serialize(Serializers serializers, ScheduleBreak object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'nameEN',
      serializers.serialize(object.nameEN,
          specifiedType: const FullType(String)),
      'nameFR',
      serializers.serialize(object.nameFR,
          specifiedType: const FullType(String)),
      'room',
      serializers.serialize(object.room, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ScheduleBreak deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScheduleBreakBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nameEN':
          result.nameEN = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nameFR':
          result.nameFR = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'room':
          result.room = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ScheduleBreak extends ScheduleBreak {
  @override
  final String id;
  @override
  final String nameEN;
  @override
  final String nameFR;
  @override
  final String room;

  factory _$ScheduleBreak([void updates(ScheduleBreakBuilder b)]) =>
      (new ScheduleBreakBuilder()..update(updates)).build();

  _$ScheduleBreak._({this.id, this.nameEN, this.nameFR, this.room})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('ScheduleBreak', 'id');
    }
    if (nameEN == null) {
      throw new BuiltValueNullFieldError('ScheduleBreak', 'nameEN');
    }
    if (nameFR == null) {
      throw new BuiltValueNullFieldError('ScheduleBreak', 'nameFR');
    }
    if (room == null) {
      throw new BuiltValueNullFieldError('ScheduleBreak', 'room');
    }
  }

  @override
  ScheduleBreak rebuild(void updates(ScheduleBreakBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleBreakBuilder toBuilder() => new ScheduleBreakBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleBreak &&
        id == other.id &&
        nameEN == other.nameEN &&
        nameFR == other.nameFR &&
        room == other.room;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), nameEN.hashCode), nameFR.hashCode),
        room.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ScheduleBreak')
          ..add('id', id)
          ..add('nameEN', nameEN)
          ..add('nameFR', nameFR)
          ..add('room', room))
        .toString();
  }
}

class ScheduleBreakBuilder
    implements Builder<ScheduleBreak, ScheduleBreakBuilder> {
  _$ScheduleBreak _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _nameEN;
  String get nameEN => _$this._nameEN;
  set nameEN(String nameEN) => _$this._nameEN = nameEN;

  String _nameFR;
  String get nameFR => _$this._nameFR;
  set nameFR(String nameFR) => _$this._nameFR = nameFR;

  String _room;
  String get room => _$this._room;
  set room(String room) => _$this._room = room;

  ScheduleBreakBuilder();

  ScheduleBreakBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _nameEN = _$v.nameEN;
      _nameFR = _$v.nameFR;
      _room = _$v.room;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleBreak other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ScheduleBreak;
  }

  @override
  void update(void updates(ScheduleBreakBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ScheduleBreak build() {
    final _$result = _$v ??
        new _$ScheduleBreak._(
            id: id, nameEN: nameEN, nameFR: nameFR, room: room);
    replace(_$result);
    return _$result;
  }
}
