class Family {
  const Family({required this.id, required this.name});

  final String id;
  final String name;

  factory Family.fromMap(Map<String, dynamic> map) {
    return Family(id: map['id'] as String, name: map['name'] as String);
  }
}
