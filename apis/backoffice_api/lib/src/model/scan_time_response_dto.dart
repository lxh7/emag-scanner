//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'scan_time_response_dto.g.dart';

/// ScanTimeResponseDTO
///
/// Properties:
/// * [grant] 
/// * [prevScanTime] 
@BuiltValue()
abstract class ScanTimeResponseDTO implements Built<ScanTimeResponseDTO, ScanTimeResponseDTOBuilder> {
  @BuiltValueField(wireName: r'grant')
  String? get grant;

  @BuiltValueField(wireName: r'prevScanTime')
  String? get prevScanTime;

  ScanTimeResponseDTO._();

  factory ScanTimeResponseDTO([void updates(ScanTimeResponseDTOBuilder b)]) = _$ScanTimeResponseDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScanTimeResponseDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScanTimeResponseDTO> get serializer => _$ScanTimeResponseDTOSerializer();
}

class _$ScanTimeResponseDTOSerializer implements PrimitiveSerializer<ScanTimeResponseDTO> {
  @override
  final Iterable<Type> types = const [ScanTimeResponseDTO, _$ScanTimeResponseDTO];

  @override
  final String wireName = r'ScanTimeResponseDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScanTimeResponseDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.grant != null) {
      yield r'grant';
      yield serializers.serialize(
        object.grant,
        specifiedType: const FullType(String),
      );
    }
    if (object.prevScanTime != null) {
      yield r'prevScanTime';
      yield serializers.serialize(
        object.prevScanTime,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ScanTimeResponseDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScanTimeResponseDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'grant':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.grant = valueDes;
          break;
        case r'prevScanTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.prevScanTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScanTimeResponseDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScanTimeResponseDTOBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

