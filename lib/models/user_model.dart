class UserModel {
  String name;
  String surname;
  String middlename = "";
  String userPhoneNumber;
  String password;
  int visits = 0;

  UserModel(this.surname, this.name, this.middlename, this.userPhoneNumber,
      this.password)
      : visits = 0;

  UserModel.fromLocal(var data) {
    name = data["first_name"];
    surname = data["last_name"];
    userPhoneNumber = data["phone_number"];
    visits = data["visit_counter"];
    password = data["password"];
    middlename = data["middle_name"];
  }

  UserModel.fromJson(var data) {
    name = data["first_name"];
    surname = data["last_name"];
    userPhoneNumber = data["phone_number"];
    visits = data["visit_counter"];
    //password = data["password"];
    middlename = data["middle_name"];
  }
  UserModel.example() {
    name = "Иван";
    surname = "Иванов";
    userPhoneNumber = "+7(933)333-44-55";
    visits = 4;
  }

  toMap() {
    return {
      "phone_number": this.userPhoneNumber,
      "first_name": this.name,
      "last_name": this.password,
      "middle_name": this.middlename,
      "password": this.password,
      "visit_counter": this.visits
    };
  }
}
