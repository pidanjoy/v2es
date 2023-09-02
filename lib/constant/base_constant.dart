library base_constant;

const double gravity = 9.8;
const int maxAttempts = 3;

class ApiEndpoints {
  static const baseUrl = "https://www.v2ex.com";

  static const loginKeyUrl = "$baseUrl/signin";
  static const captchaImageUrl = "$baseUrl/_captcha";
  static const loginUrl = "$baseUrl/signin";
  static const planesUrl = "$baseUrl/planes";

  static userReplyUrl(username) => "$baseUrl/member/$username";
  static userQuestionUrl(username) => "$baseUrl/member/$username/qna";
  static userTechUrl(username) => "$baseUrl/member/$username/tech";
  static userPlayUrl(username) => "$baseUrl/member/$username/play";
  static userDealUrl(username) => "$baseUrl/member/$username/deals";
  static userCityUrl(username) => "$baseUrl/member/$username/city";

  static const nodeAllUrl = "$baseUrl/api/nodes/list.json?fields=name,title,topics,aliases&sort_by=topics&reverse=1";
}
