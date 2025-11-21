import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/core/di/injector.dart';
import 'package:mobile_banking_apps/core/services/auth_service.dart';
import 'package:mobile_banking_apps/features/home/presentation/cubit/home_cubit.dart';
import 'package:mobile_banking_apps/features/home/presentation/widgets/button_card.dart';
import 'package:mobile_banking_apps/features/home/presentation/widgets/transaction_history_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:mobile_banking_apps/common/widgets/bottom_navigation_user.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/home/presentation/widgets/bank_info_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            final cards = state.cards;
            final username = state.balance.username;
            final transactions = state.transactions.getRange(0, 4).toList();
            return SingleChildScrollView(
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
                    horizontal: AppDesignConstants.kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/icons/logo-name.png',
                            height: 50,
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    context.go('/settings');
                                  },
                                  child: const Icon(Icons.settings,
                                      color: Colors.white)),
                              const SizedBox(width: 16),
                              InkWell(
                                onTap: () {
                                  sl<AuthService>().logout();
                                  if (mounted) {
                                    context.go('/login');
                                  }
                                },
                                child: const Icon(Icons.logout,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 8),
                          Expanded(
                            child: Wrap(children: [
                              Text(
                                'Welcome, $username',
                                style:
                                    appTheme.textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 150,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {});
                          },
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
                            final data = cards[index];
                            return BankInfoCard(
                              // todo bank name masih belum ada di response
                              bankName: data.cardType,
                              accountNumber: data.cardNumber,
                              balance: state.balance.balance.toString(),
                            );
                          },
                        ),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SmoothPageIndicator(
                                controller: _pageController,
                                count: cards.length,
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
                              iconData: Icons.send,
                              text: "Transfer",
                              onTap: () {
                                context.push('/transfer');
                              },
                            ),
                            ButtonCard(
                              iconData: Icons.wallet,
                              text: "Top Up",
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Top up feature is coming soon!'),
                                  ),
                                );
                              },
                            ),
                          ]),
                      const SizedBox(height: 16),
                      TransactionHistory(
                        transactions: transactions,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is HomeError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: const SafeArea(
        child: BottomNavigationUser(selectedIndex: 0),
      ),
    );
  }
}
