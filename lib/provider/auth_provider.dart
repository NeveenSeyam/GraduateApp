import 'package:flutter/widgets.dart';
import 'package:hogo_app/screen/http_excaption.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  String? userEmail;
  types.User? user;
  String userId = '';

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userID {
    return _userId;
  }

  Future _authenticate(String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyD6VVlXZew33CtbJMBkzKrh1LhGOBeyoEY');
    try {
      final responsep = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = jsonDecode(responsep.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message'] as String);
      }

      userEmail = email;

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'email': email,
        'expirtDate': _expiryDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);

      _autoLogout();
      notifyListeners();

      print(_token);
//localId
      print("esponseData['localId'] ${responseData['localId']}");
      return responseData['localId'];
      // print(jsonDecode(responsep.body));
    } catch (e) {
      rethrow;
    }
  }

  Future singup(String? email, String? password) async {
    return await _authenticate(email!, password!, 'signUp');
  }

  Future singin(String? email, String? password) async {
    return await _authenticate(email!, password!, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      print("false data");
      return false;
    }
    print("ture data");
    final extractedUserData = json.decode(prefs.getString('userData') as String)
        as Map<String, dynamic>;
    print("_token ${extractedUserData['token']}");

    final expiryDate =
        DateTime.parse(extractedUserData['expirtDate'] as String);

    if (expiryDate.isBefore(DateTime.now())) {
      print('timer false');

      return false;
    }
    _token = extractedUserData['token'] as String?;
    userEmail = extractedUserData['email'] as String?;
    print("_token $_token");
    print("_token ${extractedUserData['token']}");

    _userId = extractedUserData['userId'] as String?;
    userId = extractedUserData['userId'] as String;
    _expiryDate = expiryDate;
    print("userId $userId");
    notifyListeners();
    return true;
  }

  bool get isAuth {
    print('**********************');
    print('**********************');

    print(token);

    return token != null;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
