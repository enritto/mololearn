import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/locale_provider.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = LocaleProvider.of(context);
    
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.feedTab,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}