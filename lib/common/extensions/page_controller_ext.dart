import 'package:flutter/material.dart';

enum BottomAppBarItem { home, stats, carteira, perfil }

extension PageControllerExt on PageController {
  static int _selectedIndex = 0;

  int get selectedBottomAppBarItemIndex {
    final newIndex = page ?? 0;
    if (newIndex > 1) {
      return (newIndex + 1).toInt();
    }
    return _selectedIndex;
  }

  set setBottomAppBarItemIndex(int newIndex) {
    _selectedIndex = newIndex;
  }

  void navigateTo(BottomAppBarItem item) {
    switch (item) {
      case BottomAppBarItem.home:
        jumpToPage(BottomAppBarItem.home.index);
        break;
      case BottomAppBarItem.stats:
        jumpToPage(BottomAppBarItem.stats.index);
        break;
      case BottomAppBarItem.carteira:
        jumpToPage(BottomAppBarItem.carteira.index);
        break;
      case BottomAppBarItem.perfil:
        jumpToPage(BottomAppBarItem.perfil.index);
        break;
    }
  }
}
