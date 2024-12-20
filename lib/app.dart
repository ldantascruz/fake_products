import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/_core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fake Products',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      locale: const Locale('en', 'US'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US')],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          surface: AppColors.backgroundColor,
        ),
        fontFamily: 'Poppins',
        primaryTextTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          labelMedium: TextStyle(
            color: AppColors.primaryLighterColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            color: AppColors.priceColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          labelLarge: TextStyle(
            color: AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            color: AppColors.priceGreenColor,
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        dividerColor: AppColors.dividerColor,
      ),
      themeMode: ThemeMode.light,
    );
  }
}
