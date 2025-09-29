import 'package:flutter/material.dart';

class AppColors {
  static const Color bluePrimary = Color.fromRGBO(151, 200, 242, 1);
  static const Color blueSecondary = Color.fromRGBO(103, 181, 245, 1);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFF6F6F6);
  static const Color darkGray = Color(0xFFA8A3A9);

  // Warna Status (Status Colors)
  static const Color success = Color(0xFF00A36C);
  static const Color error = Color(0xFFE3002D);
  static const Color warning = Color(0xFFFFC107);

  // Warna Teks
  static const Color textBlack = Color(0xFF181818);
  static const Color textGrey = Color(0xFFA8A3A9);
}

final ThemeData appTheme = ThemeData(
  // Mengatur warna dasar dari skema warna
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.bluePrimary,
    primary: AppColors.bluePrimary,
    // secondary: AppColors.blueSecondary,
    error: AppColors.error,
    surface: AppColors.surface,
  ),

  // Mengatur tema secara keseluruhan
  scaffoldBackgroundColor: AppColors.surface,
  fontFamily:
      'Poppins', // Contoh font yang profesional (Anda harus menambahkannya ke pubspec.yaml)

  textTheme: const TextTheme(
    // Digunakan untuk judul besar/header, menggunakan SemiBold (weight 600)
    headlineLarge: TextStyle(
        fontWeight: FontWeight.w500, fontSize: 32, color: Colors.white),
    headlineMedium: TextStyle(
        fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
    headlineSmall: TextStyle(
        fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),

    // Digunakan untuk judul sub-bagian, menggunakan SemiBold
    titleLarge: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 20, color: AppColors.textBlack),
    titleMedium: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.textBlack),
    titleSmall: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.textBlack),

    // Digunakan untuk teks isi/body, menggunakan Medium (weight 500)
    bodyLarge: TextStyle(
        fontWeight: FontWeight.w500, fontSize: 16, color: AppColors.textGrey),
    bodyMedium: TextStyle(
        fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.textGrey),
    bodySmall: TextStyle(
        fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.textGrey),

    // Digunakan untuk tombol dan caption
    labelLarge: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 24,
        color: Colors.white), // Biasanya putih pada tombol
  ),
  // Tema App Bar
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.surface, // Background putih
    elevation: 0.5, // Sedikit bayangan
    iconTheme: IconThemeData(color: AppColors.textBlack),
    titleTextStyle: TextStyle(
      color: AppColors.textBlack,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  // Tema Tombol Utama (Elevated Button)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.blueSecondary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0), // Melengkung penuh (seperti PrimaryButton Anda)
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  // Tema Input Formulir (Text Field)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: AppColors.bluePrimary, width: 2),
    ),
    labelStyle: TextStyle(color: AppColors.textGrey),
  ),
);
