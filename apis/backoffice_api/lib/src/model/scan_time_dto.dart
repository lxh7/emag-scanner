//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'scan_time_dto.g.dart';

/// ScanTimeDTO
///
/// Properties:
/// * [scanTime] 
@BuiltValue()
abstract class ScanTimeDTO implements Built<ScanTimeDTO, ScanTimeDTOBuilder> {
  @BuiltValueField(wireName: r'scanTime')
  String? get scanTime;

  ScanTimeDTO._();

  factory ScanTimeDTO([void updates(ScanTimeDTOBuilder b)]) = _$ScanTimeDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScanTimeDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScanTimeDTO> get serializer => _$ScanTimeDTOSerializer();
}

class _$ScanTimeDTOSerializer implements PrimitiveSerializer<ScanTimeDTO> {
  @override
  final Iterable<Type> types = const [ScanTimeDTO, _$ScanTimeDTO];

  @override
  final String wireName = r'ScanTimeDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScanTimeDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.scanTime != null) {
      yield r'scanTime';
      yield serializers.serialize(
        object.scanTime,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ScanTimeDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScanTimeDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'scanTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.scanTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScanTimeDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScanTimeDTOBuilder();
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

