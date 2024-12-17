import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import 'dashboard_tab.dart';
import 'feed_tab.dart';
import 'profile_tab.dart';

class MainScreen extends StatefulWidget {
  final String username;

  const MainScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Neomorphic color palette
  final Color _backgroundColor = const Color(0xFFF0F0F3);
  final Color _shadowColorLight = Colors.white;
  final Color _shadowColorDark = const Color(0xFFA0A0A4);
  final Color _textColor = const Color(0xFF4A4A4A);

  // Neomorphic decoration method
  BoxDecoration _neomorphicDecoration({
    BorderRadius? borderRadius,
    bool isSelected = false,
  }) {
    return BoxDecoration(
      color: _backgroundColor,
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      boxShadow: isSelected
          ? null
          : [
              BoxShadow(
                color: _shadowColorDark.withOpacity(0.2),
                offset: const Offset(4, 4),
                blurRadius: 6,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: _shadowColorLight,
                offset: const Offset(-4, -4),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
    );
  }

  @override

  @override
Widget build(BuildContext context) {
  final List<({IconData icon, String label, Widget screen})> tabs = [
      (
        icon: CupertinoIcons.book_solid,
        label: AppLocalizations.of(context)!.coursesTab,
        screen: DashboardTab(),
      ),
      (
        icon: CupertinoIcons.news_solid,
        label: AppLocalizations.of(context)!.feedTab,
        screen: const FeedTab(),
      ),
      (
        icon: CupertinoIcons.profile_circled,
        label: AppLocalizations.of(context)!.profileTab,
        screen: ProfileTab(username: widget.username),
      ),
    ];



  return CupertinoPageScaffold(
    backgroundColor: _backgroundColor,
    child: MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: Column(
        children: [
          // Content
          Expanded(
            child: SafeArea(
              bottom: false,
              child: IndexedStack(
                index: _currentIndex,
                children: tabs.map((tab) => tab.screen).toList(),
              ),
            ),
          ),

          // Neomorphic Bottom Navigation Bar
          SafeArea(
            top: false,
            child: Container(
              height: 70,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: _shadowColorDark.withOpacity(0.3),
                    offset: const Offset(4, 4),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: _shadowColorLight,
                    offset: const Offset(-4, -4),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  tabs.length,
                  (index) => _buildTabItem(
                    icon: tabs[index].icon,
                    isSelected: _currentIndex == index,
                    onTap: () => setState(() => _currentIndex = index),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildTabItem({
  required IconData icon,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: _backgroundColor,
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
                  // Inner shadow when pressed (lowered effect)
                  BoxShadow(
                    color: _shadowColorDark.withOpacity(0.4),
                    offset: const Offset(-2, -2),
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: _shadowColorLight.withOpacity(0.7),
                    offset: const Offset(2, 2),
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  // Raised effect when not selected
                  BoxShadow(
                    color: _shadowColorDark.withOpacity(0.3),
                    offset: const Offset(3, 3),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: _shadowColorLight,
                    offset: const Offset(-3, -3),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: Center(
          child: Icon(
            icon,
            size: 22,
            color: isSelected 
              ? Colors.blue.shade300 
              : _textColor.withOpacity(0.6),
          ),
        ),
      ),
    ),
  );
}
}