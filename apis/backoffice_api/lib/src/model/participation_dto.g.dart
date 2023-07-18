// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participation_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParticipationDTO extends ParticipationDTO {
  @override
  final int? no;
  @override
  final String? scanTime;
  @override
  final int? eventId;
  @override
  final int? type;
  @override
  final bool? paid;
  @override
  final bool? in_;
  @override
  final EventDTO? event;
  @override
  final String? personId;
  @override
  final PersonDTO? person;
  @override
  final String? answer1;
  @override
  final String? answer2;
  @override
  final String? answer3;

  factory _$ParticipationDTO(
          [void Function(ParticipationDTOBuilder)? updates]) =>
      (new ParticipationDTOBuilder()..update(updates))._build();

  _$ParticipationDTO._(
      {this.no,
      this.scanTime,
      this.eventId,
      this.type,
      this.paid,
      this.in_,
      this.event,
      this.personId,
      this.person,
      this.answer1,
      this.answer2,
      this.answer3})
      : super._();

  @override
  ParticipationDTO rebuild(void Function(ParticipationDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ParticipationDTOBuilder toBuilder() =>
      new ParticipationDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParticipationDTO &&
        no == other.no &&
        scanTime == other.scanTime &&
        eventId == other.eventId &&
        type == other.type &&
        paid == other.paid &&
        in_ == other.in_ &&
        event == other.event &&
        personId == other.personId &&
        person == other.person &&
        answer1 == other.answer1 &&
        answer2 == other.answer2 &&
        answer3 == other.answer3;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, no.hashCode);
    _$hash = $jc(_$hash, scanTime.hashCode);
    _$hash = $jc(_$hash, eventId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, paid.hashCode);
    _$hash = $jc(_$hash, in_.hashCode);
    _$hash = $jc(_$hash, event.hashCode);
    _$hash = $jc(_$hash, personId.hashCode);
    _$hash = $jc(_$hash, person.hashCode);
    _$hash = $jc(_$hash, answer1.hashCode);
    _$hash = $jc(_$hash, answer2.hashCode);
    _$hash = $jc(_$hash, answer3.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParticipationDTO')
          ..add('no', no)
          ..add('scanTime', scanTime)
          ..add('eventId', eventId)
          ..add('type', type)
          ..add('paid', paid)
          ..add('in_', in_)
          ..add('event', event)
          ..add('personId', personId)
          ..add('person', person)
          ..add('answer1', answer1)
          ..add('answer2', answer2)
          ..add('answer3', answer3))
        .toString();
  }
}

class ParticipationDTOBuilder
    implements Builder<ParticipationDTO, ParticipationDTOBuilder> {
  _$ParticipationDTO? _$v;

  int? _no;
  int? get no => _$this._no;
  set no(int? no) => _$this._no = no;

  String? _scanTime;
  String? get scanTime => _$this._scanTime;
  set scanTime(String? scanTime) => _$this._scanTime = scanTime;

  int? _eventId;
  int? get eventId => _$this._eventId;
  set eventId(int? eventId) => _$this._eventId = eventId;

  int? _type;
  int? get type => _$this._type;
  set type(int? type) => _$this._type = type;

  bool? _paid;
  bool? get paid => _$this._paid;
  set paid(bool? paid) => _$this._paid = paid;

  bool? _in_;
  bool? get in_ => _$this._in_;
  set in_(bool? in_) => _$this._in_ = in_;

  EventDTOBuilder? _event;
  EventDTOBuilder get event => _$this._event ??= new EventDTOBuilder();
  set event(EventDTOBuilder? event) => _$this._event = event;

  String? _personId;
  String? get personId => _$this._personId;
  set personId(String? personId) => _$this._personId = personId;

  PersonDTOBuilder? _person;
  PersonDTOBuilder get person => _$this._person ??= new PersonDTOBuilder();
  set person(PersonDTOBuilder? person) => _$this._person = person;

  String? _answer1;
  String? get answer1 => _$this._answer1;
  set answer1(String? answer1) => _$this._answer1 = answer1;

  String? _answer2;
  String? get answer2 => _$this._answer2;
  set answer2(String? answer2) => _$this._answer2 = answer2;

  String? _answer3;
  String? get answer3 => _$this._answer3;
  set answer3(String? answer3) => _$this._answer3 = answer3;

  ParticipationDTOBuilder() {
    ParticipationDTO._defaults(this);
  }

  ParticipationDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _no = $v.no;
      _scanTime = $v.scanTime;
      _eventId = $v.eventId;
      _type = $v.type;
      _paid = $v.paid;
      _in_ = $v.in_;
      _event = $v.event?.toBuilder();
      _personId = $v.personId;
      _person = $v.person?.toBuilder();
      _answer1 = $v.answer1;
      _answer2 = $v.answer2;
      _answer3 = $v.answer3;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParticipationDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ParticipationDTO;
  }

  @override
  void update(void Function(ParticipationDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParticipationDTO build() => _build();

  _$ParticipationDTO _build() {
    _$ParticipationDTO _$result;
    try {
      _$result = _$v ??
          new _$ParticipationDTO._(
              no: no,
              scanTime: scanTime,
              eventId: eventId,
              type: type,
              paid: paid,
              in_: in_,
              event: _event?.build(),
              personId: personId,
              person: _person?.build(),
              answer1: answer1,
              answer2: answer2,
              answer3: answer3);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'event';
        _event?.build();

        _$failedField = 'person';
        _person?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ParticipationDTO', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
