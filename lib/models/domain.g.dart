// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Category extends _Category
    with RealmEntity, RealmObjectBase, RealmObject {
  Category(
    int id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  Category._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<Category>> get changes =>
      RealmObjectBase.getChanges<Category>(this);

  @override
  Category freeze() => RealmObjectBase.freezeObject<Category>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Category._);
    return const SchemaObject(ObjectType.realmObject, Category, 'Category', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class Activity extends _Activity
    with RealmEntity, RealmObjectBase, RealmObject {
  Activity(
    int id,
    int categoryId,
    String name,
    DateTime start,
    DateTime end, {
    String? question1,
    String? question2,
    String? question3,
    Iterable<Participation> participations = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'categoryId', categoryId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'start', start);
    RealmObjectBase.set(this, 'end', end);
    RealmObjectBase.set(this, 'question1', question1);
    RealmObjectBase.set(this, 'question2', question2);
    RealmObjectBase.set(this, 'question3', question3);
    RealmObjectBase.set<RealmList<Participation>>(
        this, 'participations', RealmList<Participation>(participations));
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
  String? get question1 =>
      RealmObjectBase.get<String>(this, 'question1') as String?;
  @override
  set question1(String? value) => RealmObjectBase.set(this, 'question1', value);

  @override
  String? get question2 =>
      RealmObjectBase.get<String>(this, 'question2') as String?;
  @override
  set question2(String? value) => RealmObjectBase.set(this, 'question2', value);

  @override
  String? get question3 =>
      RealmObjectBase.get<String>(this, 'question3') as String?;
  @override
  set question3(String? value) => RealmObjectBase.set(this, 'question3', value);

  @override
  RealmList<Participation> get participations =>
      RealmObjectBase.get<Participation>(this, 'participations')
          as RealmList<Participation>;
  @override
  set participations(covariant RealmList<Participation> value) =>
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
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('categoryId', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('start', RealmPropertyType.timestamp),
      SchemaProperty('end', RealmPropertyType.timestamp),
      SchemaProperty('question1', RealmPropertyType.string, optional: true),
      SchemaProperty('question2', RealmPropertyType.string, optional: true),
      SchemaProperty('question3', RealmPropertyType.string, optional: true),
      SchemaProperty('participations', RealmPropertyType.object,
          linkTarget: 'Participation',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class Participation extends _Participation
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Participation(
    int activityId,
    String personId, {
    Activity? activity,
    Person? person,
    DateTime? scanTime,
    bool paid = false,
    bool waitlisted = true,
    String? answer1,
    String? answer2,
    String? answer3,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Participation>({
        'paid': false,
        'waitlisted': true,
      });
    }
    RealmObjectBase.set(this, 'activityId', activityId);
    RealmObjectBase.set(this, 'activity', activity);
    RealmObjectBase.set(this, 'personId', personId);
    RealmObjectBase.set(this, 'person', person);
    RealmObjectBase.set(this, 'scanTime', scanTime);
    RealmObjectBase.set(this, 'paid', paid);
    RealmObjectBase.set(this, 'waitlisted', waitlisted);
    RealmObjectBase.set(this, 'answer1', answer1);
    RealmObjectBase.set(this, 'answer2', answer2);
    RealmObjectBase.set(this, 'answer3', answer3);
  }

  Participation._();

  @override
  int get activityId => RealmObjectBase.get<int>(this, 'activityId') as int;
  @override
  set activityId(int value) => RealmObjectBase.set(this, 'activityId', value);

  @override
  Activity? get activity =>
      RealmObjectBase.get<Activity>(this, 'activity') as Activity?;
  @override
  set activity(covariant Activity? value) =>
      RealmObjectBase.set(this, 'activity', value);

  @override
  String get personId =>
      RealmObjectBase.get<String>(this, 'personId') as String;
  @override
  set personId(String value) => RealmObjectBase.set(this, 'personId', value);

  @override
  Person? get person => RealmObjectBase.get<Person>(this, 'person') as Person?;
  @override
  set person(covariant Person? value) =>
      RealmObjectBase.set(this, 'person', value);

  @override
  DateTime? get scanTime =>
      RealmObjectBase.get<DateTime>(this, 'scanTime') as DateTime?;
  @override
  set scanTime(DateTime? value) => RealmObjectBase.set(this, 'scanTime', value);

  @override
  bool get paid => RealmObjectBase.get<bool>(this, 'paid') as bool;
  @override
  set paid(bool value) => RealmObjectBase.set(this, 'paid', value);

  @override
  bool get waitlisted => RealmObjectBase.get<bool>(this, 'waitlisted') as bool;
  @override
  set waitlisted(bool value) => RealmObjectBase.set(this, 'waitlisted', value);

  @override
  String? get answer1 =>
      RealmObjectBase.get<String>(this, 'answer1') as String?;
  @override
  set answer1(String? value) => RealmObjectBase.set(this, 'answer1', value);

  @override
  String? get answer2 =>
      RealmObjectBase.get<String>(this, 'answer2') as String?;
  @override
  set answer2(String? value) => RealmObjectBase.set(this, 'answer2', value);

  @override
  String? get answer3 =>
      RealmObjectBase.get<String>(this, 'answer3') as String?;
  @override
  set answer3(String? value) => RealmObjectBase.set(this, 'answer3', value);

  @override
  Stream<RealmObjectChanges<Participation>> get changes =>
      RealmObjectBase.getChanges<Participation>(this);

  @override
  Participation freeze() => RealmObjectBase.freezeObject<Participation>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Participation._);
    return const SchemaObject(
        ObjectType.realmObject, Participation, 'Participation', [
      SchemaProperty('activityId', RealmPropertyType.int, indexed: true),
      SchemaProperty('activity', RealmPropertyType.object,
          optional: true, linkTarget: 'Activity'),
      SchemaProperty('personId', RealmPropertyType.string, indexed: true),
      SchemaProperty('person', RealmPropertyType.object,
          optional: true, linkTarget: 'Person'),
      SchemaProperty('scanTime', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('paid', RealmPropertyType.bool),
      SchemaProperty('waitlisted', RealmPropertyType.bool),
      SchemaProperty('answer1', RealmPropertyType.string, optional: true),
      SchemaProperty('answer2', RealmPropertyType.string, optional: true),
      SchemaProperty('answer3', RealmPropertyType.string, optional: true),
    ]);
  }
}

class Person extends _Person with RealmEntity, RealmObjectBase, RealmObject {
  Person(
    String id,
    String firstName,
    String lastName,
    String nickName,
    String phone,
    String email, {
    Iterable<Participation> participations = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'firstName', firstName);
    RealmObjectBase.set(this, 'lastName', lastName);
    RealmObjectBase.set(this, 'nickName', nickName);
    RealmObjectBase.set(this, 'phone', phone);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set<RealmList<Participation>>(
        this, 'participations', RealmList<Participation>(participations));
  }

  Person._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get firstName =>
      RealmObjectBase.get<String>(this, 'firstName') as String;
  @override
  set firstName(String value) => RealmObjectBase.set(this, 'firstName', value);

  @override
  String get lastName =>
      RealmObjectBase.get<String>(this, 'lastName') as String;
  @override
  set lastName(String value) => RealmObjectBase.set(this, 'lastName', value);

  @override
  String get nickName =>
      RealmObjectBase.get<String>(this, 'nickName') as String;
  @override
  set nickName(String value) => RealmObjectBase.set(this, 'nickName', value);

  @override
  String get phone => RealmObjectBase.get<String>(this, 'phone') as String;
  @override
  set phone(String value) => RealmObjectBase.set(this, 'phone', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  RealmList<Participation> get participations =>
      RealmObjectBase.get<Participation>(this, 'participations')
          as RealmList<Participation>;
  @override
  set participations(covariant RealmList<Participation> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Person>> get changes =>
      RealmObjectBase.getChanges<Person>(this);

  @override
  Person freeze() => RealmObjectBase.freezeObject<Person>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Person._);
    return const SchemaObject(ObjectType.realmObject, Person, 'Person', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('firstName', RealmPropertyType.string),
      SchemaProperty('lastName', RealmPropertyType.string),
      SchemaProperty('nickName', RealmPropertyType.string),
      SchemaProperty('phone', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('participations', RealmPropertyType.object,
          linkTarget: 'Participation',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

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
