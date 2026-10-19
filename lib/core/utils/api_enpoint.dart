class ApiEndPoint {

//================= this is local  url ===============
//   static const baseUrl = "http://10.10.26.164:5003/api/v1";
//   static const websiteUrl = "http://168.144.106.179:3009";
//   static const imageUrl = "http://10.10.26.164:5003/files";

  //================= this is live url ===============

  static const baseUrl = "https://api.showe.biz/api/v1";
  static const websiteUrl = "https://showe.biz";
  static const imageUrl = "https://api.showe.biz/files";

  /// Resolves an image path from backend.
  /// If [path] is already an HTTP/HTTPS URL, returns it directly.
  /// Otherwise, prepends [imageUrl].
  static String getImageUrl(String? path) {
    if (path == null || path.trim().isEmpty) return '';
    final trimmed = path.trim();
    if (trimmed.startsWith('http://') ||
        trimmed.startsWith('https://') ||
        trimmed.startsWith('data:')) {
      return trimmed;
    }
    final base = imageUrl.endsWith('/')
        ? imageUrl.substring(0, imageUrl.length - 1)
        : imageUrl;
    final formattedPath = trimmed.startsWith('/') ? trimmed : '/$trimmed';
    return '$base$formattedPath';
  }

  // static const websiteUrl = "http://168.144.106.179:3009";
  // static const imageUrl = "http://10.10.26.164:5002/files";
  // static const imageUrl = "http://168.144.106.179:3005/files";


//========== firebase google sign in ============
  static const String socialLogin = "/auth/social-login";

//========== firebase google sign in ============

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
  static const disclaimer = "$baseUrl/disclaimer";
}
