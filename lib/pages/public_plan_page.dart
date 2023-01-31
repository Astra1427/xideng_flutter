import 'package:flutter/material.dart';

class PublicPlanPage extends StatefulWidget {
  const PublicPlanPage({Key? key}) : super(key: key);

  @override
  State<PublicPlanPage> createState() => _PublicPlanPageState();
}

class _PublicPlanPageState extends State<PublicPlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('公开的计划'),
      ),
    );
  }
}
