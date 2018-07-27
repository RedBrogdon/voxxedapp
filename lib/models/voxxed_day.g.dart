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

part of 'voxxed_day.dart';

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

Serializer<VoxxedDay> _$voxxedDaySerializer = new _$VoxxedDaySerializer();

class _$VoxxedDaySerializer implements StructuredSerializer<VoxxedDay> {
  @override
  final Iterable<Type> types = const [VoxxedDay, _$VoxxedDay];
  @override
  final String wireName = 'VoxxedDay';

  @override
  Iterable serialize(Serializers serializers, VoxxedDay object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'eventType',
      serializers.serialize(object.eventType,
          specifiedType: const FullType(EventType)),
      'fromDate',
      serializers.serialize(object.fromDate,
          specifiedType: const FullType(String)),
      'endDate',
      serializers.serialize(object.endDate,
          specifiedType: const FullType(String)),
      'imageURL',
      serializers.serialize(object.imageURL,
          specifiedType: const FullType(String)),
      'website',
      serializers.serialize(object.website,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  VoxxedDay deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new VoxxedDayBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'eventType':
          result.eventType = serializers.deserialize(value,
              specifiedType: const FullType(EventType)) as EventType;
          break;
        case 'fromDate':
          result.fromDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'endDate':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageURL':
          result.imageURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'website':
          result.website = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$VoxxedDay extends VoxxedDay {
  @override
  final int id;
  @override
  final String name;
  @override
  final EventType eventType;
  @override
  final String fromDate;
  @override
  final String endDate;
  @override
  final String imageURL;
  @override
  final String website;

  factory _$VoxxedDay([void updates(VoxxedDayBuilder b)]) =>
      (new VoxxedDayBuilder()..update(updates)).build();

  _$VoxxedDay._(
      {this.id,
      this.name,
      this.eventType,
      this.fromDate,
      this.endDate,
      this.imageURL,
      this.website})
      : super._() {
    if (id == null) throw new BuiltValueNullFieldError('VoxxedDay', 'id');
    if (name == null) throw new BuiltValueNullFieldError('VoxxedDay', 'name');
    if (eventType == null)
      throw new BuiltValueNullFieldError('VoxxedDay', 'eventType');
    if (fromDate == null)
      throw new BuiltValueNullFieldError('VoxxedDay', 'fromDate');
    if (endDate == null)
      throw new BuiltValueNullFieldError('VoxxedDay', 'endDate');
    if (imageURL == null)
      throw new BuiltValueNullFieldError('VoxxedDay', 'imageURL');
    if (website == null)
      throw new BuiltValueNullFieldError('VoxxedDay', 'website');
  }

  @override
  VoxxedDay rebuild(void updates(VoxxedDayBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  VoxxedDayBuilder toBuilder() => new VoxxedDayBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! VoxxedDay) return false;
    return id == other.id &&
        name == other.name &&
        eventType == other.eventType &&
        fromDate == other.fromDate &&
        endDate == other.endDate &&
        imageURL == other.imageURL &&
        website == other.website;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), name.hashCode),
                        eventType.hashCode),
                    fromDate.hashCode),
                endDate.hashCode),
            imageURL.hashCode),
        website.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VoxxedDay')
          ..add('id', id)
          ..add('name', name)
          ..add('eventType', eventType)
          ..add('fromDate', fromDate)
          ..add('endDate', endDate)
          ..add('imageURL', imageURL)
          ..add('website', website))
        .toString();
  }
}

class VoxxedDayBuilder implements Builder<VoxxedDay, VoxxedDayBuilder> {
  _$VoxxedDay _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  EventType _eventType;
  EventType get eventType => _$this._eventType;
  set eventType(EventType eventType) => _$this._eventType = eventType;

  String _fromDate;
  String get fromDate => _$this._fromDate;
  set fromDate(String fromDate) => _$this._fromDate = fromDate;

  String _endDate;
  String get endDate => _$this._endDate;
  set endDate(String endDate) => _$this._endDate = endDate;

  String _imageURL;
  String get imageURL => _$this._imageURL;
  set imageURL(String imageURL) => _$this._imageURL = imageURL;

  String _website;
  String get website => _$this._website;
  set website(String website) => _$this._website = website;

  VoxxedDayBuilder();

  VoxxedDayBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _eventType = _$v.eventType;
      _fromDate = _$v.fromDate;
      _endDate = _$v.endDate;
      _imageURL = _$v.imageURL;
      _website = _$v.website;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VoxxedDay other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$VoxxedDay;
  }

  @override
  void update(void updates(VoxxedDayBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$VoxxedDay build() {
    final _$result = _$v ??
        new _$VoxxedDay._(
            id: id,
            name: name,
            eventType: eventType,
            fromDate: fromDate,
            endDate: endDate,
            imageURL: imageURL,
            website: website);
    replace(_$result);
    return _$result;
  }
}
