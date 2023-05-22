// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CategoryDTO extends CategoryDTO {
  @override
  final int? id;
  @override
  final String? name;

  factory _$CategoryDTO([void Function(CategoryDTOBuilder)? updates]) =>
      (new CategoryDTOBuilder()..update(updates))._build();

  _$CategoryDTO._({this.id, this.name}) : super._();

  @override
  CategoryDTO rebuild(void Function(CategoryDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CategoryDTOBuilder toBuilder() => new CategoryDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CategoryDTO && id == other.id && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CategoryDTO')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class CategoryDTOBuilder implements Builder<CategoryDTO, CategoryDTOBuilder> {
  _$CategoryDTO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CategoryDTOBuilder() {
    CategoryDTO._defaults(this);
  }

  CategoryDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CategoryDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CategoryDTO;
  }

  @override
  void update(void Function(CategoryDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CategoryDTO build() => _build();

  _$CategoryDTO _build() {
    final _$result = _$v ?? new _$CategoryDTO._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
