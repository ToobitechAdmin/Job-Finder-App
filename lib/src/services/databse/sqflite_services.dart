// ignore_for_file: prefer_is_empty

import 'package:flutter/foundation.dart';
import 'package:job_finder/src/services/databse/classmodel_database/contactcm.dart';
import 'package:job_finder/src/services/databse/classmodel_database/experiancecm.dart';
import 'package:job_finder/src/services/databse/classmodel_database/personalinfocm.dart';
import 'package:job_finder/src/services/databse/classmodel_database/qualificationcm.dart';
import 'package:job_finder/src/services/databse/classmodel_database/skillscm.dart';
import 'package:job_finder/src/services/databse/db_provider.dart';

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- Insert DATA into Database------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------

insertpersonal(PersonalInformationCM personal) async {
  final db = await DatabaseProvider.db.database;
  try {
    personal.id =
        await db!.insert(DatabaseProvider.TABLE_PERSONALINFO, personal.toMap());
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

insertcontact(ContactCM personal) async {
  final db = await DatabaseProvider.db.database;
  try {
    personal.id =
        await db!.insert(DatabaseProvider.TABLE_CONTACTINFO, personal.toMap());
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

insertqualifications(QualificationsCM personal) async {
  final db = await DatabaseProvider.db.database;
  try {
    personal.id = await db!
        .insert(DatabaseProvider.TABLE_QUALIFICATIONS, personal.toMap());
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

insertexperiance(ExperianceCM personal) async {
  final db = await DatabaseProvider.db.database;
  try {
    personal.id =
        await db!.insert(DatabaseProvider.TABLE_EXPERIANCE, personal.toMap());
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

insertskills(SkillCM personal) async {
  final db = await DatabaseProvider.db.database;
  try {
    personal.id =
        await db!.insert(DatabaseProvider.TABLE_SKILLS, personal.toMap());
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

Future<String> insertusers(UserCM personal) async {
  final db = await DatabaseProvider.db.database;
  bool c = await checkusers(personal.email.toString());
  if (c == false) {
    try {
      personal.id =
          await db!.insert(DatabaseProvider.TABLE_USERS, personal.toMap());
      return 'created';
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return 'error';
    }
  } else {
    return 'exists';
  }
}

Future<bool> checkusers(String email) async {
  List<UserCM> checkuserslist = [];
  final db = await DatabaseProvider.db.database;
  try {
    final List<Map<String, dynamic>> queryresult = await db!.query(
        DatabaseProvider.TABLE_USERS,
        where: '${DatabaseProvider.COLUMN_EMAIL}= ?',
        whereArgs: [email]);
    checkuserslist = queryresult.map((e) => UserCM.fromMap(e)).toList();
    // print(userslist.length);
    if (checkuserslist.length > 0) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
    return Future.value(false);
  }
}

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- Get DATA from Database------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
class DataBaseState with ChangeNotifier {
  List<PersonalInformationCM> personalinfolist = [];
  List<ContactCM> contactlist = [];
  List<QualificationsCM> qualificationslist = [];
  List<ExperianceCM> experiancelist = [];
  List<SkillCM> skillslist = [];

  getpersonal() async {
    final db = await DatabaseProvider.db.database;
    try {
      final List<Map<String, dynamic>> queryresult = await db!.query(
          DatabaseProvider.TABLE_PERSONALINFO,
          where: '${DatabaseProvider.COLUMN_EMAIL}= ?',
          whereArgs: [useremail]);
      personalinfolist =
          queryresult.map((e) => PersonalInformationCM.fromMap(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    notifyListeners();
  }

  getcontact() async {
    final db = await DatabaseProvider.db.database;
    try {
      final List<Map<String, dynamic>> queryresult = await db!.query(
          DatabaseProvider.TABLE_CONTACTINFO,
          where: '${DatabaseProvider.COLUMN_EMAIL}= ?',
          whereArgs: [useremail]);
      contactlist = queryresult.map((e) => ContactCM.fromMap(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    notifyListeners();
  }

  getqualifications() async {
    final db = await DatabaseProvider.db.database;
    try {
      final List<Map<String, dynamic>> queryresult = await db!.query(
          DatabaseProvider.TABLE_QUALIFICATIONS,
          where: '${DatabaseProvider.COLUMN_EMAIL}= ?',
          whereArgs: [useremail]);
      qualificationslist =
          queryresult.map((e) => QualificationsCM.fromMap(e)).toList();

      qualificationslist = qualificationslist
        ..sort(((a, b) => b.toyear!.compareTo(a.toyear.toString())));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    notifyListeners();
  }

  getexperiance() async {
    final db = await DatabaseProvider.db.database;
    try {
      final List<Map<String, dynamic>> queryresult = await db!.query(
          DatabaseProvider.TABLE_EXPERIANCE,
          where: '${DatabaseProvider.COLUMN_EMAIL}= ?',
          whereArgs: [useremail]);
      experiancelist = queryresult.map((e) => ExperianceCM.fromMap(e)).toList();
      experiancelist = experiancelist
        ..sort(((a, b) => b.fromyear!.compareTo(a.fromyear.toString())));
      // print(experiancelist);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    notifyListeners();
  }

  getskills() async {
    final db = await DatabaseProvider.db.database;
    try {
      final List<Map<String, dynamic>> queryresult = await db!.query(
          DatabaseProvider.TABLE_SKILLS,
          where: '${DatabaseProvider.COLUMN_EMAIL}= ?',
          whereArgs: [useremail]);
      skillslist = queryresult.map((e) => SkillCM.fromMap(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    notifyListeners();
  }
}

List<ContactCM> usercheck = [];

List<UserCM> userslist = [];
Future<bool> checkuserexistance(String email) async {
  final db = await DatabaseProvider.db.database;
  try {
    final List<Map<String, dynamic>> queryresult = await db!.query(
        DatabaseProvider.TABLE_CONTACTINFO,
        where: '${DatabaseProvider.COLUMN_EMAIL}= ?',
        whereArgs: [email]);
    usercheck = queryresult.map((e) => ContactCM.fromMap(e)).toList();
    // print(usercheck.length);
    if (usercheck.length > 0) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
    return Future.value(false);
  }
}

Future<bool> getusers(String email, String pass) async {
  final db = await DatabaseProvider.db.database;
  try {
    final List<Map<String, dynamic>> queryresult = await db!.query(
        DatabaseProvider.TABLE_USERS,
        where:
            '${DatabaseProvider.COLUMN_EMAIL}= ? AND ${DatabaseProvider.COLUMN_PASSWORD} = ?',
        whereArgs: [email, pass]);
    userslist = queryresult.map((e) => UserCM.fromMap(e)).toList();
    // print(userslist.length);
    if (userslist.length > 0) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
    return Future.value(false);
  }
}
