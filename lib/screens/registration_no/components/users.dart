import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final int points;
  final String id;

  User({
    this.id,
    this.name,
    this.points,
  });
}

List<User> users = [
  // User(name: 'Shubham', points: 2989),
  // User(name: 'Jyotsana', points: 4564),
  // User(name: 'Manisha', points: 3463),
  // User(name: 'Sujit', points: 4453),
  // User(name: 'smruti', points: 4531),
];

List<User> usersByPoints = [];

Future<void> getScoreBoardList() async {
  users.clear();
  usersByPoints.clear();
  var url = 'https://oecgame-4c5b7.firebaseio.com/scoreList.json';

  try {
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((key, value) {
      users.add(User(
          id: key,
          name: extractedData[key]['name'],
          points: extractedData[key]['points']));
    });
    usersByPoints = users.where((element) => element.points > 0).toList();
  } catch (error) {
    print(error.toString());
  }
}
