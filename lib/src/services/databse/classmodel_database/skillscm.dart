import 'package:job_finder/src/services/databse/db_provider.dart';

class SkillCM {
  int? id;
  String? skill;
  String? email;
  SkillCM({this.id, this.skill, this.email});
  SkillCM.fromMap(Map<String, dynamic> item)
      : skill = item[DatabaseProvider.COLUMN_SKILL],
        email = item[DatabaseProvider.COLUMN_EMAIL],
        id = item[DatabaseProvider.COLUMN_ID];
  Map<String, dynamic> toMap() {
    return {
      DatabaseProvider.COLUMN_SKILL: skill,
      DatabaseProvider.COLUMN_EMAIL: email,
      DatabaseProvider.COLUMN_ID: id,
    };
  }

  @override
  String toString() {
    // ignore: todo
    // TODO: implement toString
    return ('skill : $skill, email : $email , id : $id');
  }
}
