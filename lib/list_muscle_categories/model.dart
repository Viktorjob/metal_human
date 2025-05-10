class Task {
  final String name;
  final String image;
  Task({required this.name,required this.image});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
