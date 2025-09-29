import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class TransferBackButton extends StatelessWidget {
  const TransferBackButton({
    super.key,
    this.pTop = 20,
    this.pBottom = 20,
    this.pLeft = 18,
    this.pRight = 18,
  });

  final double pTop;
  final double pBottom;
  final double pLeft;
  final double pRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: pLeft,
        right: pRight,
        top: pTop,
        bottom: pBottom,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.darkGray,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
