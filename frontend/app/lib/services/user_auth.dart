import 'package:shared_preferences/shared_preferences.dart';

class UserAuth {
  static const String _userIdKey = 'user_id';
  static const String _authTokenKey = 'auth_token';
  static const String _userEmailKey = 'user_email';
  static const String _isLoggedInKey = 'is_logged_in';

  // Get current user ID
  static Future<String?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // Get auth token
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  // Get user email
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Save user session
  static Future<void> saveUserSession({
    required String userId,
    required String authToken,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_authTokenKey, authToken);
    await prefs.setString(_userEmailKey, email);
    await prefs.setBool(_isLoggedInKey, true);
  }

  // Clear user session (logout)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_authTokenKey);
    await prefs.remove(_userEmailKey);
    await prefs.setBool(_isLoggedInKey, false);
  }
}