import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/custom_form_field.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:pinput/pinput.dart';

import 'package:mobile_banking_apps/features/settings/presentation/widgets/setting_description.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';

class SettingDetailScreen extends StatefulWidget {
  final String title;
  final String currentValue;
  final String description;
  final bool isPassword;
  final bool isPin;

  final String? initialPin;

  const SettingDetailScreen({
    super.key,
    required this.title,
    required this.currentValue,
    required this.description,
    this.isPassword = false,
    this.isPin = false,
    this.initialPin,
  });

  @override
  State<SettingDetailScreen> createState() => _SettingDetailScreenState();
}

class _SettingDetailScreenState extends State<SettingDetailScreen> {
  late TextEditingController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final PinTheme _defaultPinTheme = PinTheme(
    width: 50,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: AppColors.textBlack,
    ),
    decoration: BoxDecoration(
      color: AppColors.grey,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.darkGray),
    ),
  );

  bool get _isConfirmationMode => widget.isPin && widget.initialPin != null;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
        text: widget.isPin || widget.isPassword ? '' : widget.currentValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      final newPin = _controller.text;

      if (widget.isPin) {
        if (newPin.length != 6) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('PIN harus terdiri dari 6 digit.'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
          return;
        }

        if (!_isConfirmationMode) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => SettingDetailScreen(
                title: 'Konfirmasi PIN',
                currentValue: '',
                description:
                    'Masukkan ulang 6 digit PIN Anda untuk konfirmasi.',
                isPin: true,
                initialPin: newPin,
              ),
            ),
          );
          return;
        } else {
          if (newPin == widget.initialPin) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('PIN berhasil diubah dan dikonfirmasi!'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );

            context.replace("/settings");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Konfirmasi PIN tidak cocok. Silakan coba lagi.'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => SettingDetailScreen(
                  title: widget.title,
                  currentValue: '',
                  description: widget.description,
                  isPin: true,
                ),
              ),
            );
            return;
          }
        }
      } else {
        final newValue = _controller.text;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${widget.title} berhasil diubah menjadi: $newValue'),
            backgroundColor: Colors.blue.shade600,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      Navigator.of(context).pop();
    }
  }

  Widget _buildFormField() {
    if (widget.isPin) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDesignConstants.kDefaultMargin),
        child: Pinput(
          controller: _controller,
          length: 6,
          defaultPinTheme: _defaultPinTheme,
          focusedPinTheme: _defaultPinTheme.copyWith(
            decoration: _defaultPinTheme.decoration!.copyWith(
              border: Border.all(color: AppColors.blueSecondary),
            ),
          ),
          keyboardType: TextInputType.number,
          obscureText: true,
          onCompleted: (pin) {
            _saveChanges();
          },
        ),
      );
    }

    TextInputType keyboardType = TextInputType.text;
    bool isPasswordField = false;
    IconData suffixIcon = Icons.edit;

    if (widget.isPassword) {
      isPasswordField = true;
    } else if (widget.title.toLowerCase() == 'email') {
      keyboardType = TextInputType.emailAddress;
      suffixIcon = Icons.alternate_email;
    }

    return CustomFormField(
      controller: _controller,
      labelText: widget.title,
      keyboardType: keyboardType,
      isPasswordField: isPasswordField,
      suffixIcon: isPasswordField ? null : suffixIcon,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Kolom ${widget.title} tidak boleh kosong';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color screenBackgroundColor = Colors.white;

    final bool showSaveButton = !widget.isPin;

    final String appBarTitle =
        _isConfirmationMode ? 'Konfirmasi PIN' : widget.title;
    final String screenDescription = _isConfirmationMode
        ? 'Masukkan ulang PIN yang sama yang telah Anda buat sebelumnya.'
        : widget.description;

    return PopScope(
      canPop: !_isConfirmationMode,
      onPopInvoked: (didPop) {
        if (!didPop && _isConfirmationMode) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => SettingDetailScreen(
                title: widget.title,
                currentValue: '',
                description: widget.description,
                isPin: true,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: screenBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            appBarTitle,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              if (_isConfirmationMode) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => SettingDetailScreen(
                      title: widget.title,
                      currentValue: '',
                      description: widget.description,
                      isPin: true,
                    ),
                  ),
                );
              } else {
                context.pop();
              }
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SettingDescription(description: screenDescription),
                      _buildFormField(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            if (showSaveButton)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: PrimaryButton(
                  text: 'Save Changes',
                  onPressed: _saveChanges,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
