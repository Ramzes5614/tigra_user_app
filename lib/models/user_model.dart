class UserModel {
  String name;
  String surname;
  String middlename;
  String userPhoneNumber;
  String password;
  int visits;

  UserModel(this.surname, this.name, this.middlename, this.userPhoneNumber,
      this.password)
      : visits = 0;

  UserModel.fromLocal(
      this.name, this.surname, this.userPhoneNumber, this.visits);

  UserModel.fromJson(var data) {
    name = data["first_name"];
    surname = data["last_name"];
    userPhoneNumber = data["phone_number"];
    visits = data["visit_counter"];
  }
  UserModel.example() {
    name = "Иван";
    surname = "Иванов";
    userPhoneNumber = "+7(933)333-44-55";
    visits = 4;
  }
}
