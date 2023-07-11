//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'participant_dto.g.dart';

/// ParticipantDTO
///
/// Properties:
/// * [eventId] 
/// * [personId] 
/// * [firstName] 
/// * [surname] 
/// * [nickname] 
/// * [mobilePhone] 
@BuiltValue()
abstract class ParticipantDTO implements Built<ParticipantDTO, ParticipantDTOBuilder> {
  @BuiltValueField(wireName: r'eventId')
  int? get eventId;

  @BuiltValueField(wireName: r'personId')
  String? get personId;

  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'surname')
  String? get surname;

  @BuiltValueField(wireName: r'nickname')
  String? get nickname;

  @BuiltValueField(wireName: r'mobilePhone')
  String? get mobilePhone;

  ParticipantDTO._();

  factory ParticipantDTO([void updates(ParticipantDTOBuilder b)]) = _$ParticipantDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParticipantDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParticipantDTO> get serializer => _$ParticipantDTOSerializer();
}

class _$ParticipantDTOSerializer implements PrimitiveSerializer<ParticipantDTO> {
  @override
  final Iterable<Type> types = const [ParticipantDTO, _$ParticipantDTO];

  @override
  final String wireName = r'ParticipantDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParticipantDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.eventId != null) {
      yield r'eventId';
      yield serializers.serialize(
        object.eventId,
        specifiedType: const FullType(int),
      );
    }
    if (object.personId != null) {
      yield r'personId';
      yield serializers.serialize(
        object.personId,
        specifiedType: const FullType(String),
      );
    }
    if (object.firstName != null) {
      yield r'firstName';
      yield serializers.serialize(
        object.firstName,
        specifiedType: const FullType(String),
      );
    }
    if (object.surname != null) {
      yield r'surname';
      yield serializers.serialize(
        object.surname,
        specifiedType: const FullType(String),
      );
    }
    if (object.nickname != null) {
      yield r'nickname';
      yield serializers.serialize(
        object.nickname,
        specifiedType: const FullType(String),
      );
    }
    if (object.mobilePhone != null) {
      yield r'mobilePhone';
      yield serializers.serialize(
        object.mobilePhone,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ParticipantDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParticipantDTOBuilder result,
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
        case r'personId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.personId = valueDes;
          break;
        case r'firstName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.firstName = valueDes;
          break;
        case r'surname':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.surname = valueDes;
          break;
        case r'nickname':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nickname = valueDes;
          break;
        case r'mobilePhone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mobilePhone = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParticipantDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParticipantDTOBuilder();
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

