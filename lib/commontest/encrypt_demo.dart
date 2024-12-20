import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "dart 加解密",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _plainText =
      'https://cloud-dev.cdn-qn.hzmantu.com/compress/2023/03/13/FrhFywwc8rg8B4AH8T8LlFkuBiYk.jpg';
  final String _encryptText = 'Vlm7AY5VxhiOc5QSZe5Szga2oN2+AMpMDyHU9tYktFw=';
  final String _encryptText2 =
      'MC042WMGwzy0EaDGOVy69v3ndrWZ9D3j7nTTvpvYaqR+tUb+LcceSnpPHlO7Zyo20AeNgjb9wCRvtQK53NCrTYzCvs9ceVl3nkIhnzNRcDWqy39RTC+HJX82zGu1i/+0';
  final _encryptKey = encrypt.Key.fromUtf8('FFC22E80F61AB7295C02493856B4C520');
  final iv = encrypt.IV.fromLength(16);

  late encrypt.Encrypter encrypter;
  String _result = '';
  String _result2 = '';

  @override
  void initState() {
    encrypter =
        encrypt.Encrypter(encrypt.AES(_encryptKey, mode: encrypt.AESMode.ecb));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("dart 加解密"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(hintText: '请输入加密内容'),
            ),
            Text(
              _result,
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _result = encrypter.encrypt(_plainText, iv: iv).base64;
                    debugPrint(
                        '是否相等：${'MC042WMGwzy0EaDGOVy69v3ndrWZ9D3j7nTTvpvYaqR+tUb+LcceSnpPHlO7Zyo20AeNgjb9wCRvtQK53NCrTYzCvs9ceVl3nkIhnzNRcDWqy39RTC+HJX82zGu1i/+0' == _result}');
                  });
                },
                child: const Text(
                  '加密',
                  style: TextStyle(fontSize: 20),
                )),
            const TextField(
              decoration: InputDecoration(hintText: '请输入解密内容'),
            ),
            Text(
              _result2,
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _result2 = encrypter.decrypt64(_encryptText2, iv: iv);
                    debugPrint(
                        '是否相等：${_result2 == 'https://cloud-dev.cdn-qn.hzmantu.com/compress/2023/03/13/FrhFywwc8rg8B4AH8T8LlFkuBiYk.jpg'}');
                  });
                },
                child: const Text(
                  '解密',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
