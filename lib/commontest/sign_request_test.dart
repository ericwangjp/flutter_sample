import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/sign_utils.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter",
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
  var result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("签名测试"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () {
                  Map<String, String?> signMap = {
                    "ddd_h": "123456",
                    "appkey_h": "123456",
                    "appsecret_h": "123456",
                  };
                  Map<String, dynamic> jsonObject = {
                    "problems": [
                      {
                        "Diabetes": [
                          {
                            "medications": [
                              {
                                "medicationsClasses": [
                                  {
                                    "className": [
                                      {
                                        "associatedDrug": [
                                          {
                                            "name": "asprin",
                                            "dose": "",
                                            "strength": "500 mg"
                                          }
                                        ],
                                        "associatedDrug#2": [
                                          {
                                            "name": "somethingElse",
                                            "dose": "",
                                            "strength": "500 mg"
                                          }
                                        ]
                                      }
                                    ],
                                    "className2": [
                                      {
                                        "associatedDrug": [
                                          {
                                            "name": "asprin",
                                            "dose": "",
                                            "strength": "500 mg"
                                          }
                                        ],
                                        "associatedDrug#2": [
                                          {
                                            "name": "somethingElse",
                                            "dose": "",
                                            "strength": "500 mg"
                                          }
                                        ]
                                      }
                                    ]
                                  }
                                ]
                              }
                            ],
                            "labs": [
                              {"missing_field": "missing_value"}
                            ]
                          }
                        ],
                        "Asthma": [
                          {"name": "bk", "dose": "ddd", "strength": "500 mg"},
                          {"name": "aaa", "dose": "ggg", "strength": "100 mg"}
                        ]
                      }
                    ]
                  };
                  Map<String, dynamic> sortedJsonObject =
                      SignUtils.sortJsonObject(jsonObject);
                  debugPrint("第一步排序结果：$sortedJsonObject");
                  signMap["_boy_"] = jsonEncode(sortedJsonObject);
                  debugPrint("签名组装结果：$signMap");
                  var signResult = SignUtils.signRequest(signMap);
                  debugPrint("签名结果：$signResult");
                  setState(() {
                    result = signResult ?? "";
                  });
                },
                child: const Text("签名")),
            Container(
                color: Colors.blueGrey,
                child: const Text("签名结果：",
                    style: TextStyle(color: Colors.white, fontSize: 18))),
            Text(
              result,
              style: const TextStyle(color: Colors.deepOrange, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
