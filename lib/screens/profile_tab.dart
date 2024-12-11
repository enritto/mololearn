import 'package:flutter/cupertino.dart';
import '../models/user_profile.dart';
import '../utils/app_colors.dart';

class ProfileTab extends StatelessWidget {
  final String username;

  const ProfileTab({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Profile', 
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/profile.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                username, // Use the passed username
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Aspiring cosmetologist and medical enthusiast.',
                textAlign: TextAlign.center,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              CupertinoButton(
                onPressed: () {
                  // Add customization functionality here
                },
                child: const Text('Customize Profile'),
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}