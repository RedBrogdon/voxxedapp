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

part of 'conference.dart';

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

Serializer<Conference> _$conferenceSerializer = new _$ConferenceSerializer();

class _$ConferenceSerializer implements StructuredSerializer<Conference> {
  @override
  final Iterable<Type> types = const [Conference, _$Conference];
  @override
  final String wireName = 'Conference';

  @override
  Iterable serialize(Serializers serializers, Conference object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'website',
      serializers.serialize(object.website,
          specifiedType: const FullType(String)),
      'imageURL',
      serializers.serialize(object.imageURL,
          specifiedType: const FullType(String)),
      'fromDate',
      serializers.serialize(object.fromDate,
          specifiedType: const FullType(String)),
      'endDate',
      serializers.serialize(object.endDate,
          specifiedType: const FullType(String)),
      'eventType',
      serializers.serialize(object.eventType,
          specifiedType: const FullType(EventType)),
      'tracks',
      serializers.serialize(object.tracks,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Track)])),
      'languages',
      serializers.serialize(object.languages,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Language)])),
      'sessionTypes',
      serializers.serialize(object.sessionTypes,
          specifiedType:
              const FullType(BuiltList, const [const FullType(SessionType)])),
    ];
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.scheduleURL != null) {
      result
        ..add('scheduleURL')
        ..add(serializers.serialize(object.scheduleURL,
            specifiedType: const FullType(String)));
    }
    if (object.eventImagesURL != null) {
      result
        ..add('eventImagesURL')
        ..add(serializers.serialize(object.eventImagesURL,
            specifiedType: const FullType(String)));
    }
    if (object.youTubeURL != null) {
      result
        ..add('youTubeURL')
        ..add(serializers.serialize(object.youTubeURL,
            specifiedType: const FullType(String)));
    }
    if (object.cfpURL != null) {
      result
        ..add('cfpURL')
        ..add(serializers.serialize(object.cfpURL,
            specifiedType: const FullType(String)));
    }
    if (object.archived != null) {
      result
        ..add('archived')
        ..add(serializers.serialize(object.archived,
            specifiedType: const FullType(bool)));
    }
    if (object.cfpActive != null) {
      result
        ..add('cfpActive')
        ..add(serializers.serialize(object.cfpActive,
            specifiedType: const FullType(bool)));
    }
    if (object.locationId != null) {
      result
        ..add('locationId')
        ..add(serializers.serialize(object.locationId,
            specifiedType: const FullType(int)));
    }
    if (object.locationName != null) {
      result
        ..add('locationName')
        ..add(serializers.serialize(object.locationName,
            specifiedType: const FullType(String)));
    }
    if (object.timezone != null) {
      result
        ..add('timezone')
        ..add(serializers.serialize(object.timezone,
            specifiedType: const FullType(String)));
    }
    if (object.cfpFromDate != null) {
      result
        ..add('cfpFromDate')
        ..add(serializers.serialize(object.cfpFromDate,
            specifiedType: const FullType(String)));
    }
    if (object.cfpEndDate != null) {
      result
        ..add('cfpEndDate')
        ..add(serializers.serialize(object.cfpEndDate,
            specifiedType: const FullType(String)));
    }
    if (object.cfpVersion != null) {
      result
        ..add('cfpVersion')
        ..add(serializers.serialize(object.cfpVersion,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Conference deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ConferenceBuilder();

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
        case 'website':
          result.website = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageURL':
          result.imageURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fromDate':
          result.fromDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'endDate':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'eventType':
          result.eventType = serializers.deserialize(value,
              specifiedType: const FullType(EventType)) as EventType;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'scheduleURL':
          result.scheduleURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'eventImagesURL':
          result.eventImagesURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'youTubeURL':
          result.youTubeURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cfpURL':
          result.cfpURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'archived':
          result.archived = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'cfpActive':
          result.cfpActive = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'locationId':
          result.locationId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'locationName':
          result.locationName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'timezone':
          result.timezone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cfpFromDate':
          result.cfpFromDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cfpEndDate':
          result.cfpEndDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cfpVersion':
          result.cfpVersion = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tracks':
          result.tracks.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Track)]))
              as BuiltList);
          break;
        case 'languages':
          result.languages.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Language)])) as BuiltList);
          break;
        case 'sessionTypes':
          result.sessionTypes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SessionType)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$Conference extends Conference {
  @override
  final int id;
  @override
  final String name;
  @override
  final String website;
  @override
  final String imageURL;
  @override
  final String fromDate;
  @override
  final String endDate;
  @override
  final EventType eventType;
  @override
  final String description;
  @override
  final String scheduleURL;
  @override
  final String eventImagesURL;
  @override
  final String youTubeURL;
  @override
  final String cfpURL;
  @override
  final bool archived;
  @override
  final bool cfpActive;
  @override
  final int locationId;
  @override
  final String locationName;
  @override
  final String timezone;
  @override
  final String cfpFromDate;
  @override
  final String cfpEndDate;
  @override
  final String cfpVersion;
  @override
  final BuiltList<Track> tracks;
  @override
  final BuiltList<Language> languages;
  @override
  final BuiltList<SessionType> sessionTypes;

  factory _$Conference([void updates(ConferenceBuilder b)]) =>
      (new ConferenceBuilder()..update(updates)).build();

  _$Conference._(
      {this.id,
      this.name,
      this.website,
      this.imageURL,
      this.fromDate,
      this.endDate,
      this.eventType,
      this.description,
      this.scheduleURL,
      this.eventImagesURL,
      this.youTubeURL,
      this.cfpURL,
      this.archived,
      this.cfpActive,
      this.locationId,
      this.locationName,
      this.timezone,
      this.cfpFromDate,
      this.cfpEndDate,
      this.cfpVersion,
      this.tracks,
      this.languages,
      this.sessionTypes})
      : super._() {
    if (id == null) throw new BuiltValueNullFieldError('Conference', 'id');
    if (name == null) throw new BuiltValueNullFieldError('Conference', 'name');
    if (website == null)
      throw new BuiltValueNullFieldError('Conference', 'website');
    if (imageURL == null)
      throw new BuiltValueNullFieldError('Conference', 'imageURL');
    if (fromDate == null)
      throw new BuiltValueNullFieldError('Conference', 'fromDate');
    if (endDate == null)
      throw new BuiltValueNullFieldError('Conference', 'endDate');
    if (eventType == null)
      throw new BuiltValueNullFieldError('Conference', 'eventType');
    if (tracks == null)
      throw new BuiltValueNullFieldError('Conference', 'tracks');
    if (languages == null)
      throw new BuiltValueNullFieldError('Conference', 'languages');
    if (sessionTypes == null)
      throw new BuiltValueNullFieldError('Conference', 'sessionTypes');
  }

  @override
  Conference rebuild(void updates(ConferenceBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ConferenceBuilder toBuilder() => new ConferenceBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Conference) return false;
    return id == other.id &&
        name == other.name &&
        website == other.website &&
        imageURL == other.imageURL &&
        fromDate == other.fromDate &&
        endDate == other.endDate &&
        eventType == other.eventType &&
        description == other.description &&
        scheduleURL == other.scheduleURL &&
        eventImagesURL == other.eventImagesURL &&
        youTubeURL == other.youTubeURL &&
        cfpURL == other.cfpURL &&
        archived == other.archived &&
        cfpActive == other.cfpActive &&
        locationId == other.locationId &&
        locationName == other.locationName &&
        timezone == other.timezone &&
        cfpFromDate == other.cfpFromDate &&
        cfpEndDate == other.cfpEndDate &&
        cfpVersion == other.cfpVersion &&
        tracks == other.tracks &&
        languages == other.languages &&
        sessionTypes == other.sessionTypes;
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
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc(0, id.hashCode), name.hashCode), website.hashCode), imageURL.hashCode),
                                                                                fromDate.hashCode),
                                                                            endDate.hashCode),
                                                                        eventType.hashCode),
                                                                    description.hashCode),
                                                                scheduleURL.hashCode),
                                                            eventImagesURL.hashCode),
                                                        youTubeURL.hashCode),
                                                    cfpURL.hashCode),
                                                archived.hashCode),
                                            cfpActive.hashCode),
                                        locationId.hashCode),
                                    locationName.hashCode),
                                timezone.hashCode),
                            cfpFromDate.hashCode),
                        cfpEndDate.hashCode),
                    cfpVersion.hashCode),
                tracks.hashCode),
            languages.hashCode),
        sessionTypes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Conference')
          ..add('id', id)
          ..add('name', name)
          ..add('website', website)
          ..add('imageURL', imageURL)
          ..add('fromDate', fromDate)
          ..add('endDate', endDate)
          ..add('eventType', eventType)
          ..add('description', description)
          ..add('scheduleURL', scheduleURL)
          ..add('eventImagesURL', eventImagesURL)
          ..add('youTubeURL', youTubeURL)
          ..add('cfpURL', cfpURL)
          ..add('archived', archived)
          ..add('cfpActive', cfpActive)
          ..add('locationId', locationId)
          ..add('locationName', locationName)
          ..add('timezone', timezone)
          ..add('cfpFromDate', cfpFromDate)
          ..add('cfpEndDate', cfpEndDate)
          ..add('cfpVersion', cfpVersion)
          ..add('tracks', tracks)
          ..add('languages', languages)
          ..add('sessionTypes', sessionTypes))
        .toString();
  }
}

