// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class CookieManager {
  CookieManager._();
  static CookieManager? _manager;
  static init() {
    if (_manager == null) _manager = CookieManager._();
    return _manager;
  }

  void addToCookie(String key, String value) {
    // 2592000 sec = 30 days.
    document.cookie =
        "$key=${value.replaceAll("\n", "~")}; max-age=2592000; path=/;";
  }

  void removeCookie(String key) {
    String _key = getCookie(key);

    if (_key.isNotEmpty)
      document.cookie =
          "$key=delete;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/;";
  }

  String getCookie(String key) {
    List<String> listValues = getAllCookie();

    String matchVal = "";
    for (int i = 0; i < listValues.length; i++) {
      List<String> map = listValues[i].split("=");
      String _key = map[0].trim();
      map.removeAt(0);
      String _val = map.join("=").trim();
      if (key.trim() == _key) {
        matchVal = _val;
        break;
      }
    }

    return matchVal.replaceAll("~", "\n"); //\n is not recognized by the cookies
  }

  List<String> getAllCookie() {
    String cookies = document.cookie!;
    return cookies.isNotEmpty ? cookies.split(";") : [];
  }
}
