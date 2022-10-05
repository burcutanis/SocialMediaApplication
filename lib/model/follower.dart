class Follower {
  String name;
  String image;
  String you;

  Follower({
    required this.name,
    required this.image,
    required this.you
  });

  void addName(String title) {
    this.name = title;
  }
  void addImage(String text) {
    this.image = text;
  }
}