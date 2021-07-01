
import 'dart:convert';

class CacheSessionAppleSignIn {
  static final CacheSessionAppleSignIn _singleton = new CacheSessionAppleSignIn._internal();

  String _jsonsession;

  factory CacheSessionAppleSignIn() {
    return _singleton;
  }

  CacheSessionAppleSignIn._internal() {
    this._jsonsession = 'no session';
  }

  void setSession(String _jsonsession){
    this._jsonsession = _jsonsession;
  }

  Map getSession(){
    return json.decode(this._jsonsession);
  }
}