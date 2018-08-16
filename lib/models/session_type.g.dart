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

part of 'session_type.dart';

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

Serializer<SessionType> _$sessionTypeSerializer = new _$SessionTypeSerializer();

class _$SessionTypeSerializer implements StructuredSerializer<SessionType> {
  @override
  final Iterable<Type> types = const [SessionType, _$SessionType];
  @override
  final String wireName = 'SessionType';

  @override
  Iterable serialize(Serializers serializers, SessionType object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'pause',
      serializers.serialize(object.pause, specifiedType: const FullType(bool)),
      'duration',
      serializers.serialize(object.duration,
          specifiedType: const FullType(int)),
    ];
    if (object.color != null) {
      result
        ..add('color')
        ..add(serializers.serialize(object.color,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  SessionType deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new SessionTypeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pause':
          result.pause = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'color':
          result.color = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SessionType extends SessionType {
  @override
  final int id;
  @override
  final String code;
  @override
  final String name;
  @override
  final bool pause;
  @override
  final int duration;
  @override
  final String color;

  factory _$SessionType([void updates(SessionTypeBuilder b)]) =>
      (new SessionTypeBuilder()..update(updates)).build();

  _$SessionType._(
      {this.id, this.code, this.name, this.pause, this.duration, this.color})
      : super._() {
    if (id == null) throw new BuiltValueNullFieldError('SessionType', 'id');
    if (code == null) throw new BuiltValueNullFieldError('SessionType', 'code');
    if (name == null) throw new BuiltValueNullFieldError('SessionType', 'name');
    if (pause == null)
      throw new BuiltValueNullFieldError('SessionType', 'pause');
    if (duration == null)
      throw new BuiltValueNullFieldError('SessionType', 'duration');
  }

  @override
  SessionType rebuild(void updates(SessionTypeBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionTypeBuilder toBuilder() => new SessionTypeBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! SessionType) return false;
    return id == other.id &&
        code == other.code &&
        name == other.name &&
        pause == other.pause &&
        duration == other.duration &&
        color == other.color;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, id.hashCode), code.hashCode), name.hashCode),
                pause.hashCode),
            duration.hashCode),
        color.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SessionType')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('pause', pause)
          ..add('duration', duration)
          ..add('color', color))
        .toString();
  }
}

class SessionTypeBuilder implements Builder<SessionType, SessionTypeBuilder> {
  _$SessionType _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _code;
  String get code => _$this._code;
  set code(String code) => _$this._code = code;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  bool _pause;
  bool get pause => _$this._pause;
  set pause(bool pause) => _$this._pause = pause;

  int _duration;
  int get duration => _$this._duration;
  set duration(int duration) => _$this._duration = duration;

  String _color;
  String get color => _$this._color;
  set color(String color) => _$this._color = color;

  SessionTypeBuilder();

  SessionTypeBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _code = _$v.code;
      _name = _$v.name;
      _pause = _$v.pause;
      _duration = _$v.duration;
      _color = _$v.color;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionType other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$SessionType;
  }

  @override
  void update(void updates(SessionTypeBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SessionType build() {
    final _$result = _$v ??
        new _$SessionType._(
            id: id,
            code: code,
            name: name,
            pause: pause,
            duration: duration,
            color: color);
    replace(_$result);
    return _$result;
  }
}
