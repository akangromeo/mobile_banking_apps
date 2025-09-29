import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/bottom_navigation_user.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/settings/presentation/screens/setting_detail_screen.dart';

import 'package:mobile_banking_apps/features/settings/presentation/widgets/setting_group.dart';
import 'package:mobile_banking_apps/features/settings/presentation/widgets/setting_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Log out',
            style: appTheme.textTheme.titleSmall,
          ),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: appTheme.textTheme.bodyMedium
                    ?.copyWith(color: AppColors.blueSecondary),
              ),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: Text('Log out',
                  style: appTheme.textTheme.bodyMedium
                      ?.copyWith(color: Colors.red.shade700)),
              onPressed: () {
                context.replace("/login");
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToDetail(BuildContext context, String title,
      String currentValue, String description, bool isPassword, bool isPin) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => SettingDetailScreen(
          title: title,
          currentValue: currentValue,
          description: description,
          isPassword: isPassword,
          isPin: isPin,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color logOutColor = Colors.red.shade700;
    final Color sectionBackgroundColor = Colors.grey.shade50;

    const currentUsername = 'andi_setiawan_01';
    const currentEmail = 'andi.setiawan@example.com';

    return Scaffold(
        backgroundColor: sectionBackgroundColor,
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SettingsGroup(
              title: 'Account',
              items: [
                SettingsItem(
                  icon: Icons.person_outline,
                  title: 'Username',
                  onTap: () => (
                    context,
                    'Username',
                    currentUsername,
                    'Kami akan memanggil Anda dengan nama yang dimasukkan.',
                    false,
                    false,
                  ),
                  showDivider: true,
                ),
                SettingsItem(
                  icon: Icons.alternate_email,
                  title: 'Email',
                  onTap: () => _navigateToDetail(
                    context,
                    'Email',
                    currentEmail,
                    'Gunakan alamat email ini untuk menerima notifikasi dan reset password.',
                    false,
                    false,
                  ),
                  showDivider: false,
                ),
              ],
            ),
            const SettingsGroup(
              title: 'Cards',
              items: [
                SettingsItem(
                  icon: Icons.credit_card_outlined,
                  title: 'Card Management',
                  onTap: null,
                  showDivider: false,
                ),
              ],
            ),
            SettingsGroup(
              title: 'Security',
              items: [
                SettingsItem(
                  icon: Icons.lock_outline,
                  title: 'PIN',
                  onTap: () => _navigateToDetail(
                    context,
                    'PIN',
                    '',
                    'Masukkan 6 digit PIN baru Anda. PIN akan digunakan untuk konfirmasi transaksi.',
                    false,
                    true,
                  ),
                  showDivider: true,
                ),
                SettingsItem(
                  icon: Icons.vpn_key_outlined,
                  title: 'Password',
                  onTap: () => _navigateToDetail(
                    context,
                    'Password',
                    '',
                    'Masukkan password baru minimal 8 karakter.',
                    true,
                    false,
                  ),
                  showDivider: false,
                ),
              ],
            ),
            Container(
              color: Colors.white,
              child: SettingsItem(
                icon: Icons.logout,
                title: 'Log out',
                iconColor: logOutColor,
                onTap: () {
                  _showLogoutConfirmation(context);
                },
                showDivider: false,
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigationUser(selectedIndex: 3));
  }
}
