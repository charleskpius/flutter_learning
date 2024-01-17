import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'categories.dart';
import 'cart.dart';
import 'home.dart';
import 'login.dart';
import 'setting.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const BottomNavigation({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: GNav(
              gap: 8,
              activeColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              duration: const Duration(milliseconds: 800),
              tabBackgroundColor: Colors.transparent,
              tabs: [
                _buildNavItem(context, Icons.home, 'Home', 0),
                _buildNavItem(context, Icons.category, 'Categories', 1),
                _buildNavItem(context, Icons.shopping_cart, 'Cart', 2),
                _buildNavItem(context, Icons.settings, 'Settings', 3),
              ],
              selectedIndex: selectedIndex,
              onTabChange: onTabChange,
            ),
          ),
        ),
      ),
    );
  }

  GButton _buildNavItem(
      BuildContext context, IconData icon, String text, int index) {
    // Truncate text if it's longer than 4 letters
    String truncatedText =
        text.length > 4 ? text.substring(0, 4) + '...' : text;

    return GButton(
      icon: icon,
      text: truncatedText,
      textColor: selectedIndex == index
          ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
          : null,
      iconColor: selectedIndex == index
          ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
          : null,
      onPressed: () {
        Navigator.push(
          context,
          CustomPageRoute(
            page: index == 0
                ? const HomeScreen()
                : index == 1
                    ? CategoriesPage()
                    : index == 2
                        ? const CartPage()
                        : index == 3
                            ? SettingsPage()
                            : Container(),
          ),
        );
      },
    );
  }
}
