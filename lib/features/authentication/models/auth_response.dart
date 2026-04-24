class AuthResponse {
  const AuthResponse({required this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      AuthResponse(token: json['token'] as String);

  final String token;
}
