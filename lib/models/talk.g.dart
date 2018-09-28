// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talk.dart';

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

Serializer<Talk> _$talkSerializer = new _$TalkSerializer();

class _$TalkSerializer implements StructuredSerializer<Talk> {
  @override
  final Iterable<Type> types = const [Talk, _$Talk];
  @override
  final String wireName = 'Talk';

  @override
  Iterable serialize(Serializers serializers, Talk object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'talkType',
      serializers.serialize(object.talkType,
          specifiedType: const FullType(String)),
      'track',
      serializers.serialize(object.track,
          specifiedType: const FullType(String)),
      'lang',
      serializers.serialize(object.lang, specifiedType: const FullType(String)),
      'summary',
      serializers.serialize(object.summary,
          specifiedType: const FullType(String)),
      'speakerUuids',
      serializers.serialize(object.speakerUuids,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  Talk deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TalkBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'talkType':
          result.talkType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'track':
          result.track = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lang':
          result.lang = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'summary':
          result.summary = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'speakerUuids':
          result.speakerUuids.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$Talk extends Talk {
  @override
  final String id;
  @override
  final String title;
  @override
  final String talkType;
  @override
  final String track;
  @override
  final String lang;
  @override
  final String summary;
  @override
  final BuiltList<String> speakerUuids;

  factory _$Talk([void updates(TalkBuilder b)]) =>
      (new TalkBuilder()..update(updates)).build();

  _$Talk._(
      {this.id,
      this.title,
      this.talkType,
      this.track,
      this.lang,
      this.summary,
      this.speakerUuids})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Talk', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Talk', 'title');
    }
    if (talkType == null) {
      throw new BuiltValueNullFieldError('Talk', 'talkType');
    }
    if (track == null) {
      throw new BuiltValueNullFieldError('Talk', 'track');
    }
    if (lang == null) {
      throw new BuiltValueNullFieldError('Talk', 'lang');
    }
    if (summary == null) {
      throw new BuiltValueNullFieldError('Talk', 'summary');
    }
    if (speakerUuids == null) {
      throw new BuiltValueNullFieldError('Talk', 'speakerUuids');
    }
  }

  @override
  Talk rebuild(void updates(TalkBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TalkBuilder toBuilder() => new TalkBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Talk &&
        id == other.id &&
        title == other.title &&
        talkType == other.talkType &&
        track == other.track &&
        lang == other.lang &&
        summary == other.summary &&
        speakerUuids == other.speakerUuids;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), title.hashCode),
                        talkType.hashCode),
                    track.hashCode),
                lang.hashCode),
            summary.hashCode),
        speakerUuids.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Talk')
          ..add('id', id)
          ..add('title', title)
          ..add('talkType', talkType)
          ..add('track', track)
          ..add('lang', lang)
          ..add('summary', summary)
          ..add('speakerUuids', speakerUuids))
        .toString();
  }
}

class TalkBuilder implements Builder<Talk, TalkBuilder> {
  _$Talk _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _talkType;
  String get talkType => _$this._talkType;
  set talkType(String talkType) => _$this._talkType = talkType;

  String _track;
  String get track => _$this._track;
  set track(String track) => _$this._track = track;

  String _lang;
  String get lang => _$this._lang;
  set lang(String lang) => _$this._lang = lang;

  String _summary;
  String get summary => _$this._summary;
  set summary(String summary) => _$this._summary = summary;

  ListBuilder<String> _speakerUuids;
  ListBuilder<String> get speakerUuids =>
      _$this._speakerUuids ??= new ListBuilder<String>();
  set speakerUuids(ListBuilder<String> speakerUuids) =>
      _$this._speakerUuids = speakerUuids;

  TalkBuilder();

  TalkBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _talkType = _$v.talkType;
      _track = _$v.track;
      _lang = _$v.lang;
      _summary = _$v.summary;
      _speakerUuids = _$v.speakerUuids?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Talk other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Talk;
  }

  @override
  void update(void updates(TalkBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Talk build() {
    _$Talk _$result;
    try {
      _$result = _$v ??
          new _$Talk._(
              id: id,
              title: title,
              talkType: talkType,
              track: track,
              lang: lang,
              summary: summary,
              speakerUuids: speakerUuids.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'speakerUuids';
        speakerUuids.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Talk', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
