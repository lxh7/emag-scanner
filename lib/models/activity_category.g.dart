// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_category.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class ActivityCategory extends _ActivityCategory
    with RealmEntity, RealmObjectBase, RealmObject {
  ActivityCategory(
    int id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  ActivityCategory._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<ActivityCategory>> get changes =>
      RealmObjectBase.getChanges<ActivityCategory>(this);

  @override
  ActivityCategory freeze() =>
      RealmObjectBase.freezeObject<ActivityCategory>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ActivityCategory._);
    return const SchemaObject(
        ObjectType.realmObject, ActivityCategory, 'ActivityCategory', [
      SchemaProperty('id', RealmPropertyType.int,
          primaryKey: true, indexed: true),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}
