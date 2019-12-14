import 'package:billstore/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

final IS_LOGGED_IN = 'is_logged_in';
final USER_ID = 'user_id';
final NAME = 'name';
final USERNAME = 'username';
final USER_ADDRESS = 'user_address';
final USER_EMAIL = 'user_email';

saveUserDetails(User user) async
{
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  _sharedPreferences.setInt(USER_ID, user.id);
  _sharedPreferences.setBool(IS_LOGGED_IN, true);
  _sharedPreferences.setString(NAME, user.name);
  _sharedPreferences.setString(USERNAME, user.username);
  _sharedPreferences.setString(USER_ADDRESS, user.address);
  _sharedPreferences.setString(USER_EMAIL, user.email);
}

Future<bool> isLoggedIn() async
{
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  
  return _sharedPreferences.getBool(IS_LOGGED_IN);
}

Future<String> getUserId() async{
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  return _sharedPreferences.getInt(USER_ID).toString();
}