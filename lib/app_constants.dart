import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBackground = Color(0xFF121212);
  static const Color secondaryBackground = Color(0xFF1E1E1E);
  static const Color tertiaryBackground = Color(0xFF2A2A2A);
  
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFB0B0B0);
  static const Color tertiaryText = Color(0xFF808080);
  
  static const Color accentPrimary = Color(0xFF4CAF50);
  static const Color accentSecondary = Color(0xFF2196F3);
  static const Color errorRed = Color(0xFFE74C3C);
  static const Color warningOrange = Color(0xFFF39C12);
  
  static const Color scoreButtonGreen = Color(0xFF4CAF50);
  static const Color scoreButtonBlue = Color(0xFF2196F3);
  static const Color scoreButtonRed = Color(0xFFE74C3C);
  static const Color scoreButtonYellow = Color(0xFFFFC107);
}

class AppPadding {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;
}

class AppRadius {
  static const double small = 4.0;
  static const double medium = 8.0;
  static const double large = 12.0;
  static const double extraLarge = 16.0;
}

class AppFontSizes {
  static const double xs = 10.0;
  static const double sm = 12.0;
  static const double base = 14.0;
  static const double lg = 16.0;
  static const double xl = 18.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 48.0;
}

class AppStrings {
  static const String appName = 'DK POPA 11';
  static const String newMatch = 'New Match';
  static const String matchHistory = 'Match History';
  static const String players = 'Players';
  static const String settings = 'Settings';
  
  static const String opponent = 'Opponent';
  static const String overs = 'Overs';
  static const String date = 'Date';
  static const String venue = 'Venue';
  
  static const String batting = 'Batting';
  static const String bowling = 'Bowling';
  static const String score = 'Score';
  static const String wickets = 'Wickets';
  static const String runs = 'Runs';
  static const String balls = 'Balls';
  static const String batsman = 'Batsman';
  static const String bowler = 'Bowler';
  static const String extras = 'Extras';
  
  static const String undo = 'Undo';
  static const String wide = 'Wide';
  static const String noBall = 'No Ball';
  static const String wicket = 'Wicket';
}

class CricketConstants {
  static const int maxPlayers = 11;
  static const int maxOversDefault = 20;
  static const int ballsPerOver = 6;
}