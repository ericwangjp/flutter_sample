import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';

class SignUtils {
  static String? signRequest(Map<String, String?> params) {
    // 第一步：检查参数是否已经排序
    var keys = params.keys.toList()..sort();

    // 第二步：把所有参数名和参数值串在一起
    var query = StringBuffer();
    for (var key in keys) {
      var value = params[key];
      if (key.isNotEmpty && (value?.isNotEmpty == true)) {
        query.write('$key$value');
      }
    }
    debugPrint('签名排序结果：$query');

    // 第三步：使用MD5/HMAC加密
    var bytes = encryptMD5(query.toString());

    // 第四步：把二进制转化为大写的十六进制(正确签名应该为32大写字符串，此方法需要时使用)
    return byteToHex(bytes);
  }

  static List<int> encryptMD5(String data) {
    return data.isEmpty ? [] : md5.convert(utf8.encode(data)).bytes;
  }

  static String byteToHex(List<int> bytes) {
    StringBuffer sign = StringBuffer();
    for (int i = 0; i < bytes.length; i++) {
      String hex = (bytes[i] & 0xFF).toRadixString(16);
      if (hex.length == 1) {
        sign.write("0");
      }
      sign.write(hex);
    }
    return sign.toString().toUpperCase();
  }

  static String sortJsonKeys(String jsonString) {
    try {
      var json = jsonDecode(jsonString);
      if (json is Map<String, dynamic>) {
        var sortedMap = sortJsonObject(json);
        return jsonEncode(sortedMap);
      } else if (json is List) {
        var sortedList = sortJsonArray(json);
        return jsonEncode(sortedList);
      } else {
        return jsonString;
      }
    } catch (e) {
      debugPrint(e.toString());
      return jsonString;
    }
  }

  static Map<String, dynamic> sortJsonObject(Map<String, dynamic> jsonObject) {
    Map<String, dynamic> sortedMap = {};
    for (var key in jsonObject.keys) {
      var value = jsonObject[key];
      if (value is Map<String, dynamic>) {
        value = sortJsonObject(value);
      } else if (value is List) {
        value = sortJsonArray(value);
      }
      sortedMap[key] = value;
    }
    return Map.fromEntries(
        sortedMap.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
  }

  static List<dynamic> sortJsonArray(List<dynamic> jsonArray) {
    List<dynamic> sortedJsonArray = [];
    for (var value in jsonArray) {
      if (value is Map<String, dynamic>) {
        value = sortJsonObject(value);
      } else if (value is List) {
        value = sortJsonArray(value);
      }
      sortedJsonArray.add(value);
    }
    return sortedJsonArray;
  }

}
