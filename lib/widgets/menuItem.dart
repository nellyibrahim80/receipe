import 'package:flutter/material.dart';
import 'package:receipe/utilities/abstract_colors.dart';

import '../screens/ingredient.dart';

class MenuItem extends StatefulWidget {
  final Widget LinkScreen;
  final String menutitle;
  final IconData menuIcon;


  const MenuItem({super.key,required this.LinkScreen,required this.menutitle,required this.menuIcon});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {


    return SizedBox(
      width: 210,
      child: ListTile(
       horizontalTitleGap: 0,
        minLeadingWidth: 15,
       // minVerticalPadding: 20,
        contentPadding: EdgeInsets.all(8),
        title: TextButton(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.menutitle,
                style: TextStyle(color: Color(ConstColors.textSearchInput),fontWeight: FontWeight.normal),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => widget.LinkScreen));
          },
        ),
        leading: Icon(widget.menuIcon,color: Color(ConstColors.textSearchInput),),
      ),
    );
  }

}

