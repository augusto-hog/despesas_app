import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomBottomAppBar extends StatefulWidget {
  final PageController controller;
  final Color? selectedItemColor;
  final List<CustomBottomAppBarItem> children;
  const CustomBottomAppBar({
    super.key,
    this.selectedItemColor,
    required this.children,
    required this.controller,
  }) : assert(children.length == 5, 'children.length must be 5');

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.controller.page?.toInt() ?? 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.children.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == selectedIndex;

            return Expanded(
              key: item.key,
              child: InkWell(
                onTap: () {
                  _onItemTapped(index);
                  item.onPressed?.call();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Icon(
                    isSelected ? item.primaryIcon : item.secondaryIcon,
                    color: isSelected ? widget.selectedItemColor : AppColors.lightGrey,
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class CustomBottomAppBarItem {
  final Key? key;
  final String? label;
  final IconData? primaryIcon;
  final IconData? secondaryIcon;
  final VoidCallback? onPressed;

  CustomBottomAppBarItem({
    this.key,
    this.label,
    this.primaryIcon,
    this.secondaryIcon,
    this.onPressed,
  });

  CustomBottomAppBarItem.empty({
    this.key,
    this.label,
    this.primaryIcon,
    this.secondaryIcon,
    this.onPressed,
  });
}
