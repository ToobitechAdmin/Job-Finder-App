import 'package:job_finder/src/services/databse/db_provider.dart';

class QualificationsCM {
  int? id;
  String? uniname;
  String? course;
  String? fromyear;
  String? toyear;
  String? email;
  QualificationsCM(
      {this.id,
      this.uniname,
      this.course,
      this.fromyear,
      this.toyear,
      this.email});
  QualificationsCM.fromMap(Map<String, dynamic> item)
      : uniname = item[DatabaseProvider.COLUMN_UNINAME],
        course = item[DatabaseProvider.COLUMN_COURSE],
        fromyear = item[DatabaseProvider.COLUMN_FROMYEAR],
        toyear = item[DatabaseProvider.COLUMN_TOYEAR],
        email = item[DatabaseProvider.COLUMN_EMAIL],
        id = item[DatabaseProvider.COLUMN_ID];
  Map<String, dynamic> toMap() {
    return {
      DatabaseProvider.COLUMN_UNINAME: uniname,
      DatabaseProvider.COLUMN_COURSE: course,
      DatabaseProvider.COLUMN_FROMYEAR: fromyear,
      DatabaseProvider.COLUMN_TOYEAR: toyear,
      DatabaseProvider.COLUMN_EMAIL: email,
      DatabaseProvider.COLUMN_ID: id,
    };
  }

  @override
  String toString() {
    // ignore: todo
    // TODO: implement toString
    return ('uni name : $uniname , course : $course , from year : $fromyear , toYear : $toyear  , email : $email , id = $id ');
  }
}
