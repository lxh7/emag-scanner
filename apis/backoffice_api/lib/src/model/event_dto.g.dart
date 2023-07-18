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
  @override
  final int? capacity;
  @override
  final String? question1;
  @override
  final String? question2;
  @override
  final String? question3;
  @override
  final BuiltList<ParticipationDTO>? participations;

  factory _$EventDTO([void Function(EventDTOBuilder)? updates]) =>
      (new EventDTOBuilder()..update(updates))._build();

  _$EventDTO._(
      {this.id,
      this.categoryId,
      this.name,
      this.start,
      this.end,
      this.capacity,
      this.question1,
      this.question2,
      this.question3,
      this.participations})
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
        end == other.end &&
        capacity == other.capacity &&
        question1 == other.question1 &&
        question2 == other.question2 &&
        question3 == other.question3 &&
        participations == other.participations;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, start.hashCode);
    _$hash = $jc(_$hash, end.hashCode);
    _$hash = $jc(_$hash, capacity.hashCode);
    _$hash = $jc(_$hash, question1.hashCode);
    _$hash = $jc(_$hash, question2.hashCode);
    _$hash = $jc(_$hash, question3.hashCode);
    _$hash = $jc(_$hash, participations.hashCode);
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
          ..add('end', end)
          ..add('capacity', capacity)
          ..add('question1', question1)
          ..add('question2', question2)
          ..add('question3', question3)
          ..add('participations', participations))
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

  int? _capacity;
  int? get capacity => _$this._capacity;
  set capacity(int? capacity) => _$this._capacity = capacity;

  String? _question1;
  String? get question1 => _$this._question1;
  set question1(String? question1) => _$this._question1 = question1;

  String? _question2;
  String? get question2 => _$this._question2;
  set question2(String? question2) => _$this._question2 = question2;

  String? _question3;
  String? get question3 => _$this._question3;
  set question3(String? question3) => _$this._question3 = question3;

  ListBuilder<ParticipationDTO>? _participations;
  ListBuilder<ParticipationDTO> get participations =>
      _$this._participations ??= new ListBuilder<ParticipationDTO>();
  set participations(ListBuilder<ParticipationDTO>? participations) =>
      _$this._participations = participations;

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
      _capacity = $v.capacity;
      _question1 = $v.question1;
      _question2 = $v.question2;
      _question3 = $v.question3;
      _participations = $v.participations?.toBuilder();
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
    _$EventDTO _$result;
    try {
      _$result = _$v ??
          new _$EventDTO._(
              id: id,
              categoryId: categoryId,
              name: name,
              start: start,
              end: end,
              capacity: capacity,
              question1: question1,
              question2: question2,
              question3: question3,
              participations: _participations?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'participations';
        _participations?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'EventDTO', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
