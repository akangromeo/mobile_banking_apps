import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_banking_apps/features/settings/presentation/bloc/profile_cubit.dart';
import 'package:mobile_banking_apps/features/settings/presentation/bloc/profile_state.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/features/settings/presentation/screens/setting_detail_screen.dart';
import 'package:mobile_banking_apps/features/settings/presentation/widgets/setting_group.dart';
import 'package:mobile_banking_apps/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_banking_apps/common/widgets/bottom_navigation_user.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

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
              onPressed: () => context.pop(),
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

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String username = 'Loading...';
        String email = 'Loading...';
        String firstName = '';
        String lastName = '';
        String birthdate = '';
        String fullname = '';

        if (state.status == ProfileStatus.success && state.profile != null) {
          username = state.profile!.username;
          email = state.profile!.email;
          firstName = state.profile!.firstName;
          lastName = state.profile!.lastName;
          birthdate = state.profile!.birthdate;
          fullname = '$firstName $lastName';
        }

        String avatarInitials = username.length >= 2
            ? username.substring(0, 2).toUpperCase()
            : username.toUpperCase();

        return Scaffold(
          backgroundColor: sectionBackgroundColor,
          appBar: AppBar(
            title: const Text(
              'Settings',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // ===== Profile Card with Avatar =====
              Container(
                margin: const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.blue.shade300,
                      child: Text(
                        avatarInitials,
                        style: appTheme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      username.isNotEmpty ? username : fullname,
                      style: appTheme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: appTheme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.blueGrey.shade700),
                    ),
                    const Divider(height: 24, thickness: 1),
                    // Profile fields
                    _buildProfileRow('Username', username),
                    _buildProfileRow('Name', fullname),
                    _buildProfileRow('Birthdate', birthdate),
                  ],
                ),
              ),

              // ===== Account Section =====
              SettingsGroup(
                title: 'Account',
                items: [
                  SettingsItem(
                    icon: Icons.person_outline,
                    title: 'Username',
                    onTap: () => _navigateToDetail(
                      context,
                      'Username',
                      username,
                      'Ubah username Anda sesuai keinginan.',
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
                      email,
                      'Ubah email Anda. Email akan digunakan untuk login dan notifikasi.',
                      false,
                      false,
                    ),
                    showDivider: false,
                  ),
                ],
              ),

              // ===== Cards Section =====
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

              // ===== Security Section =====
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

              // ===== Logout =====
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
          bottomNavigationBar: const BottomNavigationUser(selectedIndex: 3),
        );
      },
    );
  }
}

Widget _buildProfileRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            '$label:',
            style: appTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value.isNotEmpty ? value : '-',
            style: appTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}
