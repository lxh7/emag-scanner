//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:backoffice_api/src/date_serializer.dart';
import 'package:backoffice_api/src/model/date.dart';

import 'package:backoffice_api/src/model/category_dto.dart';
import 'package:backoffice_api/src/model/event_dto.dart';
import 'package:backoffice_api/src/model/participant_dto.dart';
import 'package:backoffice_api/src/model/person_dto.dart';
import 'package:backoffice_api/src/model/reg_event_dto.dart';
import 'package:backoffice_api/src/model/scan_time_dto.dart';
import 'package:backoffice_api/src/model/scan_time_response_dto.dart';

part 'serializers.g.dart';

@SerializersFor([
  CategoryDTO,
  EventDTO,
  ParticipantDTO,
  PersonDTO,
  RegEventDTO,
  ScanTimeDTO,
  ScanTimeResponseDTO,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(CategoryDTO)]),
        () => ListBuilder<CategoryDTO>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(EventDTO)]),
        () => ListBuilder<EventDTO>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ParticipantDTO)]),
        () => ListBuilder<ParticipantDTO>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
