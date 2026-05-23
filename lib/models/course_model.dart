class Course {
  final int? id;
  final int? userId;
  final String title;
  final String body;

  Course({this.id, this.userId, required this.title, required this.body});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'title': title,
      'body': body,
    };
    if (userId != null) map['userId'] = userId;
    if (id != null) map['id'] = id;
    return map;
  }
}
