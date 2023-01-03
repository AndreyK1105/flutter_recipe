import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../domain/entities/recipe.dart';

class StepCookWidget extends StatefulWidget {
  Cook cook;
  int stepNumb;
  StepCookWidget({required this.cook, required this.stepNumb, super.key});
bool _value=false;
  @override
  State<StepCookWidget> createState() => _StepCookWidgetState();
}

class _StepCookWidgetState extends State<StepCookWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    String step = widget.cook.step;
    String timeStep = widget.cook.timeStep;
    

    return Column(
      children: [
        Container(
            width: 398, height: 120, 
            decoration: BoxDecoration( color: Color(0xFFECECEC), borderRadius: BorderRadius.all(Radius.circular(10))),
             child: Row(
               children: [
                const SizedBox(  width: 24, ),
                Text( widget.stepNumb.toString(),
                style: TextStyle(color: Color(0xFFC2C2C2), fontSize: 40, fontWeight: FontWeight.w900),),
                const SizedBox(  width: 29, ),
                 Expanded(child:
                  Text(step,
                  style: TextStyle(color: Color(0xFF797676), fontSize: 14, fontWeight: FontWeight.w400),
                  )),
                 const SizedBox(  width: 22, ),
                  
                 Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [                  
                  Checkbox(value: widget._value, onChanged: (bool? newValue){setState(() {widget._value=newValue!; });}),
                  Text(timeStep,
                  style: TextStyle(color: Color(0xFF797676), fontSize: 13, fontWeight: FontWeight.w700),),
                 ],),
                    const SizedBox(  width: 22, ), 
               ],
             )),
            const SizedBox(  height: 14, ),
      ],
    );
  }
}
