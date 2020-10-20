import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = 'ISLOGGEDIN';
  static String sharedPreferenceUserNameKey = 'USERNAMEKEY';
  static String sharedPreferenceUserEmailKey = 'USEREMAILKEY';

/*Saving data to sharedPreference*/
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(
        sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameInSharedPreference(String userName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailInSharedPreference(String userEmail) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        sharedPreferenceUserEmailKey, userEmail);
  }

/*Getting data from sharedPreference*/
  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return  sharedPreferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserNameInSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return  sharedPreferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailInSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return  sharedPreferences.getString(sharedPreferenceUserEmailKey);
  }
}
