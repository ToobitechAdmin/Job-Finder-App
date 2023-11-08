import 'package:job_finder/src/services/databse/db_provider.dart';

class ExperianceCM {
  int? id;
  String? jobtitle;
  String? companyname;
  String? fromyear;
  String? toyear;
  String? email;
  ExperianceCM(
      {this.id,
      this.jobtitle,
      this.companyname,
      this.fromyear,
      this.toyear,
      this.email});
  ExperianceCM.fromMap(Map<String, dynamic> item)
      : jobtitle = item[DatabaseProvider.COLUMN_JOBTITLE],
        companyname = item[DatabaseProvider.COLUMN_COMPANYNAME],
        fromyear = item[DatabaseProvider.COLUMN_FROMYEAR],
        toyear = item[DatabaseProvider.COLUMN_TOYEAR],
        email = item[DatabaseProvider.COLUMN_EMAIL],
        id = item[DatabaseProvider.COLUMN_ID];
  Map<String, dynamic> toMap() {
    return {
      DatabaseProvider.COLUMN_JOBTITLE: jobtitle,
      DatabaseProvider.COLUMN_COMPANYNAME: companyname,
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
    return ('id = $id   , Jobtitle = $jobtitle  , companyname = $companyname   , fromyear = $fromyear  , toyear = $toyear ,  Email = $email');
  }
}
