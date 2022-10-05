class Post {
  String text;
  String date;
  String image;
  String title;
  int likes;
  int comments;

  Post({
    required this.text,
    required this.date,
    required this.image,
    required this.title,
    required this.likes,
    required this.comments,
  });

  void addTitle(String title) {
      this.title = title;
  }
  void addText(String text) {
    this.text = text;
  }
}
