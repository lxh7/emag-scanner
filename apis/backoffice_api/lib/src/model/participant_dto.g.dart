// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParticipantDTO extends ParticipantDTO {
  @override
  final int? eventId;
  @override
  final String? participantId;

  factory _$ParticipantDTO([void Function(ParticipantDTOBuilder)? updates]) =>
      (new ParticipantDTOBuilder()..update(updates))._build();

  _$ParticipantDTO._({this.eventId, this.participantId}) : super._();

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
        participantId == other.participantId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, eventId.hashCode);
    _$hash = $jc(_$hash, participantId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParticipantDTO')
          ..add('eventId', eventId)
          ..add('participantId', participantId))
        .toString();
  }
}

class ParticipantDTOBuilder
    implements Builder<ParticipantDTO, ParticipantDTOBuilder> {
  _$ParticipantDTO? _$v;

  int? _eventId;
  int? get eventId => _$this._eventId;
  set eventId(int? eventId) => _$this._eventId = eventId;

  String? _participantId;
  String? get participantId => _$this._participantId;
  set participantId(String? participantId) =>
      _$this._participantId = participantId;

  ParticipantDTOBuilder() {
    ParticipantDTO._defaults(this);
  }

  ParticipantDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _eventId = $v.eventId;
      _participantId = $v.participantId;
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
        new _$ParticipantDTO._(eventId: eventId, participantId: participantId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
