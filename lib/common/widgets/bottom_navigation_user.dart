import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class BottomNavigationUser extends StatelessWidget {
  final int selectedIndex;
  const BottomNavigationUser({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: GNav(
        rippleColor: Colors.grey[300]!,
        hoverColor: Colors.grey[100]!,
        gap: 8,
        activeColor: Colors.white,
        iconSize: 24,
        padding: const EdgeInsets.all(12),
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: AppColors.blueSecondary,
        color: AppColors.blueSecondary,
        onTabChange: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/transfer');
              break;
            case 2:
              context.go('/history');
              break;
            case 3:
              context.go('/settings');
              break;
          }
        },
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.send, text: 'Transfer'),
          GButton(icon: Icons.history, text: 'History'),
          GButton(icon: Icons.settings, text: 'Settings'),
        ],
        selectedIndex: selectedIndex,
      ),
    );
  }
}
