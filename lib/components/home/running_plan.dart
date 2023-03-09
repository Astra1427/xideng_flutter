import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xideng_flutter/models/exercise_plan/exercise_plan_dto.dart';

class RunningPlan extends StatefulWidget {
  const RunningPlan({Key? key, this.planModel}) : super(key: key);

  final ExercisePlanDTO? planModel;
  @override
  State<RunningPlan> createState() => _RunningPlanState();
}

class _RunningPlanState extends State<RunningPlan> {
  @override
  Widget build(BuildContext context) {


    return Container(
      margin: const EdgeInsets.all(2),
      color: Theme
          .of(context)
          .backgroundColor,
      height: 200,
      child:buildContent(),

    );
  }

  Widget buildContent() {

    if (widget.planModel == null) {
      return Stack(
        children: [
          Image.asset("images/pexels_evgeny_tchebotarev_4101555.jpg",fit: BoxFit.fill,width: double.infinity,),
          // Text(widget.planModel!.name),
        ],
      );
    } else {
      return const Text('暂无数据！', style: TextStyle(fontSize: 25),);
    }
  }
}