class ConferenceBuilder implements Builder<Conference, ConferenceBuilder> {
  _$Conference _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _website;
  String get website => _$this._website;
  set website(String website) => _$this._website = website;

  String _imageURL;
  String get imageURL => _$this._imageURL;
  set imageURL(String imageURL) => _$this._imageURL = imageURL;

  String _fromDate;
  String get fromDate => _$this._fromDate;
  set fromDate(String fromDate) => _$this._fromDate = fromDate;

  String _endDate;
  String get endDate => _$this._endDate;
  set endDate(String endDate) => _$this._endDate = endDate;

  EventType _eventType;
  EventType get eventType => _$this._eventType;
  set eventType(EventType eventType) => _$this._eventType = eventType;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _scheduleURL;
  String get scheduleURL => _$this._scheduleURL;
  set scheduleURL(String scheduleURL) => _$this._scheduleURL = scheduleURL;

  String _eventImagesURL;
  String get eventImagesURL => _$this._eventImagesURL;
  set eventImagesURL(String eventImagesURL) =>
      _$this._eventImagesURL = eventImagesURL;

  String _youTubeURL;
  String get youTubeURL => _$this._youTubeURL;
  set youTubeURL(String youTubeURL) => _$this._youTubeURL = youTubeURL;

  String _cfpURL;
  String get cfpURL => _$this._cfpURL;
  set cfpURL(String cfpURL) => _$this._cfpURL = cfpURL;

