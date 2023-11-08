import 'package:job_finder/src/services/databse/db_provider.dart';

class ContactCM {
  int? id;
  String? address;
  String? city;
  String? state;
  String? postalcode;
  String? email;
  ContactCM(
      {this.id,
      this.address,
      this.city,
      this.state,
      this.postalcode,
      this.email});
  ContactCM.fromMap(Map<String, dynamic> item)
      : address = item[DatabaseProvider.COLUMN_ADDRESS],
        city = item[DatabaseProvider.COLUMN_CITY],
        state = item[DatabaseProvider.COLUMN_STATE],
        postalcode = item[DatabaseProvider.COLUMN_POSTALCODE],
        email = item[DatabaseProvider.COLUMN_EMAIL],
        id = item[DatabaseProvider.COLUMN_ID];
  Map<String, dynamic> toMap() {
    return {
      DatabaseProvider.COLUMN_ADDRESS: address,
      DatabaseProvider.COLUMN_CITY: city,
      DatabaseProvider.COLUMN_STATE: state,
      DatabaseProvider.COLUMN_POSTALCODE: postalcode,
      DatabaseProvider.COLUMN_EMAIL: email,
      DatabaseProvider.COLUMN_ID: id,
    };
  }

  @override
  String toString() {
    // ignore: todo
    // TODO: implement toString
    return ('id = $id   , address = $address  , city = $city   , state = $state  , PostalCode = $postalcode ,  Email = $email');
  }
}

class UserCM {
  int? id;
  String? name;
  String? email;
  String? password;
  UserCM({
    this.id,
    this.name,
    this.email,
    this.password,
  });
  UserCM.fromMap(Map<String, dynamic> item)
      : name = item[DatabaseProvider.COLUMN_NAME],
        email = item[DatabaseProvider.COLUMN_EMAIL],
        password = item[DatabaseProvider.COLUMN_PASSWORD],
        id = item[DatabaseProvider.COLUMN_ID];
  Map<String, dynamic> toMap() {
    return {
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_EMAIL: email,
      DatabaseProvider.COLUMN_PASSWORD: password,
      DatabaseProvider.COLUMN_ID: id,
    };
  }

  @override
  String toString() {
    // ignore: todo
    // TODO: implement toString
    return ('id = $id   , Name = $name  , Email = $email   , Password = $password  ');
  }
}
