import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../screens/main_screen.dart';
import '../utils/app_colors.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleProvider.of(context);
    
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF0F0F3),
      child: SafeArea(
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.feedTab,
            style: TextStyle(
              fontSize: 24,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}