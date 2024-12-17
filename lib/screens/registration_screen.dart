import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  
  void _toggleLanguage() {
    final provider = LocaleProvider.of(context);
    final newLocale = provider.locale.languageCode == 'ru' 
        ? const Locale('en') 
        : const Locale('ru');
    provider.setLocale(newLocale);
  }

  void _handleRegistration() async {
    // Validate inputs
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      _showErrorDialog(AppLocalizations.of(context)!.pleaseEnterBothEmailAndPassword);
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog(AppLocalizations.of(context)!.passwordsDoNotMatch);
      return;
    }

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential = 
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage = AppLocalizations.of(context)!.registrationFailed;
      
      switch (e.code) {
        case 'weak-password':
          errorMessage = AppLocalizations.of(context)!.passwordTooWeak;
          break;
        case 'email-already-in-use':
          errorMessage = AppLocalizations.of(context)!.emailAlreadyInUse;
          break;
      }

      _showErrorDialog(errorMessage);
      setState(() => _isLoading = false);
    } catch (e) {
      _showErrorDialog(AppLocalizations.of(context)!.unexpectedError);
      setState(() => _isLoading = false);
    }
  }
  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Анимация для уходящего экрана
          var exitTween = Tween(begin: Offset.zero, end: const Offset(-0.3, 0.0))
            .chain(CurveTween(curve: Curves.easeInOut));
          var exitAnimation = secondaryAnimation.drive(exitTween);
          
          // Анимация для входящего экрана
          var enterTween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutQuart));
          var enterAnimation = animation.drive(enterTween);

          // Анимации прозрачности
          var fadeInAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutQuart,
          );
          var fadeOutAnimation = CurvedAnimation(
            parent: secondaryAnimation,
            curve: Curves.easeInOut,
          );

          return Stack(
            children: [
              // Уходящий экран
              SlideTransition(
                position: exitAnimation,
                child: FadeTransition(
                  opacity: Tween(begin: 1.0, end: 0.0).animate(fadeOutAnimation),
                  child: secondaryAnimation.value < 0.5 ? child : null,
                ),
              ),
              // Входящий экран
              SlideTransition(
                position: enterAnimation,
                child: FadeTransition(
                  opacity: fadeInAnimation,
                  child: animation.value > 0.5 ? child : null,
                ),
              ),
            ],
          );
        },
        transitionDuration: const Duration(milliseconds: 700),
        reverseTransitionDuration: const Duration(milliseconds: 700),
      ),
    );
  }
  void _handleVerificationCheck() async {
  User? user = _auth.currentUser;
  
  if (user != null && user.emailVerified) {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  } else {
    _showErrorDialog(AppLocalizations.of(context)!.pleaseVerifyEmail);
  }
}

  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(AppLocalizations.of(context)!.registrationError),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text(AppLocalizations.of(context)!.ok),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(AppLocalizations.of(context)!.success),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text(AppLocalizations.of(context)!.ok),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF8F0E6),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFFF8F0E6).withOpacity(0.7),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(
            CupertinoIcons.back,
            color: Color(0xFF7A7170),
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _toggleLanguage,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF7A7170).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              LocaleProvider.of(context).locale.languageCode.toUpperCase() == 'RU' ? 'EN' : 'RU',
              style: const TextStyle(
                color: Color(0xFF7A7170),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  
                  // Лого
                  Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final logoSize = constraints.maxWidth * 0.8;
                        return Image.asset(
                          'assets/molodost.png',
                          width: logoSize,
                          height: logoSize/5,
                        );
                      },
                    ),
                  ).animate()
                    .fadeIn(
                      duration: 1200.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .scaleXY(
                      begin: 0.8,
                      end: 1.0,
                      duration: 1200.ms,
                      curve: Curves.easeOutCubic,
                    ),

                  const SizedBox(height: 32),

                  // Заголовок
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.createAccount,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7A7170),
                      ),
                    ),
                  ).animate()
                    .fadeIn(
                      duration: 800.ms,
                      delay: 400.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .slideX(
                      begin: -0.3,
                      curve: Curves.easeOutCubic,
                    ),

        const SizedBox(height: 10),

                  // Подзаголовок
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.signUpToContinue,
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF7A7170).withOpacity(0.8),
                      ),
                    ),
                  ).animate()
                    .fadeIn(
                      duration: 800.ms,
                      delay: 600.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .slideX(
                      begin: -0.3,
                      curve: Curves.easeOutCubic,
                    ),

                  const Spacer(),

                  // Поля ввода
                  CupertinoTextField(
                    controller: _emailController,
                    placeholder: AppLocalizations.of(context)!.email,
                    keyboardType: TextInputType.emailAddress,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ).animate()
                    .fadeIn(
                      duration: 800.ms,
                      delay: 800.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .slideX(
                      begin: -0.3,
                      curve: Curves.easeOutCubic,
                    ),

                  const SizedBox(height: 16),

                  CupertinoTextField(
                    controller: _passwordController,
                    placeholder: AppLocalizations.of(context)!.password,
                    obscureText: true,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ).animate()
                    .fadeIn(
                      duration: 800.ms,
                      delay: 1000.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .slideX(
                      begin: -0.3,
                      curve: Curves.easeOutCubic,
                    ),

                  const SizedBox(height: 16),

                  CupertinoTextField(
                    controller: _confirmPasswordController,
                    placeholder: AppLocalizations.of(context)!.confirmPassword,
                    obscureText: true,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ).animate()
                    .fadeIn(
                      duration: 800.ms,
                      delay: 1200.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .slideX(
                      begin: -0.3,
                      curve: Curves.easeOutCubic,
                    ),

                  const SizedBox(height: 32),

                  // Кнопка регистрации
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      color: const Color(0xFF7A7170),
                      borderRadius: BorderRadius.circular(12),
                      onPressed: _isLoading ? null : _handleRegistration,
                      child: _isLoading
                          ? const CupertinoActivityIndicator(color: CupertinoColors.white)
                          : Text(
                              AppLocalizations.of(context)!.register,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ).animate()
                    .fadeIn(
                      duration: 800.ms,
                      delay: 1400.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .slideY(
                      begin: 0.3,
                      curve: Curves.easeOutCubic,
                    ),

                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}