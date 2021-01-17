import 'dart:convert';

class LoginAndPass {
  String login;
  String password;
  LoginAndPass({
    this.login,
    this.password,
  });

  LoginAndPass copyWith({
    String login,
    String password,
  }) {
    return LoginAndPass(
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'password': password,
    };
  }

  factory LoginAndPass.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LoginAndPass(
      login: map['login'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginAndPass.fromJson(String source) =>
      LoginAndPass.fromMap(json.decode(source));

  @override
  String toString() => 'LiginAndPass(login: $login, password: $password)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoginAndPass && o.login == login && o.password == password;
  }

  @override
  int get hashCode => login.hashCode ^ password.hashCode;
}
