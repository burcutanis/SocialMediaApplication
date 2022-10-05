class Account_Info {
  String text;
  String username;
  String email;

  Account_Info({
    required this.text,
    required this.username,
    required this.email,
  });

  void addText(String text) {
    this.text = text;
  }

  void changeEmail(String email) {
    this.email = email;
  }

  void changeUsername(String username) {
    this.username = username;
  }
}