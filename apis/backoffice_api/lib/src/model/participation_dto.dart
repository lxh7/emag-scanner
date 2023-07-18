//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:backoffice_api/src/model/person_dto.dart';
import 'package:backoffice_api/src/model/event_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'participation_dto.g.dart';

/// ParticipationDTO
///
/// Properties:
/// * [no] 
/// * [scanTime] 
/// * [eventId] 
/// * [type] 
/// * [paid] 
/// * [in_] 
/// * [event] 
/// * [personId] 
/// * [person] 
/// * [answer1] 
/// * [answer2] 
/// * [answer3] 
@BuiltValue()
abstract class ParticipationDTO implements Built<ParticipationDTO, ParticipationDTOBuilder> {
  @BuiltValueField(wireName: r'no')
  int? get no;

  @BuiltValueField(wireName: r'scanTime')
  String? get scanTime;

  @BuiltValueField(wireName: r'eventId')
  int? get eventId;

  @BuiltValueField(wireName: r'type')
  int? get type;

  @BuiltValueField(wireName: r'paid')
  bool? get paid;

  @BuiltValueField(wireName: r'in')
  bool? get in_;

  @BuiltValueField(wireName: r'event')
  EventDTO? get event;

  @BuiltValueField(wireName: r'personId')
  String? get personId;

  @BuiltValueField(wireName: r'person')
  PersonDTO? get person;

  @BuiltValueField(wireName: r'answer1')
  String? get answer1;

  @BuiltValueField(wireName: r'answer2')
  String? get answer2;

  @BuiltValueField(wireName: r'answer3')
  String? get answer3;

  ParticipationDTO._();

  factory ParticipationDTO([void updates(ParticipationDTOBuilder b)]) = _$ParticipationDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParticipationDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParticipationDTO> get serializer => _$ParticipationDTOSerializer();
}

class _$ParticipationDTOSerializer implements PrimitiveSerializer<ParticipationDTO> {
  @override
  final Iterable<Type> types = const [ParticipationDTO, _$ParticipationDTO];

  @override
  final String wireName = r'ParticipationDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParticipationDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.no != null) {
      yield r'no';
      yield serializers.serialize(
        object.no,
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
    if (object.eventId != null) {
      yield r'eventId';
      yield serializers.serialize(
        object.eventId,
        specifiedType: const FullType(int),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(int),
      );
    }
    if (object.paid != null) {
      yield r'paid';
      yield serializers.serialize(
        object.paid,
        specifiedType: const FullType(bool),
      );
    }
    if (object.in_ != null) {
      yield r'in';
      yield serializers.serialize(
        object.in_,
        specifiedType: const FullType(bool),
      );
    }
    if (object.event != null) {
      yield r'event';
      yield serializers.serialize(
        object.event,
        specifiedType: const FullType(EventDTO),
      );
    }
    if (object.personId != null) {
      yield r'personId';
      yield serializers.serialize(
        object.personId,
        specifiedType: const FullType(String),
      );
    }
    if (object.person != null) {
      yield r'person';
      yield serializers.serialize(
        object.person,
        specifiedType: const FullType(PersonDTO),
      );
    }
    if (object.answer1 != null) {
      yield r'answer1';
      yield serializers.serialize(
        object.answer1,
        specifiedType: const FullType(String),
      );
    }
    if (object.answer2 != null) {
      yield r'answer2';
      yield serializers.serialize(
        object.answer2,
        specifiedType: const FullType(String),
      );
    }
    if (object.answer3 != null) {
      yield r'answer3';
      yield serializers.serialize(
        object.answer3,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ParticipationDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParticipationDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.no = valueDes;
          break;
        case r'scanTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.scanTime = valueDes;
          break;
        case r'eventId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.eventId = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.type = valueDes;
          break;
        case r'paid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.paid = valueDes;
          break;
        case r'in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.in_ = valueDes;
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EventDTO),
          ) as EventDTO;
          result.event.replace(valueDes);
          break;
        case r'personId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.personId = valueDes;
          break;
        case r'person':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PersonDTO),
          ) as PersonDTO;
          result.person.replace(valueDes);
          break;
        case r'answer1':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.answer1 = valueDes;
          break;
        case r'answer2':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.answer2 = valueDes;
          break;
        case r'answer3':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.answer3 = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParticipationDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParticipationDTOBuilder();
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

