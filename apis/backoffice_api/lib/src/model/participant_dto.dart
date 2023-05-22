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
/// * [participantId] 
@BuiltValue()
abstract class ParticipantDTO implements Built<ParticipantDTO, ParticipantDTOBuilder> {
  @BuiltValueField(wireName: r'eventId')
  int? get eventId;

  @BuiltValueField(wireName: r'participantId')
  String? get participantId;

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
    if (object.participantId != null) {
      yield r'participantId';
      yield serializers.serialize(
        object.participantId,
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
        case r'participantId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.participantId = valueDes;
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

