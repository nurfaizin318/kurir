class ApiPaths {
  // static const String baseUrl = 'http://www.google.com:81/';
  static const String baseUrl = "http://103.41.207.220:8082/api";

  static const String login = '/v1/auth/login';
  static const String profile = '/v1/auth/my-profile';
  static const String logout = '/v1/auth/logout';
  static const String refreshToken = '/v1/auth/refresh';
  static const String resetPassword = '/v1/auth/reset-password';
  static const String verifyPassword = '/v1/auth/verify-password';
  static const String register = '/v1/auth/register';
  static const String news = '/v1/app-setting/news';
  static const String balance = '/v1/pelanggan/wallet/balance';
  static const String listOrder = '/v1/driver/order/list';
}
