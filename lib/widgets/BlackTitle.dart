import 'package:flutter/material.dart';

class HeaderBlack extends StatelessWidget {
  final String HeaderBlackTitle;
  const HeaderBlack({required this.HeaderBlackTitle,super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
                HeaderBlackTitle,

              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                maxLines: 2,
                overflow: TextOverflow.ellipsis
            ),
          ),
        ),
      ],
    );
  }
}
