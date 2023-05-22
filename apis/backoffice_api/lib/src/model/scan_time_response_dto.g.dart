// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_time_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScanTimeResponseDTO extends ScanTimeResponseDTO {
  @override
  final String? grant;
  @override
  final String? prevScanTime;

  factory _$ScanTimeResponseDTO(
          [void Function(ScanTimeResponseDTOBuilder)? updates]) =>
      (new ScanTimeResponseDTOBuilder()..update(updates))._build();

  _$ScanTimeResponseDTO._({this.grant, this.prevScanTime}) : super._();

  @override
  ScanTimeResponseDTO rebuild(
          void Function(ScanTimeResponseDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScanTimeResponseDTOBuilder toBuilder() =>
      new ScanTimeResponseDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScanTimeResponseDTO &&
        grant == other.grant &&
        prevScanTime == other.prevScanTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, grant.hashCode);
    _$hash = $jc(_$hash, prevScanTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScanTimeResponseDTO')
          ..add('grant', grant)
          ..add('prevScanTime', prevScanTime))
        .toString();
  }
}

class ScanTimeResponseDTOBuilder
    implements Builder<ScanTimeResponseDTO, ScanTimeResponseDTOBuilder> {
  _$ScanTimeResponseDTO? _$v;

  String? _grant;
  String? get grant => _$this._grant;
  set grant(String? grant) => _$this._grant = grant;

  String? _prevScanTime;
  String? get prevScanTime => _$this._prevScanTime;
  set prevScanTime(String? prevScanTime) => _$this._prevScanTime = prevScanTime;

  ScanTimeResponseDTOBuilder() {
    ScanTimeResponseDTO._defaults(this);
  }

  ScanTimeResponseDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _grant = $v.grant;
      _prevScanTime = $v.prevScanTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScanTimeResponseDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ScanTimeResponseDTO;
  }

  @override
  void update(void Function(ScanTimeResponseDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScanTimeResponseDTO build() => _build();

  _$ScanTimeResponseDTO _build() {
    final _$result = _$v ??
        new _$ScanTimeResponseDTO._(grant: grant, prevScanTime: prevScanTime);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
