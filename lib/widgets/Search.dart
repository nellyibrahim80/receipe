import 'package:flutter/material.dart';

import '../utilities/abstract_colors.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder textBoxBorder= OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Color(ConstColors.bgInput) ));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 338,
            height: 40,
            child: TextFormField(
              controller: searchCtrl,
              decoration: InputDecoration(
                fillColor: Color(ConstColors.bgInput),
                filled: true,
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Color(ConstColors.textInput),
                enabledBorder: textBoxBorder,
      
                border:textBoxBorder,
                //UnderlineInputBorder(borderSide: BorderSide(color: Color(ConstColors.bgInput))),
                hintStyle: const TextStyle(
                  color: Color(ConstColors.textInput),
                  fontWeight: FontWeight.normal,
                ),
              ),
              style: const TextStyle(color: Color(ConstColors.textInput)),
            ),
          ),
          Container(
            decoration:  BoxDecoration(borderRadius: BorderRadius.circular(6),color: const Color(ConstColors.bgInput)),
            height: 35,
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  child: Image.asset(
                "assets/Icons/filter.png",
                height: 35,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
