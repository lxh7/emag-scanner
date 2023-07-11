// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParticipantDTO extends ParticipantDTO {
  @override
  final int? eventId;
  @override
  final String? personId;
  @override
  final String? firstName;
  @override
  final String? surname;
  @override
  final String? nickname;
  @override
  final String? mobilePhone;

  factory _$ParticipantDTO([void Function(ParticipantDTOBuilder)? updates]) =>
      (new ParticipantDTOBuilder()..update(updates))._build();

  _$ParticipantDTO._(
      {this.eventId,
      this.personId,
      this.firstName,
      this.surname,
      this.nickname,
      this.mobilePhone})
      : super._();

  @override
  ParticipantDTO rebuild(void Function(ParticipantDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ParticipantDTOBuilder toBuilder() =>
      new ParticipantDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParticipantDTO &&
        eventId == other.eventId &&
        personId == other.personId &&
        firstName == other.firstName &&
        surname == other.surname &&
        nickname == other.nickname &&
        mobilePhone == other.mobilePhone;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, eventId.hashCode);
    _$hash = $jc(_$hash, personId.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, surname.hashCode);
    _$hash = $jc(_$hash, nickname.hashCode);
    _$hash = $jc(_$hash, mobilePhone.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParticipantDTO')
          ..add('eventId', eventId)
          ..add('personId', personId)
          ..add('firstName', firstName)
          ..add('surname', surname)
          ..add('nickname', nickname)
          ..add('mobilePhone', mobilePhone))
        .toString();
  }
}

class ParticipantDTOBuilder
    implements Builder<ParticipantDTO, ParticipantDTOBuilder> {
  _$ParticipantDTO? _$v;

  int? _eventId;
  int? get eventId => _$this._eventId;
  set eventId(int? eventId) => _$this._eventId = eventId;

  String? _personId;
  String? get personId => _$this._personId;
  set personId(String? personId) => _$this._personId = personId;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _surname;
  String? get surname => _$this._surname;
  set surname(String? surname) => _$this._surname = surname;

  String? _nickname;
  String? get nickname => _$this._nickname;
  set nickname(String? nickname) => _$this._nickname = nickname;

  String? _mobilePhone;
  String? get mobilePhone => _$this._mobilePhone;
  set mobilePhone(String? mobilePhone) => _$this._mobilePhone = mobilePhone;

  ParticipantDTOBuilder() {
    ParticipantDTO._defaults(this);
  }

  ParticipantDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _eventId = $v.eventId;
      _personId = $v.personId;
      _firstName = $v.firstName;
      _surname = $v.surname;
      _nickname = $v.nickname;
      _mobilePhone = $v.mobilePhone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParticipantDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ParticipantDTO;
  }

  @override
  void update(void Function(ParticipantDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParticipantDTO build() => _build();

  _$ParticipantDTO _build() {
    final _$result = _$v ??
        new _$ParticipantDTO._(
            eventId: eventId,
            personId: personId,
            firstName: firstName,
            surname: surname,
            nickname: nickname,
            mobilePhone: mobilePhone);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
