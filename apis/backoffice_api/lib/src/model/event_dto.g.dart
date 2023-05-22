// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EventDTO extends EventDTO {
  @override
  final int? id;
  @override
  final int? categoryId;
  @override
  final String? name;
  @override
  final String? start;
  @override
  final String? end;

  factory _$EventDTO([void Function(EventDTOBuilder)? updates]) =>
      (new EventDTOBuilder()..update(updates))._build();

  _$EventDTO._({this.id, this.categoryId, this.name, this.start, this.end})
      : super._();

  @override
  EventDTO rebuild(void Function(EventDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EventDTOBuilder toBuilder() => new EventDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EventDTO &&
        id == other.id &&
        categoryId == other.categoryId &&
        name == other.name &&
        start == other.start &&
        end == other.end;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, start.hashCode);
    _$hash = $jc(_$hash, end.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EventDTO')
          ..add('id', id)
          ..add('categoryId', categoryId)
          ..add('name', name)
          ..add('start', start)
          ..add('end', end))
        .toString();
  }
}

class EventDTOBuilder implements Builder<EventDTO, EventDTOBuilder> {
  _$EventDTO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _categoryId;
  int? get categoryId => _$this._categoryId;
  set categoryId(int? categoryId) => _$this._categoryId = categoryId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _start;
  String? get start => _$this._start;
  set start(String? start) => _$this._start = start;

  String? _end;
  String? get end => _$this._end;
  set end(String? end) => _$this._end = end;

  EventDTOBuilder() {
    EventDTO._defaults(this);
  }

  EventDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _categoryId = $v.categoryId;
      _name = $v.name;
      _start = $v.start;
      _end = $v.end;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EventDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$EventDTO;
  }

  @override
  void update(void Function(EventDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EventDTO build() => _build();

  _$EventDTO _build() {
    final _$result = _$v ??
        new _$EventDTO._(
            id: id, categoryId: categoryId, name: name, start: start, end: end);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
