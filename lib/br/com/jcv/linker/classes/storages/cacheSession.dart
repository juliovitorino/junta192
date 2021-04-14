
import 'dart:convert';

class CacheSession {
  static final CacheSession _singleton = new CacheSession._internal();

  String _jsonsession;

  factory CacheSession() {
    return _singleton;
  }

  CacheSession._internal() {
    this._jsonsession = 'no session';
  }

  void setSession(String _jsonsession){
    this._jsonsession = _jsonsession;
  }

  Map getSession(){
    return json.decode(this._jsonsession);
  }
}