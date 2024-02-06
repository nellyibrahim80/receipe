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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 320,
          height: 40,
          child: TextFormField(
            controller: searchCtrl,
            decoration: InputDecoration(
              fillColor: Color(ConstColors.bgInput),
              filled: true,
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Color(ConstColors.textInput),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(ConstColors.bgInput))),

              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color(ConstColors.bgInput)),
                  borderRadius: BorderRadius.circular(20)),
              //UnderlineInputBorder(borderSide: BorderSide(color: Color(ConstColors.bgInput))),
              hintStyle: const TextStyle(
                color: Color(ConstColors.textInput),
                fontWeight: FontWeight.normal,
              ),
            ),
            style: const TextStyle(
                color: Color(ConstColors.textInput)),
          ),
        ),
        Container(
          height: 40,
          color: const Color(ConstColors.bgInput),
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
    );
  }
}
