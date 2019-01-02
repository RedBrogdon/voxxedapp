// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker.dart';

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

Serializer<Speaker> _$speakerSerializer = new _$SpeakerSerializer();

class _$SpeakerSerializer implements StructuredSerializer<Speaker> {
  @override
  final Iterable<Type> types = const [Speaker, _$Speaker];
  @override
  final String wireName = 'Speaker';

  @override
  Iterable serialize(Serializers serializers, Speaker object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'uuid',
      serializers.serialize(object.uuid, specifiedType: const FullType(String)),
    ];
    if (object.firstName != null) {
      result
        ..add('firstName')
        ..add(serializers.serialize(object.firstName,
            specifiedType: const FullType(String)));
    }
    if (object.lastName != null) {
      result
        ..add('lastName')
        ..add(serializers.serialize(object.lastName,
            specifiedType: const FullType(String)));
    }
    if (object.lang != null) {
      result
        ..add('lang')
        ..add(serializers.serialize(object.lang,
            specifiedType: const FullType(String)));
    }
    if (object.bioAsHtml != null) {
      result
        ..add('bioAsHtml')
        ..add(serializers.serialize(object.bioAsHtml,
            specifiedType: const FullType(String)));
    }
    if (object.bio != null) {
      result
        ..add('bio')
        ..add(serializers.serialize(object.bio,
            specifiedType: const FullType(String)));
    }
    if (object.company != null) {
      result
        ..add('company')
        ..add(serializers.serialize(object.company,
            specifiedType: const FullType(String)));
    }
    if (object.blog != null) {
      result
        ..add('blog')
        ..add(serializers.serialize(object.blog,
            specifiedType: const FullType(String)));
    }
    if (object.avatarURL != null) {
      result
        ..add('avatarURL')
        ..add(serializers.serialize(object.avatarURL,
            specifiedType: const FullType(String)));
    }
    if (object.twitter != null) {
      result
        ..add('twitter')
        ..add(serializers.serialize(object.twitter,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Speaker deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SpeakerBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'uuid':
          result.uuid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'firstName':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lastName':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lang':
          result.lang = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bioAsHtml':
          result.bioAsHtml = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bio':
          result.bio = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'company':
          result.company = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'blog':
          result.blog = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatarURL':
          result.avatarURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'twitter':
          result.twitter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Speaker extends Speaker {
  @override
  final String uuid;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String lang;
  @override
  final String bioAsHtml;
  @override
  final String bio;
  @override
  final String company;
  @override
  final String blog;
  @override
  final String avatarURL;
  @override
  final String twitter;

  factory _$Speaker([void updates(SpeakerBuilder b)]) =>
      (new SpeakerBuilder()..update(updates)).build();

  _$Speaker._(
      {this.uuid,
      this.firstName,
      this.lastName,
      this.lang,
      this.bioAsHtml,
      this.bio,
      this.company,
      this.blog,
      this.avatarURL,
      this.twitter})
      : super._() {
    if (uuid == null) {
      throw new BuiltValueNullFieldError('Speaker', 'uuid');
    }
  }

  @override
  Speaker rebuild(void updates(SpeakerBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SpeakerBuilder toBuilder() => new SpeakerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Speaker &&
        uuid == other.uuid &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        lang == other.lang &&
        bioAsHtml == other.bioAsHtml &&
        bio == other.bio &&
        company == other.company &&
        blog == other.blog &&
        avatarURL == other.avatarURL &&
        twitter == other.twitter;
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
                                    $jc($jc(0, uuid.hashCode),
                                        firstName.hashCode),
                                    lastName.hashCode),
                                lang.hashCode),
                            bioAsHtml.hashCode),
                        bio.hashCode),
                    company.hashCode),
                blog.hashCode),
            avatarURL.hashCode),
        twitter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Speaker')
          ..add('uuid', uuid)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('lang', lang)
          ..add('bioAsHtml', bioAsHtml)
          ..add('bio', bio)
          ..add('company', company)
          ..add('blog', blog)
          ..add('avatarURL', avatarURL)
          ..add('twitter', twitter))
        .toString();
  }
}

class SpeakerBuilder implements Builder<Speaker, SpeakerBuilder> {
  _$Speaker _$v;

  String _uuid;
  String get uuid => _$this._uuid;
  set uuid(String uuid) => _$this._uuid = uuid;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  String _lang;
  String get lang => _$this._lang;
  set lang(String lang) => _$this._lang = lang;

  String _bioAsHtml;
  String get bioAsHtml => _$this._bioAsHtml;
  set bioAsHtml(String bioAsHtml) => _$this._bioAsHtml = bioAsHtml;

  String _bio;
  String get bio => _$this._bio;
  set bio(String bio) => _$this._bio = bio;

  String _company;
  String get company => _$this._company;
  set company(String company) => _$this._company = company;

  String _blog;
  String get blog => _$this._blog;
  set blog(String blog) => _$this._blog = blog;

  String _avatarURL;
  String get avatarURL => _$this._avatarURL;
  set avatarURL(String avatarURL) => _$this._avatarURL = avatarURL;

  String _twitter;
  String get twitter => _$this._twitter;
  set twitter(String twitter) => _$this._twitter = twitter;

  SpeakerBuilder();

  SpeakerBuilder get _$this {
    if (_$v != null) {
      _uuid = _$v.uuid;
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _lang = _$v.lang;
      _bioAsHtml = _$v.bioAsHtml;
      _bio = _$v.bio;
      _company = _$v.company;
      _blog = _$v.blog;
      _avatarURL = _$v.avatarURL;
      _twitter = _$v.twitter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Speaker other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Speaker;
  }

  @override
  void update(void updates(SpeakerBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Speaker build() {
    final _$result = _$v ??
        new _$Speaker._(
            uuid: uuid,
            firstName: firstName,
            lastName: lastName,
            lang: lang,
            bioAsHtml: bioAsHtml,
            bio: bio,
            company: company,
            blog: blog,
            avatarURL: avatarURL,
            twitter: twitter);
    replace(_$result);
    return _$result;
  }
}
