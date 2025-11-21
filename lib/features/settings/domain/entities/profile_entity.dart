class ProfileEntity {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String birthdate;
  final bool isActive;
  final bool is2faEnabled;

  ProfileEntity({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.isActive,
    required this.is2faEnabled,
  });
}
