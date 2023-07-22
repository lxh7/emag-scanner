//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'category_dto.g.dart';

/// EventDTO
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [scanFunction] 
@BuiltValue()
abstract class CategoryDTO implements Built<CategoryDTO, CategoryDTOBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'scanFunction')
  int? get scanFunction;

  CategoryDTO._();

  factory CategoryDTO([void updates(CategoryDTOBuilder b)]) = _$CategoryDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CategoryDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CategoryDTO> get serializer => _$CategoryDTOSerializer();
}

class _$CategoryDTOSerializer implements PrimitiveSerializer<CategoryDTO> {
  @override
  final Iterable<Type> types = const [CategoryDTO, _$CategoryDTO];

  @override
  final String wireName = r'CategoryDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CategoryDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.scanFunction != null) {
      yield r'scanFunction';
      yield serializers.serialize(
        object.scanFunction,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CategoryDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CategoryDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'scanFunction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.scanFunction = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CategoryDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CategoryDTOBuilder();
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

