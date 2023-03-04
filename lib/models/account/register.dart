class RegisterRequestBody {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String registerCode;

  RegisterRequestBody(
      {required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.registerCode});

  Map<String ,dynamic> toJson() => {
    'name':name,
    'email':email,
    'password':password,
    'confirmPassword':confirmPassword,
    'registerCode':registerCode,
  };
}
