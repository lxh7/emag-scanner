//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'print_request_dto.g.dart';

/// PrintRequestDTO
///
/// Properties:
/// * [personKey] 
/// * [printerName] 
@BuiltValue()
abstract class PrintRequestDTO implements Built<PrintRequestDTO, PrintRequestDTOBuilder> {
  @BuiltValueField(wireName: r'personKey')
  String? get personKey;

  @BuiltValueField(wireName: r'printerName')
  String? get printerName;

  PrintRequestDTO._();

  factory PrintRequestDTO([void updates(PrintRequestDTOBuilder b)]) = _$PrintRequestDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrintRequestDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrintRequestDTO> get serializer => _$PrintRequestDTOSerializer();
}

class _$PrintRequestDTOSerializer implements PrimitiveSerializer<PrintRequestDTO> {
  @override
  final Iterable<Type> types = const [PrintRequestDTO, _$PrintRequestDTO];

  @override
  final String wireName = r'PrintRequestDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrintRequestDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.personKey != null) {
      yield r'personKey';
      yield serializers.serialize(
        object.personKey,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.printerName != null) {
      yield r'printerName';
      yield serializers.serialize(
        object.printerName,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PrintRequestDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PrintRequestDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'personKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.personKey = valueDes;
          break;
        case r'printerName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.printerName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrintRequestDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrintRequestDTOBuilder();
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

