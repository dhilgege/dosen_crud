import 'package:flutter/material.dart';

/// App Colors - Warm orange-gold theme inspired by Indian colors
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFFFF6B35); // Warm orange
  static const Color primaryVariant = Color(0xFFFF8C42); // Lighter orange
  static const Color secondary = Color(0xFFFFD23F); // Gold yellow
  static const Color secondaryVariant = Color(0xFFFFE066); // Light gold

  // Background colors
  static const Color background = Color(0xFFFFFAF0); // Cream white
  static const Color surface = Color(0xFFFFFFFF); // Pure white
  static const Color surfaceVariant = Color(0xFFFFF8E1); // Light cream

  // Text colors
  static const Color onPrimary = Color(0xFFFFFFFF); // White on primary
  static const Color onSecondary = Color(0xFF2D2D2D); // Dark on secondary
  static const Color onBackground = Color(0xFF2D2D2D); // Dark text
  static const Color onSurface = Color(0xFF2D2D2D); // Dark text

  // Error colors
  static const Color error = Color(0xFFD32F2F);
  static const Color onError = Color(0xFFFFFFFF);

  // Additional colors
  static const Color cardShadow = Color(0x1F000000); // Subtle shadow
  static const Color divider = Color(0xFFE0E0E0);
}