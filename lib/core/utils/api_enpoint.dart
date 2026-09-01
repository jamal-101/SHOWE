class ApiEndPoint {
  // static const baseUrl = "http://10.10.26.164:5002/api/v1";
  static const baseUrl = "http://168.144.106.179:3005/api/v1";
  static const websiteUrl = "http://168.144.106.179:3009";
  // static const imageUrl = "http://10.10.26.164:5002/files";
  static const imageUrl = "http://168.144.106.179:3005/files";
  static const signUp = "$baseUrl/user";
  static const userLogin = "$baseUrl/auth/login";
  static const otpVerify = "$baseUrl/auth/verify-email";
  static const saveFaceVerification = "$baseUrl/auth/save-face-verification";
  static const forgetPassword = "$baseUrl/auth/forget-password";
  static const getVenues = "$baseUrl/vanue";
  static String toggleFavorite(String id) => "/event/interest/$id";
  static String getReaderDoc(String id) => "$websiteUrl/reader/$id";
  static const answerPoll = "/programmes/answer-poll";
  static const submitUserThought = "/programmes/user-thoughts";
  static String getProgramme(String id) => "/programmes/$id";
  static String pollAnswers(String pollId) => "/programmes/polls/$pollId/answers";
}
