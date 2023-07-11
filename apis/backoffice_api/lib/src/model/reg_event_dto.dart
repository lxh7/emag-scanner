//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reg_event_dto.g.dart';

/// RegEventDTO
///
/// Properties:
/// * [eventId] 
/// * [name] 
/// * [start] 
/// * [end] 
/// * [type] 
/// * [scanTime] 
@BuiltValue()
abstract class RegEventDTO implements Built<RegEventDTO, RegEventDTOBuilder> {
  @BuiltValueField(wireName: r'eventId')
  int? get eventId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'start')
  String? get start;

  @BuiltValueField(wireName: r'end')
  String? get end;

  @BuiltValueField(wireName: r'type')
  int? get type;

  @BuiltValueField(wireName: r'scanTime')
  String? get scanTime;

  RegEventDTO._();

  factory RegEventDTO([void updates(RegEventDTOBuilder b)]) = _$RegEventDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RegEventDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RegEventDTO> get serializer => _$RegEventDTOSerializer();
}

class _$RegEventDTOSerializer implements PrimitiveSerializer<RegEventDTO> {
  @override
  final Iterable<Type> types = const [RegEventDTO, _$RegEventDTO];

  @override
  final String wireName = r'RegEventDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RegEventDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.eventId != null) {
      yield r'eventId';
      yield serializers.serialize(
        object.eventId,
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
    if (object.start != null) {
      yield r'start';
      yield serializers.serialize(
        object.start,
        specifiedType: const FullType(String),
      );
    }
    if (object.end != null) {
      yield r'end';
      yield serializers.serialize(
        object.end,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(int),
      );
    }
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
    RegEventDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RegEventDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'eventId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.eventId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'start':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.start = valueDes;
          break;
        case r'end':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.end = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.type = valueDes;
          break;
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
  RegEventDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RegEventDTOBuilder();
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

