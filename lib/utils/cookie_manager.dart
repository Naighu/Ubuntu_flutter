// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class CookieManager {
  CookieManager._();
  static CookieManager _manager;
  static init() {
    if (_manager == null) _manager = CookieManager._();
    return _manager;
  }

  void addToCookie(String key, String value) {
    // 2592000 sec = 30 days.
    document.cookie = "$key=$value; max-age=2592000; path=/;";
  }

  String getCookie(String key) {
    List<String> listValues = getAllCookie();
    String matchVal = "";
    for (int i = 0; i < listValues.length; i++) {
      List<String> map = listValues[i].split("=");
      String _key = map[0].trim();
      String _val = map[1].trim();
      if (key == _key) {
        matchVal = _val;
        break;
      }
    }

    return matchVal;
  }

  List<String> getAllCookie() {
    String cookies = document.cookie;
    print(cookies);
    return cookies.isNotEmpty ? cookies.split(";") : [];
  }
}