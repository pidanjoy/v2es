class LoginKey {
  String cookie;
  String username;
  String password;
  String captcha;
  String once;
  String next;

  LoginKey({
    required this.cookie,
    required this.username,
    required this.password,
    required this.captcha,
    required this.once,
    required this.next,
  });
}

class LoginParams {
  String usernameKey;
  String usernameValue;
  String passwordKey;
  String passwordValue;
  String captchaKey;
  String captchaValue;
  String once;
  String next;

  LoginParams(
    this.usernameKey,
    this.usernameValue,
    this.passwordKey,
    this.passwordValue,
    this.captchaKey,
    this.captchaValue,
    this.once,
    this.next,
  );
}
