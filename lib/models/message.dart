class Message {
  final String id;
  final String content;
  final String category;
  bool isChecked;

  Message({
    required this.id,
    required this.content,
    required this.category,
    this.isChecked = false,
  });
}
