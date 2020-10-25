import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  int id;
  String name;
  String email;

  User({
    this.id,
    this.name,
    this.email,
  });
}

// Future<void> suggestions() async {
//   var url =
//       'https://raw.githubusercontent.com/laxminarayan1998/oec2017-2021_api/master/oec.json';

//   try {
//     final response = await http.get(url);
//     final extractedData = json.decode(response.body) as Map<String, dynamic>;

//     final _random = new Random();

//     for (int i = 0; i <= 20; i++) {
//       int keysIndex = _random.nextInt(extractedData.keys.length);

//       List extractDataValues =
//           extractedData.values.elementAt(keysIndex).toList();

//       int valuesIndex = _random.nextInt(extractDataValues.length);

//       debugPrint(extractedData.keys.elementAt(keysIndex));
//       print(extractDataValues[valuesIndex]['name']);
//     }
//   } catch (error) {
//     print(error.toString());
//   }
// }
