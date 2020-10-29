import 'package:flutter/material.dart';

import '../../../size_config.dart';

class ScoreBoardCard extends StatelessWidget {
  const ScoreBoardCard({
    Key key,
    @required this.index,
    @required this.name,
    @required this.score,
  }) : super(key: key);

  final int index;
  final String name;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(32)),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(index.toString()),
            ],
          ),
          title: Text(name),
          subtitle: Text('$score points'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              index == 1
                  ? Text(
                      '🥇',
                      style: TextStyle(fontSize: 22),
                    )
                  : index == 2
                      ? Text(
                          '🥈',
                          style: TextStyle(fontSize: 22),
                        )
                      : index == 3
                          ? Text(
                              '🥉',
                              style: TextStyle(fontSize: 22),
                            )
                          : Text(
                              '⭐️',
                              style: TextStyle(fontSize: 18),
                            )
            ],
          ),
        ),
      ),
    );
  }
}
