// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reg_event_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegEventDTO extends RegEventDTO {
  @override
  final int? eventId;
  @override
  final String? name;
  @override
  final String? start;
  @override
  final String? end;
  @override
  final int? type;
  @override
  final String? scanTime;

  factory _$RegEventDTO([void Function(RegEventDTOBuilder)? updates]) =>
      (new RegEventDTOBuilder()..update(updates))._build();

  _$RegEventDTO._(
      {this.eventId, this.name, this.start, this.end, this.type, this.scanTime})
      : super._();

  @override
  RegEventDTO rebuild(void Function(RegEventDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegEventDTOBuilder toBuilder() => new RegEventDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegEventDTO &&
        eventId == other.eventId &&
        name == other.name &&
        start == other.start &&
        end == other.end &&
        type == other.type &&
        scanTime == other.scanTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, eventId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, start.hashCode);
    _$hash = $jc(_$hash, end.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, scanTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegEventDTO')
          ..add('eventId', eventId)
          ..add('name', name)
          ..add('start', start)
          ..add('end', end)
          ..add('type', type)
          ..add('scanTime', scanTime))
        .toString();
  }
}

class RegEventDTOBuilder implements Builder<RegEventDTO, RegEventDTOBuilder> {
  _$RegEventDTO? _$v;

  int? _eventId;
  int? get eventId => _$this._eventId;
  set eventId(int? eventId) => _$this._eventId = eventId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _start;
  String? get start => _$this._start;
  set start(String? start) => _$this._start = start;

  String? _end;
  String? get end => _$this._end;
  set end(String? end) => _$this._end = end;

  int? _type;
  int? get type => _$this._type;
  set type(int? type) => _$this._type = type;

  String? _scanTime;
  String? get scanTime => _$this._scanTime;
  set scanTime(String? scanTime) => _$this._scanTime = scanTime;

  RegEventDTOBuilder() {
    RegEventDTO._defaults(this);
  }

  RegEventDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _eventId = $v.eventId;
      _name = $v.name;
      _start = $v.start;
      _end = $v.end;
      _type = $v.type;
      _scanTime = $v.scanTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegEventDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RegEventDTO;
  }

  @override
  void update(void Function(RegEventDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegEventDTO build() => _build();

  _$RegEventDTO _build() {
    final _$result = _$v ??
        new _$RegEventDTO._(
            eventId: eventId,
            name: name,
            start: start,
            end: end,
            type: type,
            scanTime: scanTime);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
