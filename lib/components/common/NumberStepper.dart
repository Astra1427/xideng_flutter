import 'dart:async';

import 'package:flutter/material.dart';

enum NumberStepperChangedType { subtract, increased }

class NumberStepper extends StatefulWidget {
  const NumberStepper(
      {Key? key,
      required this.onValueChanged,
      required this.content,
      required this.value,
      required this.stepNumber,
      required this.min,
      required this.max})
      : super(key: key);
  final void Function(double value, NumberStepperChangedType type)
      onValueChanged;
  final String content;
  final double value;
  final double stepNumber;
  final double min;
  final double max;

  @override
  State<NumberStepper> createState() => _NumberStepperState();
}

class _NumberStepperState extends State<NumberStepper> {
  late double value;
  Timer? longPressTimerFunction;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(

            onTap: () {
              if (value - widget.stepNumber <= widget.min) {
                value = widget.min;
              } else {
                value -= widget.stepNumber;
              }
              widget.onValueChanged
                  .call(value, NumberStepperChangedType.subtract);
            },
            onLongPressStart: (details) {
              longPressTimerFunction?.cancel();
              longPressTimerFunction = Timer.periodic(const Duration(milliseconds: 100), (timer) {
                if (value - widget.stepNumber <= widget.min) {
                  value = widget.min;
                } else {
                  value -= widget.stepNumber;
                }
                widget.onValueChanged
                    .call(value, NumberStepperChangedType.subtract);
              });
            },
            onLongPressEnd: (details) {
              longPressTimerFunction?.cancel();
            },
            onLongPressCancel: (){
              longPressTimerFunction?.cancel();
            },
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.arrow_circle_left,
                size: 30,
              ),
            )),
        Text(widget.content),
        GestureDetector(
            onTap: () {
              if (value + widget.stepNumber >= widget.max) {
                value = widget.max;
              } else {
                value += widget.stepNumber;
              }
              widget.onValueChanged
                  .call(value, NumberStepperChangedType.increased);
            },
            onLongPressStart: (details){
              longPressTimerFunction?.cancel();
              longPressTimerFunction = Timer.periodic(const Duration(milliseconds: 100), (timer) {
                if (value + widget.stepNumber >= widget.max) {
                  value = widget.max;
                } else {
                  value += widget.stepNumber;
                }
                widget.onValueChanged
                    .call(value, NumberStepperChangedType.increased);
              });
            },
            onLongPressEnd: (details){
              longPressTimerFunction?.cancel();
            },
            onLongPressCancel: (){
              longPressTimerFunction?.cancel();
            },
            child: const  Padding(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.arrow_circle_right,
                size: 30,
              ),
            )),
      ],
    );
  }
}