  bool _archived;
  bool get archived => _$this._archived;
  set archived(bool archived) => _$this._archived = archived;

  bool _cfpActive;
  bool get cfpActive => _$this._cfpActive;
  set cfpActive(bool cfpActive) => _$this._cfpActive = cfpActive;

  int _locationId;
  int get locationId => _$this._locationId;
  set locationId(int locationId) => _$this._locationId = locationId;

  String _locationName;
  String get locationName => _$this._locationName;
  set locationName(String locationName) => _$this._locationName = locationName;

  String _timezone;
  String get timezone => _$this._timezone;
  set timezone(String timezone) => _$this._timezone = timezone;

  String _cfpFromDate;
  String get cfpFromDate => _$this._cfpFromDate;
  set cfpFromDate(String cfpFromDate) => _$this._cfpFromDate = cfpFromDate;

  String _cfpEndDate;
  String get cfpEndDate => _$this._cfpEndDate;
  set cfpEndDate(String cfpEndDate) => _$this._cfpEndDate = cfpEndDate;

  String _cfpVersion;
  String get cfpVersion => _$this._cfpVersion;
  set cfpVersion(String cfpVersion) => _$this._cfpVersion = cfpVersion;

  ListBuilder<Track> _tracks;
  ListBuilder<Track> get tracks => _$this._tracks ??= new ListBuilder<Track>();
  set tracks(ListBuilder<Track> tracks) => _$this._tracks = tracks;

  ListBuilder<Language> _languages;
  ListBuilder<Language> get languages =>
      _$this._languages ??= new ListBuilder<Language>();
  set languages(ListBuilder<Language> languages) =>
      _$this._languages = languages;

  ListBuilder<SessionType> _sessionTypes;
  ListBuilder<SessionType> get sessionTypes =>
      _$this._sessionTypes ??= new ListBuilder<SessionType>();
  set sessionTypes(ListBuilder<SessionType> sessionTypes) =>
      _$this._sessionTypes = sessionTypes;

  ConferenceBuilder();

  ConferenceBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _website = _$v.website;
      _imageURL = _$v.imageURL;
      _fromDate = _$v.fromDate;
      _endDate = _$v.endDate;
      _eventType = _$v.eventType;
      _description = _$v.description;
      _scheduleURL = _$v.scheduleURL;
      _eventImagesURL = _$v.eventImagesURL;
      _youTubeURL = _$v.youTubeURL;
      _cfpURL = _$v.cfpURL;
      _archived = _$v.archived;
      _cfpActive = _$v.cfpActive;
      _locationId = _$v.locationId;
      _locationName = _$v.locationName;
      _timezone = _$v.timezone;
      _cfpFromDate = _$v.cfpFromDate;
      _cfpEndDate = _$v.cfpEndDate;
      _cfpVersion = _$v.cfpVersion;
      _tracks = _$v.tracks?.toBuilder();
      _languages = _$v.languages?.toBuilder();
      _sessionTypes = _$v.sessionTypes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Conference other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Conference;
  }

  @override
  void update(void updates(ConferenceBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Conference build() {
    _$Conference _$result;
    try {
      _$result = _$v ??
          new _$Conference._(
              id: id,
              name: name,
              website: website,
              imageURL: imageURL,
              fromDate: fromDate,
              endDate: endDate,
              eventType: eventType,
              description: description,
              scheduleURL: scheduleURL,
              eventImagesURL: eventImagesURL,
              youTubeURL: youTubeURL,
              cfpURL: cfpURL,
              archived: archived,
              cfpActive: cfpActive,
              locationId: locationId,
              locationName: locationName,
              timezone: timezone,
              cfpFromDate: cfpFromDate,
              cfpEndDate: cfpEndDate,
              cfpVersion: cfpVersion,
              tracks: tracks.build(),
              languages: languages.build(),
              sessionTypes: sessionTypes.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tracks';
        tracks.build();
        _$failedField = 'languages';
        languages.build();
        _$failedField = 'sessionTypes';
        sessionTypes.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Conference', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
