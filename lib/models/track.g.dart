// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

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

Serializer<Track> _$trackSerializer = new _$TrackSerializer();

class _$TrackSerializer implements StructuredSerializer<Track> {
  @override
  final Iterable<Type> types = const [Track, _$Track];
  @override
  final String wireName = 'Track';

  @override
  Iterable serialize(Serializers serializers, Track object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
    ];
    if (object.imageURL != null) {
      result
        ..add('imageURL')
        ..add(serializers.serialize(object.imageURL,
            specifiedType: const FullType(String)));
    }
    if (object.categoryId != null) {
      result
        ..add('categoryId')
        ..add(serializers.serialize(object.categoryId,
            specifiedType: const FullType(int)));
    }
    if (object.categoryName != null) {
      result
        ..add('categoryName')
        ..add(serializers.serialize(object.categoryName,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Track deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TrackBuilder();

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
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageURL':
          result.imageURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'categoryId':
          result.categoryId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'categoryName':
          result.categoryName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Track extends Track {
  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String imageURL;
  @override
  final int categoryId;
  @override
  final String categoryName;

  factory _$Track([void updates(TrackBuilder b)]) =>
      (new TrackBuilder()..update(updates)).build();

  _$Track._(
      {this.id,
      this.name,
      this.description,
      this.imageURL,
      this.categoryId,
      this.categoryName})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Track', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Track', 'name');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('Track', 'description');
    }
  }

  @override
  Track rebuild(void updates(TrackBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TrackBuilder toBuilder() => new TrackBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Track &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        imageURL == other.imageURL &&
        categoryId == other.categoryId &&
        categoryName == other.categoryName;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, id.hashCode), name.hashCode),
                    description.hashCode),
                imageURL.hashCode),
            categoryId.hashCode),
        categoryName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Track')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('imageURL', imageURL)
          ..add('categoryId', categoryId)
          ..add('categoryName', categoryName))
        .toString();
  }
}

class TrackBuilder implements Builder<Track, TrackBuilder> {
  _$Track _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _imageURL;
  String get imageURL => _$this._imageURL;
  set imageURL(String imageURL) => _$this._imageURL = imageURL;

  int _categoryId;
  int get categoryId => _$this._categoryId;
  set categoryId(int categoryId) => _$this._categoryId = categoryId;

  String _categoryName;
  String get categoryName => _$this._categoryName;
  set categoryName(String categoryName) => _$this._categoryName = categoryName;

  TrackBuilder();

  TrackBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _description = _$v.description;
      _imageURL = _$v.imageURL;
      _categoryId = _$v.categoryId;
      _categoryName = _$v.categoryName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Track other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Track;
  }

  @override
  void update(void updates(TrackBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Track build() {
    final _$result = _$v ??
        new _$Track._(
            id: id,
            name: name,
            description: description,
            imageURL: imageURL,
            categoryId: categoryId,
            categoryName: categoryName);
    replace(_$result);
    return _$result;
  }
}
