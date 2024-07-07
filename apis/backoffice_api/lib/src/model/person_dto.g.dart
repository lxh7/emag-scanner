// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PersonDTO extends PersonDTO {
  @override
  final String? personId;
  @override
  final String? firstName;
  @override
  final String? surname;
  @override
  final String? nickname;
  @override
  final String? email;
  @override
  final String? mobilePhone;
  @override
  final String? city;
  @override
  final String? countryCode;
  @override
  final String? country;
  @override
  final BuiltList<ParticipationDTO>? participations;

  factory _$PersonDTO([void Function(PersonDTOBuilder)? updates]) =>
      (new PersonDTOBuilder()..update(updates))._build();

  _$PersonDTO._(
      {this.personId,
      this.firstName,
      this.surname,
      this.nickname,
      this.email,
      this.mobilePhone,
      this.city,
      this.countryCode,
      this.country,
      this.participations})
      : super._();

  @override
  PersonDTO rebuild(void Function(PersonDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PersonDTOBuilder toBuilder() => new PersonDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PersonDTO &&
        personId == other.personId &&
        firstName == other.firstName &&
        surname == other.surname &&
        nickname == other.nickname &&
        email == other.email &&
        mobilePhone == other.mobilePhone &&
        city == other.city &&
        countryCode == other.countryCode &&
        country == other.country &&
        participations == other.participations;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, personId.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, surname.hashCode);
    _$hash = $jc(_$hash, nickname.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, mobilePhone.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, countryCode.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, participations.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PersonDTO')
          ..add('personId', personId)
          ..add('firstName', firstName)
          ..add('surname', surname)
          ..add('nickname', nickname)
          ..add('email', email)
          ..add('mobilePhone', mobilePhone)
          ..add('city', city)
          ..add('countryCode', countryCode)
          ..add('country', country)
          ..add('participations', participations))
        .toString();
  }
}

class PersonDTOBuilder implements Builder<PersonDTO, PersonDTOBuilder> {
  _$PersonDTO? _$v;

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

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _mobilePhone;
  String? get mobilePhone => _$this._mobilePhone;
  set mobilePhone(String? mobilePhone) => _$this._mobilePhone = mobilePhone;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _countryCode;
  String? get countryCode => _$this._countryCode;
  set countryCode(String? countryCode) => _$this._countryCode = countryCode;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  ListBuilder<ParticipationDTO>? _participations;
  ListBuilder<ParticipationDTO> get participations =>
      _$this._participations ??= new ListBuilder<ParticipationDTO>();
  set participations(ListBuilder<ParticipationDTO>? participations) =>
      _$this._participations = participations;

  PersonDTOBuilder() {
    PersonDTO._defaults(this);
  }

  PersonDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _personId = $v.personId;
      _firstName = $v.firstName;
      _surname = $v.surname;
      _nickname = $v.nickname;
      _email = $v.email;
      _mobilePhone = $v.mobilePhone;
      _city = $v.city;
      _countryCode = $v.countryCode;
      _country = $v.country;
      _participations = $v.participations?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PersonDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PersonDTO;
  }

  @override
  void update(void Function(PersonDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PersonDTO build() => _build();

  _$PersonDTO _build() {
    _$PersonDTO _$result;
    try {
      _$result = _$v ??
          new _$PersonDTO._(
              personId: personId,
              firstName: firstName,
              surname: surname,
              nickname: nickname,
              email: email,
              mobilePhone: mobilePhone,
              city: city,
              countryCode: countryCode,
              country: country,
              participations: _participations?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'participations';
        _participations?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PersonDTO', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
