// lib/core/app_typography.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // Color Constants
  static const Color _textColorDark = Color(0xFF4A4A4A);
  static const Color _textColorLight = Color(0xFF7A7170);

  // Heading Styles (matches login screen)
  static TextStyle heading = GoogleFonts.manrope(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: _textColorDark,
  );

  static TextStyle subHeading = GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    color: _textColorLight.withOpacity(0.8),
  );

  // Body Styles
  static TextStyle body = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: _textColorLight,
  );

  // Button Text Style
  static TextStyle buttonText = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
    color: _textColorDark,
  );

  // Input Text Styles
  static TextStyle inputText = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: _textColorDark,
  );

  static TextStyle inputPlaceholder = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: _textColorLight.withOpacity(0.5),
  );

  // Create Account Text Style
  static TextStyle createAccountText = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: _textColorDark,
  );

  // Profile-specific styles (maintaining consistency)
  static TextStyle profileName = GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: _textColorDark,
  );

  static TextStyle profileSubtitle = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: _textColorLight.withOpacity(0.8),
  );
}