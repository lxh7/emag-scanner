// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_time_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScanTimeDTO extends ScanTimeDTO {
  @override
  final String? scanTime;

  factory _$ScanTimeDTO([void Function(ScanTimeDTOBuilder)? updates]) =>
      (new ScanTimeDTOBuilder()..update(updates))._build();

  _$ScanTimeDTO._({this.scanTime}) : super._();

  @override
  ScanTimeDTO rebuild(void Function(ScanTimeDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScanTimeDTOBuilder toBuilder() => new ScanTimeDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScanTimeDTO && scanTime == other.scanTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, scanTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScanTimeDTO')
          ..add('scanTime', scanTime))
        .toString();
  }
}

class ScanTimeDTOBuilder implements Builder<ScanTimeDTO, ScanTimeDTOBuilder> {
  _$ScanTimeDTO? _$v;

  String? _scanTime;
  String? get scanTime => _$this._scanTime;
  set scanTime(String? scanTime) => _$this._scanTime = scanTime;

  ScanTimeDTOBuilder() {
    ScanTimeDTO._defaults(this);
  }

  ScanTimeDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _scanTime = $v.scanTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScanTimeDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ScanTimeDTO;
  }

  @override
  void update(void Function(ScanTimeDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScanTimeDTO build() => _build();

  _$ScanTimeDTO _build() {
    final _$result = _$v ?? new _$ScanTimeDTO._(scanTime: scanTime);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
