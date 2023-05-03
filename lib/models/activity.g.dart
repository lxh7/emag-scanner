// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Activity extends _Activity
    with RealmEntity, RealmObjectBase, RealmObject {
  Activity(
    int id,
    int categoryId,
    String name,
    DateTime start,
    DateTime end, {
    Iterable<ActivityParticipant> participants = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'categoryId', categoryId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'start', start);
    RealmObjectBase.set(this, 'end', end);
    RealmObjectBase.set<RealmList<ActivityParticipant>>(
        this, 'participants', RealmList<ActivityParticipant>(participants));
  }

  Activity._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  int get categoryId => RealmObjectBase.get<int>(this, 'categoryId') as int;
  @override
  set categoryId(int value) => RealmObjectBase.set(this, 'categoryId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  DateTime get start =>
      RealmObjectBase.get<DateTime>(this, 'start') as DateTime;
  @override
  set start(DateTime value) => RealmObjectBase.set(this, 'start', value);

  @override
  DateTime get end => RealmObjectBase.get<DateTime>(this, 'end') as DateTime;
  @override
  set end(DateTime value) => RealmObjectBase.set(this, 'end', value);

  @override
  RealmList<ActivityParticipant> get participants =>
      RealmObjectBase.get<ActivityParticipant>(this, 'participants')
          as RealmList<ActivityParticipant>;
  @override
  set participants(covariant RealmList<ActivityParticipant> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Activity>> get changes =>
      RealmObjectBase.getChanges<Activity>(this);

  @override
  Activity freeze() => RealmObjectBase.freezeObject<Activity>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Activity._);
    return const SchemaObject(ObjectType.realmObject, Activity, 'Activity', [
      SchemaProperty('id', RealmPropertyType.int,
          primaryKey: true, indexed: true),
      SchemaProperty('categoryId', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('start', RealmPropertyType.timestamp),
      SchemaProperty('end', RealmPropertyType.timestamp),
      SchemaProperty('participants', RealmPropertyType.object,
          linkTarget: 'ActivityParticipant',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class ActivityParticipant extends _ActivityParticipant
    with RealmEntity, RealmObjectBase, RealmObject {
  ActivityParticipant(
    String personKey, {
    DateTime? scanTime,
  }) {
    RealmObjectBase.set(this, 'personKey', personKey);
    RealmObjectBase.set(this, 'scanTime', scanTime);
  }

  ActivityParticipant._();

  @override
  String get personKey =>
      RealmObjectBase.get<String>(this, 'personKey') as String;
  @override
  set personKey(String value) => RealmObjectBase.set(this, 'personKey', value);

  @override
  DateTime? get scanTime =>
      RealmObjectBase.get<DateTime>(this, 'scanTime') as DateTime?;
  @override
  set scanTime(DateTime? value) => RealmObjectBase.set(this, 'scanTime', value);

  @override
  RealmResults<Activity> get activity =>
      RealmObjectBase.get<Activity>(this, 'activity') as RealmResults<Activity>;
  @override
  set activity(covariant RealmResults<Activity> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<ActivityParticipant>> get changes =>
      RealmObjectBase.getChanges<ActivityParticipant>(this);

  @override
  ActivityParticipant freeze() =>
      RealmObjectBase.freezeObject<ActivityParticipant>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ActivityParticipant._);
    return const SchemaObject(
        ObjectType.realmObject, ActivityParticipant, 'ActivityParticipant', [
      SchemaProperty('personKey', RealmPropertyType.string, indexed: true),
      SchemaProperty('scanTime', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('activity', RealmPropertyType.linkingObjects,
          linkOriginProperty: 'participants',
          collectionType: RealmCollectionType.list,
          linkTarget: 'Activity'),
    ]);
  }
}
