class User {
  final int id;
  final String name;

  // Non-nullable constructor with required fields
  User({required this.id, required this.name});

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json['id'],  // id will be required
      name: json['name'],  // name will be required
    );
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name};
  }

  // Static method to create a default User
  static User defaultUser() {
    return User(id: 0, name: 'Default User'); // Provide default values for id and name
  }
}
