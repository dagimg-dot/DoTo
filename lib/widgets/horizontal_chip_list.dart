import 'package:flutter/material.dart';

import '../utils/constants.dart';

class HorizontalChipList extends StatefulWidget {
  final List<String> chips;
  final ValueChanged<int> onTap;

  const HorizontalChipList({
    Key? key,
    required this.chips,
    required this.onTap,
  }) : super(key: key);

  @override
  HorizontalChipListState createState() => HorizontalChipListState();
}

class HorizontalChipListState extends State<HorizontalChipList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.chips.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
            widget.onTap(_selectedIndex);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            height: 30,
            decoration: BoxDecoration(
              color: _selectedIndex == index ? secondaryColor : Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                      color: secondaryColor,
                      width: 2.0,
                    )
            ),
            child: Text(
              widget.chips[index],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _selectedIndex == index ? Colors.white : secondaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
