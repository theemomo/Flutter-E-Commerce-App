class UserData {
  final String id;
  final String email;
  final String username;
  final String createdAt;

  UserData({required this.id, required this.email, required this.username, required this.createdAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'email': email, 'name': username, 'createdAt': createdAt};
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['name'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}
