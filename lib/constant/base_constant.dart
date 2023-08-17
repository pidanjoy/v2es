library base_constant;

const double gravity = 9.8;
const int maxAttempts = 3;

class ApiEndpoints {
  static const baseUrl = "https://www.v2ex.com";

  static const loginKeyUrl = "$baseUrl/signin";
  static const captchaImageUrl = "$baseUrl/_captcha";
  static const loginUrl = "$baseUrl/signin";
}
