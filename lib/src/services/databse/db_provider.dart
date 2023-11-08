// ignore_for_file: constant_identifier_names, avoid_print

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  // single reference to the database throughout the app
  static Database? _database;

  Future<String> dbPath = getDatabasesPath();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  static const String TABLE_PERSONALINFO = 'TABLE_PersonalInfo';
  static const String TABLE_CONTACTINFO = 'TABLE_ContactInfo';
  static const String TABLE_QUALIFICATIONS = 'TABLE_Qualifications';
  static const String TABLE_EXPERIANCE = 'TABLE_Experiance';
  static const String TABLE_SKILLS = 'TABLE_Skills';
  static const String TABLE_USERS = 'TABLE_Users';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_NAME = 'fullname';
  static const String COLUMN_PASSWORD = 'password';
  static const String COLUMN_GENDER = 'gender';
  static const String COLUMN_NUM = 'number';
  static const String COLUMN_EMAIL = 'email';
  static const String COLUMN_ADDRESS = 'address';
  static const String COLUMN_CITY = 'city';
  static const String COLUMN_STATE = 'state';
  static const String COLUMN_POSTALCODE = 'postalcode';
  static const String COLUMN_UNINAME = 'uniname';
  static const String COLUMN_COURSE = 'course';
  static const String COLUMN_FROMYEAR = 'fromyear';
  static const String COLUMN_TOYEAR = 'toyear';
  static const String COLUMN_JOBTITLE = 'jobtitle';
  static const String COLUMN_COMPANYNAME = 'companyname';
  static const String COLUMN_SKILL = 'skill';
}

Future<Database> createDatabase() async {
  String dbPath = await getDatabasesPath();
  return await openDatabase(
    join(dbPath, 'cvdataDB.db'),
    version: 1,
    onCreate: (Database database, int version) async {
      if (kDebugMode) {
        print('Creating database tables ....');
      }
      await database.execute(
        "CREATE TABLE ${DatabaseProvider.TABLE_PERSONALINFO}(${DatabaseProvider.COLUMN_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${DatabaseProvider.COLUMN_NAME} TEXT,${DatabaseProvider.COLUMN_GENDER} TEXT, ${DatabaseProvider.COLUMN_NUM} TEXT , ${DatabaseProvider.COLUMN_EMAIL} TEXT)",
      );
      await database.execute(
        "CREATE TABLE ${DatabaseProvider.TABLE_CONTACTINFO}(${DatabaseProvider.COLUMN_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${DatabaseProvider.COLUMN_ADDRESS} TEXT,${DatabaseProvider.COLUMN_CITY} TEXT, ${DatabaseProvider.COLUMN_STATE} TEXT , ${DatabaseProvider.COLUMN_POSTALCODE} TEXT, ${DatabaseProvider.COLUMN_EMAIL} TEXT)",
      );
      await database.execute(
        "CREATE TABLE ${DatabaseProvider.TABLE_QUALIFICATIONS}(${DatabaseProvider.COLUMN_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${DatabaseProvider.COLUMN_UNINAME} TEXT,${DatabaseProvider.COLUMN_COURSE} TEXT, ${DatabaseProvider.COLUMN_FROMYEAR} TEXT , ${DatabaseProvider.COLUMN_TOYEAR} TEXT, ${DatabaseProvider.COLUMN_EMAIL} TEXT)",
      );
      await database.execute(
        "CREATE TABLE ${DatabaseProvider.TABLE_EXPERIANCE}(${DatabaseProvider.COLUMN_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${DatabaseProvider.COLUMN_JOBTITLE} TEXT,${DatabaseProvider.COLUMN_COMPANYNAME} TEXT, ${DatabaseProvider.COLUMN_FROMYEAR} TEXT , ${DatabaseProvider.COLUMN_TOYEAR} TEXT, ${DatabaseProvider.COLUMN_EMAIL} TEXT)",
      );
      await database.execute(
        "CREATE TABLE ${DatabaseProvider.TABLE_SKILLS}(${DatabaseProvider.COLUMN_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${DatabaseProvider.COLUMN_SKILL} TEXT , ${DatabaseProvider.COLUMN_EMAIL} TEXT)",
      );
      await database.execute(
        "CREATE TABLE ${DatabaseProvider.TABLE_USERS}(${DatabaseProvider.COLUMN_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${DatabaseProvider.COLUMN_NAME} TEXT , ${DatabaseProvider.COLUMN_EMAIL} TEXT,${DatabaseProvider.COLUMN_PASSWORD} TEXT)",
      );
    },
  );
}

deletedatabase() async {
  // Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'cvdataDB.db');
  try {
    await deleteDatabase(path);
  } catch (e) {
    print(e.toString());
  }
}
