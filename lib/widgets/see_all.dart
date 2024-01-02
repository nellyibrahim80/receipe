import 'package:flutter/material.dart';
import 'package:receipe/utilities/abstract_colors.dart';

class SeeAllHeader extends StatelessWidget {
  final String HeaderTitle;
  const SeeAllHeader({required this.HeaderTitle,super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween ,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
                HeaderTitle,

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                maxLines: 2,
                overflow: TextOverflow.ellipsis
            ),
          ),
        ),
        Text(
            "See All",

            style: TextStyle(color: Color(ConstColors.titleColors),fontSize: 18,),
            maxLines: 2,
            overflow: TextOverflow.ellipsis
        )
      ],
    );
  }
}
