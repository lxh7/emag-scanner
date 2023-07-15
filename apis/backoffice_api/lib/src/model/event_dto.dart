//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:backoffice_api/src/model/participation_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'event_dto.g.dart';

/// EventDTO
///
/// Properties:
/// * [id] 
/// * [categoryId] 
/// * [name] 
/// * [start] 
/// * [end] 
/// * [question1] 
/// * [question2] 
/// * [question3] 
/// * [participations] 
@BuiltValue()
abstract class EventDTO implements Built<EventDTO, EventDTOBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'categoryId')
  int? get categoryId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'start')
  String? get start;

  @BuiltValueField(wireName: r'end')
  String? get end;

  @BuiltValueField(wireName: r'question1')
  String? get question1;

  @BuiltValueField(wireName: r'question2')
  String? get question2;

  @BuiltValueField(wireName: r'question3')
  String? get question3;

  @BuiltValueField(wireName: r'participations')
  BuiltList<ParticipationDTO>? get participations;

  EventDTO._();

  factory EventDTO([void updates(EventDTOBuilder b)]) = _$EventDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EventDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EventDTO> get serializer => _$EventDTOSerializer();
}

class _$EventDTOSerializer implements PrimitiveSerializer<EventDTO> {
  @override
  final Iterable<Type> types = const [EventDTO, _$EventDTO];

  @override
  final String wireName = r'EventDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EventDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.categoryId != null) {
      yield r'categoryId';
      yield serializers.serialize(
        object.categoryId,
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
    if (object.question1 != null) {
      yield r'question1';
      yield serializers.serialize(
        object.question1,
        specifiedType: const FullType(String),
      );
    }
    if (object.question2 != null) {
      yield r'question2';
      yield serializers.serialize(
        object.question2,
        specifiedType: const FullType(String),
      );
    }
    if (object.question3 != null) {
      yield r'question3';
      yield serializers.serialize(
        object.question3,
        specifiedType: const FullType(String),
      );
    }
    if (object.participations != null) {
      yield r'participations';
      yield serializers.serialize(
        object.participations,
        specifiedType: const FullType(BuiltList, [FullType(ParticipationDTO)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EventDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EventDTOBuilder result,
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
        case r'categoryId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.categoryId = valueDes;
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
        case r'question1':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.question1 = valueDes;
          break;
        case r'question2':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.question2 = valueDes;
          break;
        case r'question3':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.question3 = valueDes;
          break;
        case r'participations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ParticipationDTO)]),
          ) as BuiltList<ParticipationDTO>;
          result.participations.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EventDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EventDTOBuilder();
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

