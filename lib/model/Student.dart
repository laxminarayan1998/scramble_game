import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Student {
  final String imageUrl;
  final String name;

  Student({
    this.imageUrl,
    this.name,
  });
}

List<Student> students = [];

// List<Student> students = [
//   Student(
//     name: "Shilpa",
//     imageUrl:
//         "https://scontent.fbbi3-1.fna.fbcdn.net/v/t31.0-8/10286854_1657229254532696_3985711638625066190_o.jpg?_nc_cat=100&_nc_sid=174925&_nc_ohc=dNO4eCaiYLcAX8wyl86&_nc_ht=scontent.fbbi3-1.fna&oh=68b93764f4368d1f362f802a49857e15&oe=5FAAA2EF",
//   ),
//   Student(
//     name: "Manisha",
//     imageUrl:
//         "https://scontent.fbbi3-1.fna.fbcdn.net/v/t1.0-9/36508114_655871551419122_7076708542924718080_n.jpg?_nc_cat=109&_nc_sid=174925&_nc_ohc=NouT_Dy0iAUAX96Y6-3&_nc_ht=scontent.fbbi3-1.fna&oh=f5ab147ac2ce880ff9fb044019d2be54&oe=5FA78C66",
//   ),
//   Student(
//     name: "Ipshita",
//     imageUrl:
//         "https://scontent.fbbi3-1.fna.fbcdn.net/v/t1.0-9/56168063_462387741167343_8247733901619888128_n.jpg?_nc_cat=103&_nc_sid=174925&_nc_ohc=zOdTzYJM5vsAX_opmr1&_nc_ht=scontent.fbbi3-1.fna&oh=47ce899ed743e74e3c82ab1ec8587d61&oe=5FAA5370",
//   ),
//   Student(
//     name: "Shreya",
//     imageUrl:
//         "https://scontent.fbbi3-1.fna.fbcdn.net/v/t1.0-9/15894891_1805246763053249_2414780267761957897_n.jpg?_nc_cat=101&_nc_sid=174925&_nc_ohc=DMBuopMkF30AX8cCmub&_nc_ht=scontent.fbbi3-1.fna&oh=e772ae8d51d27a2a4e3596cb4dfbd9ce&oe=5FA800EC",
//   ),
//   Student(
//     name: "Nahid",
//     imageUrl:
//         "https://scontent.fbbi3-1.fna.fbcdn.net/v/t1.0-9/52823349_2291995524395114_1713270941229776896_n.jpg?_nc_cat=102&_nc_sid=174925&_nc_ohc=9pab6OcvJBgAX8dq9v9&_nc_ht=scontent.fbbi3-1.fna&oh=f6c06284dacdc7f2a1bc21ec4ccc5b02&oe=5FABC09C",
//   )
// ];

Future<void> suggestions() async {
  var url =
      'https://raw.githubusercontent.com/laxminarayan1998/oec2017-2021_api/master/oec.json';

  try {
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    final _random = new Random();

    for (int i = 0; i <= 5; i++) {
      int keysIndex = _random.nextInt(extractedData.keys.length);

      List extractDataValues =
          extractedData.values.elementAt(keysIndex).toList();
          print(extractedData.length);

      int valuesIndex = _random.nextInt(extractDataValues.length);

      students.add(
        Student(
            name: extractDataValues[valuesIndex]['name'],
            imageUrl: extractDataValues[valuesIndex]['imageUrl']),
      );
      extractedData.remove(extractedData.keys.elementAt(keysIndex));
      print(extractedData.length);
    }
  } catch (error) {
    print(error.toString());
  }
}
