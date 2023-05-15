// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_request_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrintRequestDTO extends PrintRequestDTO {
  @override
  final String? personKey;
  @override
  final String? printerName;

  factory _$PrintRequestDTO([void Function(PrintRequestDTOBuilder)? updates]) =>
      (new PrintRequestDTOBuilder()..update(updates))._build();

  _$PrintRequestDTO._({this.personKey, this.printerName}) : super._();

  @override
  PrintRequestDTO rebuild(void Function(PrintRequestDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrintRequestDTOBuilder toBuilder() =>
      new PrintRequestDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrintRequestDTO &&
        personKey == other.personKey &&
        printerName == other.printerName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, personKey.hashCode);
    _$hash = $jc(_$hash, printerName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrintRequestDTO')
          ..add('personKey', personKey)
          ..add('printerName', printerName))
        .toString();
  }
}

class PrintRequestDTOBuilder
    implements Builder<PrintRequestDTO, PrintRequestDTOBuilder> {
  _$PrintRequestDTO? _$v;

  String? _personKey;
  String? get personKey => _$this._personKey;
  set personKey(String? personKey) => _$this._personKey = personKey;

  String? _printerName;
  String? get printerName => _$this._printerName;
  set printerName(String? printerName) => _$this._printerName = printerName;

  PrintRequestDTOBuilder() {
    PrintRequestDTO._defaults(this);
  }

  PrintRequestDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _personKey = $v.personKey;
      _printerName = $v.printerName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrintRequestDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PrintRequestDTO;
  }

  @override
  void update(void Function(PrintRequestDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrintRequestDTO build() => _build();

  _$PrintRequestDTO _build() {
    final _$result = _$v ??
        new _$PrintRequestDTO._(personKey: personKey, printerName: printerName);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
