class UserModel {
  String name;
  String surname;
  String userPhoneNumber;
  int visits;

  UserModel(this.name, this.surname, this.userPhoneNumber, this.visits);

  UserModel.fromJson() {
    name = "Иван";
    surname = "Иванов";
    userPhoneNumber = "+7(933)333-44-55";
    visits = 4;
  }
  UserModel.example() {
    name = "Иван";
    surname = "Иванов";
    userPhoneNumber = "+7(933)333-44-55";
    visits = 4;
  }
}
