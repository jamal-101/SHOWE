class ApiEndPoint {
  static const baseUrl = "http://10.10.26.164:5002/api/v1";
  static const imageUrl = "http://10.10.26.164:5002/files";
  static const signUp = "$baseUrl/user";
  static const userLogin = "$baseUrl/auth/login";
  static const otpVerify = "$baseUrl/auth/verify-email";
  static const saveFaceVerification = "$baseUrl/auth/save-face-verification";
  static const forgetPassword = "$baseUrl/auth/forget-password";
  static const getVenues = "$baseUrl/vanue";
  static String toggleFavorite(String id) => "/event/interest/$id";

}
