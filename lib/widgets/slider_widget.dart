  import 'package:flutter/material.dart';
import 'package:receipe/utilities/abstract_colors.dart';

class SliderWidget extends StatefulWidget {
   late String title;
  late String mapKey;
  late double min;
  late double max;
  late int divisions;
   var varName;
    late Function(double) onChangedCallback;
    SliderWidget({super.key,required this.title, required this.mapKey, required this.min, required this.max,
      required this.divisions, this.varName, required this.onChangedCallback});


  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
      Map<String,dynamic> selectedUserValue = {};
    return Column(
       children: [
         Padding(
                 padding: EdgeInsets.only(top:30.0),
                 child: Row(
                           children: [
                  Text(
                   widget.title,
                    style: ConstColors.headerTxtStyle,
                  ),
                           ],
                         ),
               ), Slider(
            value: widget.varName,
         //
          min: widget.min,
         max:widget.max,
         divisions:widget.divisions ,
              thumbColor: const Color(ConstColors.titleColors),
            activeColor:  const Color(ConstColors.titleColors),
            inactiveColor: const Color(ConstColors.lightGreyBg),
            label: widget.varName.round().toString(),
            onChanged: (double value) {
               widget.onChangedCallback(value);
              // varName = value.round().toDouble();
                  selectedUserValue[widget.mapKey] = value.round();
                 print(selectedUserValue);
              setState(() {
                
              });
            },
          ),
          Text(
        '${widget.varName.round()}',
        style: TextStyle(fontSize: 16),
      ),
       ],
     );
  }
}