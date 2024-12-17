import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../utils/app_colors.dart';
import '../models/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../screens/edit_profile_screen.dart';
import 'dart:ui';
import '../core/app_typography.dart';

class ProfileTab extends StatefulWidget {
  final String username;

  const ProfileTab({
    super.key,
    required this.username,
  });

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with SingleTickerProviderStateMixin {
  late AnimationController _languageAnimationController;
  late TextEditingController _bioController;
  late TextEditingController _specialtyController;
  late UserProfile _userProfile;

  // Neomorphic color palette
  final Color _backgroundColor = const Color(0xFFF0F0F3);
  final Color _shadowColorLight = Colors.white;
  final Color _shadowColorDark = const Color(0xFFA0A0A4);
  final Color _textColor = const Color(0xFF4A4A4A);

  // Neomorphic decoration method
  BoxDecoration _neomorphicDecoration({
    BorderRadius? borderRadius,
    bool isPressed = false,
  }) {
    return BoxDecoration(
      color: _backgroundColor,
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      boxShadow: isPressed
          ? null
          : [
              BoxShadow(
                color: _shadowColorDark.withOpacity(0.2),
                offset: const Offset(4, 6),
                blurRadius: 8,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: _shadowColorLight.withOpacity(0.7),
                offset: const Offset(-4, -6),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
    );
  }

  Map<String, String> get _localizedAchievements => {
    'First Course Completed': AppLocalizations.of(context)!.achievementFirstCourse,
    'Perfect Score': AppLocalizations.of(context)!.achievementPerfectScore,
    'Early Bird': AppLocalizations.of(context)!.achievementEarlyBird,
  };

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController();
    _specialtyController = TextEditingController();
    _languageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    
    _userProfile = UserProfile(
      uid: 'test_uid',
      name: widget.username,
      email: 'user@example.com',
      bio: 'Passionate medical student',
      specialty: 'General Medicine',
      profilePicture: 'assets/profile.jpg',
      joinDate: DateTime.now().subtract(const Duration(days: 30)),
      coursesCompleted: 5,
      overallProgress: 0.75,
      certificatesEarned: 3,
      achievements: [
        'First Course Completed',
        'Perfect Score',
        'Early Bird'
      ],
      currentCourses: [
        'Advanced Anatomy',
        'Clinical Practice',
        'Medical Ethics'
      ],
      courseProgress: {
        'Advanced Anatomy': 0.8,
        'Clinical Practice': 0.5,
        'Medical Ethics': 0.3,
      },
    );
    
    _bioController.text = _userProfile.bio;
    _specialtyController.text = _userProfile.specialty;
  }

  @override
  void dispose() {
    _bioController.dispose();
    _specialtyController.dispose();
    _languageAnimationController.dispose();
    super.dispose();
  }

  // Neomorphic Language Toggle
  Widget _buildLanguageToggle() {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _shadowColorDark.withOpacity(0.2),
              offset: const Offset(1, 1),
              blurRadius: 3,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: _shadowColorLight,
              offset: const Offset(-1, -1),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          LocaleProvider.of(context).locale.languageCode.toUpperCase() == 'RU' ? 'EN' : 'RU',
          style: AppTypography.createAccountText.copyWith(
            fontSize: 14,
            color: _textColor,
          ),
        ),
      ),
    );
  }

  // Neomorphic Profile Header with Avatar
  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: _neomorphicDecoration(
            borderRadius: BorderRadius.circular(70),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(_userProfile.profilePicture),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _userProfile.name,
          style: AppTypography.profileName,
        ),
        const SizedBox(height: 8),
        Text(
          _userProfile.specialty,
          style: AppTypography.profileSubtitle,
        ),
      ],
    );
  }

  // Stat Widget with Neomorphic Design
  Widget _buildStat(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: _neomorphicDecoration(),
      child: Column(
        children: [
          Text(
            value,
            style: AppTypography.heading.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.body.copyWith(
              fontSize: 12,
              color: _textColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  // Achievements List with Neomorphic Styling
  Widget _buildAchievementsList() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _userProfile.achievements.map((achievement) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: _neomorphicDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            _localizedAchievements[achievement] ?? achievement,
            style: AppTypography.body.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  // Courses List with Neomorphic Design
  Widget _buildCoursesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _userProfile.currentCourses.map((course) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: _neomorphicDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  course,
                  style: AppTypography.body,
                ),
                Container(
                  width: 50,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: _shadowColorDark.withOpacity(0.2),
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                      ),
                      BoxShadow(
                        color: _shadowColorLight,
                        offset: const Offset(-2, -2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: FractionallySizedBox(
                    widthFactor: _userProfile.courseProgress[course] ?? 0,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Logout Button with Neomorphic Design
  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: _showLogoutConfirmation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: _neomorphicDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.logout,
            style: AppTypography.buttonText.copyWith(
              color: Colors.red.shade400,
            ),
          ),
        ),
      ),
    );
  }

  // Language Toggle Method
  void _toggleLanguage() {
    final provider = LocaleProvider.of(context);
    final newLocale = provider.locale.languageCode == 'ru' 
        ? const Locale('en') 
        : const Locale('ru');
    provider.setLocale(newLocale);
  }

  // Logout Confirmation Dialog
  Future<void> _showLogoutConfirmation() async {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          AppLocalizations.of(context)!.logoutConfirmTitle,
          style: AppTypography.subHeading,
        ),
        content: Text(
          AppLocalizations.of(context)!.logoutConfirmMessage,
          style: AppTypography.body.copyWith(
            color: _textColor.withOpacity(0.7),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: AppTypography.buttonText,
            ),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              _handleLogout();
            },
            child: Text(
              AppLocalizations.of(context)!.confirm,
              style: AppTypography.buttonText.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Logout Handler
  Future<void> _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: _backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: _backgroundColor.withOpacity(0.8),
        border: null,
        middle: Text(
          AppLocalizations.of(context)!.profile,
          style: AppTypography.heading.copyWith(
            color: _textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: _buildLanguageToggle(),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),
              
              // Statistics Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildStat(
                      AppLocalizations.of(context)!.coursesCompleted,
                      _userProfile.coursesCompleted.toString(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStat(
                      AppLocalizations.of(context)!.certificatesEarned,
                      _userProfile.certificatesEarned.toString(),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Achievements Section
              Container(
                width: double.infinity, // This ensures full width
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: _neomorphicDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.achievements,
                      style: AppTypography.subHeading,
                    ),
                    const SizedBox(height: 12),
                    _buildAchievementsList(),
                  ],
                ),
              ),
              
              // Courses Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _neomorphicDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.currentCourses,
                      style: AppTypography.subHeading,
                    ),
                    const SizedBox(height: 12),
                    _buildCoursesList(),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Logout Button
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}