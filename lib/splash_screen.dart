import 'package:flutter/material.dart';
import 'app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.appName,
              style: const TextStyle(
                color: AppColors.accentPrimary,
                fontSize: AppFontSizes.huge,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppPadding.large),
            const CircularProgressIndicator(
              color: AppColors.accentPrimary,
            ),
          ],
        ),
      ),
    );
  }
}