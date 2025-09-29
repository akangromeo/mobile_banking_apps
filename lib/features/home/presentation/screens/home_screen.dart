import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/features/home/presentation/widgets/button_card.dart';
import 'package:mobile_banking_apps/features/home/presentation/widgets/transaction_history_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import SmoothPageIndicator
import 'package:mobile_banking_apps/common/widgets/bottom_navigation_user.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/home/presentation/widgets/bank_info_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data untuk ditampilkan pada BankInfoCard
  final List<Map<String, String>> _bankData = [
    {
      'bankName': 'Bank ABC',
      'accountNumber': '170233341431414141',
      'balance': '1.000.000',
    },
    {
      'bankName': 'Bank XYZ',
      'accountNumber': '170233341431414142',
      'balance': '2.500.000',
    },
    {
      'bankName': 'Bank PQR',
      'accountNumber': '170233341431414143',
      'balance': '500.000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.bluePrimary,
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDesignConstants.kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/icons/logo-name.png',
                      height: 50,
                    ),
                    Row(
                      children: const [
                        Icon(Icons.settings, color: Colors.white),
                        SizedBox(width: 16),
                        Icon(Icons.logout, color: Colors.white),
                      ],
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const SizedBox(width: 8),
                  Text(
                    'Welcome, Romeo',
                    style: appTheme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ]),
                const SizedBox(height: 8),
                SizedBox(
                  height: 150,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: _bankData.length,
                    itemBuilder: (context, index) {
                      final data = _bankData[index];
                      return BankInfoCard(
                        bankName: data['bankName']!,
                        accountNumber: data['accountNumber']!,
                        balance: data['balance']!,
                      );
                    },
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Menambahkan SmoothPageIndicator di bawah PageView
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: _bankData.length, // Jumlah card yang ada
                          effect: const SlideEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 16,
                            activeDotColor: Colors.blue,
                            dotColor: Colors.white,
                          ),
                        ),
                      ),
                    ]),
                const SizedBox(height: 16),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonCard(
                          iconData: Icons.send, text: "Transfer", onTap: () {}),
                      ButtonCard(
                          iconData: Icons.wallet, text: "Top Up", onTap: () {}),
                    ]),
                const SizedBox(height: 16),
                const TransactionHistory(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationUser(selectedIndex: 0),
    );
  }
}
