import 'package:flutter/material.dart';

class RunningPlan extends StatelessWidget {
  const RunningPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(2),
      color: Theme.of(context).backgroundColor,
      height: 200,
      child: Text('text'),
    );
  }
}
