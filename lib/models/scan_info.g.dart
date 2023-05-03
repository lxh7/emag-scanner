// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_info.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class ScanInfo extends _ScanInfo
    with RealmEntity, RealmObjectBase, RealmObject {
  ScanInfo(
    int activityId,
    String personKey,
    DateTime scanTime,
  ) {
    RealmObjectBase.set(this, 'activityId', activityId);
    RealmObjectBase.set(this, 'personKey', personKey);
    RealmObjectBase.set(this, 'scanTime', scanTime);
  }

  ScanInfo._();

  @override
  int get activityId => RealmObjectBase.get<int>(this, 'activityId') as int;
  @override
  set activityId(int value) => RealmObjectBase.set(this, 'activityId', value);

  @override
  String get personKey =>
      RealmObjectBase.get<String>(this, 'personKey') as String;
  @override
  set personKey(String value) => RealmObjectBase.set(this, 'personKey', value);

  @override
  DateTime get scanTime =>
      RealmObjectBase.get<DateTime>(this, 'scanTime') as DateTime;
  @override
  set scanTime(DateTime value) => RealmObjectBase.set(this, 'scanTime', value);

  @override
  Stream<RealmObjectChanges<ScanInfo>> get changes =>
      RealmObjectBase.getChanges<ScanInfo>(this);

  @override
  ScanInfo freeze() => RealmObjectBase.freezeObject<ScanInfo>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ScanInfo._);
    return const SchemaObject(ObjectType.realmObject, ScanInfo, 'ScanInfo', [
      SchemaProperty('activityId', RealmPropertyType.int),
      SchemaProperty('personKey', RealmPropertyType.string),
      SchemaProperty('scanTime', RealmPropertyType.timestamp, indexed: true),
    ]);
  }
}
