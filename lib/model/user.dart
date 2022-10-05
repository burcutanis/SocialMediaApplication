class MyUser {
  String email;
  String password;
  String username;

  MyUser({
    required this.email,
    required this.password,
    required this.username,
  });

  void addEmail(String email) {
    this.email = email;
  }
  void addPassword(String password) {
    this.password = password;
  }
  void addUser(String username) {
    this.username = username;
  }
  String getUser() {
    return username;
  }
  String getEmail() {
    return email;
  }
}