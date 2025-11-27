class UserModel {
  final int id;
  final String username;
  final String email;
  final String role; // 'admin' atau 'pengguna'

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  // Factory method untuk membuat objek dari JSON (respons login)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.parse(json['id'].toString()), // Pastikan di-parse ke int
      username: json['username'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }
}
