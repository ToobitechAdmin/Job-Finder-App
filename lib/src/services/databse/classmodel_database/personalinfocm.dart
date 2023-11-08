import 'package:job_finder/src/services/databse/db_provider.dart';

class PersonalInformationCM {
  int? id;
  String? fullname;
  String? gender;
  String? number;
  String? email;
  PersonalInformationCM(
      {this.id, this.fullname, this.gender, this.number, this.email});
  Map<String, dynamic> toMap() {
    return {
      DatabaseProvider.COLUMN_NAME: fullname,
      DatabaseProvider.COLUMN_GENDER: gender,
      DatabaseProvider.COLUMN_NUM: number,
      DatabaseProvider.COLUMN_EMAIL: email,
      DatabaseProvider.COLUMN_ID: id,
    };
  }

  PersonalInformationCM.fromMap(Map<String, dynamic> item)
      : fullname = item[DatabaseProvider.COLUMN_NAME],
        gender = item[DatabaseProvider.COLUMN_GENDER],
        number = item[DatabaseProvider.COLUMN_NUM],
        email = item[DatabaseProvider.COLUMN_EMAIL],
        id = item[DatabaseProvider.COLUMN_ID];

  @override
  String toString() {
    // ignore: todo
    // TODO: implement toString
    return ('id = $id   , fullname = $fullname  , gender = $gender   , number = $number  ,  Email = $email');
  }
}

String? useremail;
String? localimgpath;
