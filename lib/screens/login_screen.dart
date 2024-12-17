import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_screen.dart';
import 'registration_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../widgets/language_change_clipper.dart';
import 'package:flutter/rendering.dart';
import '../core/app_typography.dart';

// Typography Class


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isLoading = false;
  bool _isEmailPressed = false;
  bool _isPasswordPressed = false;
  bool _isAnimating = false;
  Widget? _animatedWidget;
  Locale? _nextLocale;
  final GlobalKey _languageButtonKey = GlobalKey();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleLanguage() {
    if (_isAnimating) return;

    final provider = LocaleProvider.of(context);
    _nextLocale = provider.locale.languageCode == 'ru' 
        ? const Locale('en') 
        : const Locale('ru');

    setState(() {
      _isAnimating = true;
      _animatedWidget = LanguageChangeTransition(
        onAnimationComplete: () {
          setState(() {
            _isAnimating = false;
            _animatedWidget = null;
            provider.setLocale(_nextLocale!);
          });
        },
        child: _buildContent(true),
      );
    });
  }

  Widget _buildContent([bool excludeLogo = false]) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),
                
                if (!excludeLogo)
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
                    )
                    .then()
                    .shimmer(
                      duration: 1800.ms,
                      color: Colors.white.withOpacity(0.2),
                      angle: 45,
                    ),

                const SizedBox(height: 32),
                
                SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.welcomeBack,
                      textAlign: TextAlign.center,
                      style: AppTypography.heading,
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
                  
                const SizedBox(height: 8),
                
                SizedBox(
                  width: double.infinity,
                  height: 24,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.signInToContinue,
                      textAlign: TextAlign.center,
                      style: AppTypography.subHeading,
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
                  
                const Spacer(flex: 1),
                
                StatefulBuilder(
                  builder: (context, setState) {
                    return TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 2000),
                      curve: Curves.elasticOut,
                      tween: Tween<double>(
                        begin: 1.0,
                        end: _isEmailPressed ? 1.04 : 1.0,
                      ),
                      builder: (context, double scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: GestureDetector(
                            onTapDown: (_) => setState(() => _isEmailPressed = true),
                            onTapUp: (_) => setState(() => _isEmailPressed = false),
                            onTapCancel: () => setState(() => _isEmailPressed = false),
                            behavior: HitTestBehavior.translucent,
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                setState(() => _isEmailPressed = hasFocus);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 2000),
                                curve: Curves.elasticOut,
                                transform: Matrix4.identity()
                                  ..translate(0.0, _isEmailPressed ? 4.0 : 0.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F0F3),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    // Внешняя тень (сделали менее прозрачной)
                                    BoxShadow(
                                      color: Colors.black.withOpacity(_isEmailPressed ? 0.15 : 0.15),
                                      offset: Offset(_isEmailPressed ? 12 : 8, _isEmailPressed ? 12 : 8),
                                      blurRadius: _isEmailPressed ? 20 : 15,
                                      spreadRadius: _isEmailPressed ? -3 : -5,
                                    ),
                                    // Внутреннее свечение (без изменений)
                                    BoxShadow(
                                      color: Colors.white.withOpacity(_isEmailPressed ? 1 : 0.8),
                                      offset: Offset(_isEmailPressed ? -12 : -8, _isEmailPressed ? -12 : -8),
                                      blurRadius: _isEmailPressed ? 20 : 15,
                                      spreadRadius: _isEmailPressed ? -3 : -5,
                                    ),
                                    // Дополнительная мягкая тень (сделали более заметной)
                                    BoxShadow(
                                      color: Colors.black.withOpacity(_isEmailPressed ? 0.08 : 0.07),
                                      offset: Offset(_isEmailPressed ? 6 : 4, _isEmailPressed ? 6 : 4),
                                      blurRadius: _isEmailPressed ? 8 : 5,
                                      spreadRadius: _isEmailPressed ? -2 : -3,
                                    ),
                                  ],
                                ),
                                child: CupertinoTextField(
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  placeholder: AppLocalizations.of(context)!.email,
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  style: AppTypography.inputText,
                                  placeholderStyle: AppTypography.inputPlaceholder,
                                  onTap: () {
                                    setState(() => _isEmailPressed = true);
                                    _emailFocusNode.requestFocus();
                                  },
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (_) {
                                    _emailFocusNode.unfocus();
                                    _passwordFocusNode.requestFocus();
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
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
                
                StatefulBuilder(
                  builder: (context, setState) {
                    return TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 2000),
                      curve: Curves.elasticOut,
                      tween: Tween<double>(
                        begin: 1.0,
                        end: _isPasswordPressed ? 1.04 : 1.0,
                      ),
                      builder: (context, double scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: GestureDetector(
                            onTapDown: (_) => setState(() => _isPasswordPressed = true),
                            onTapUp: (_) => setState(() => _isPasswordPressed = false),
                            onTapCancel: () => setState(() => _isPasswordPressed = false),
                            behavior: HitTestBehavior.translucent,
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                setState(() => _isPasswordPressed = hasFocus);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 2000),
                                curve: Curves.elasticOut,
                                transform: Matrix4.identity()
                                  ..translate(0.0, _isPasswordPressed ? 4.0 : 0.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F0F3),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(_isPasswordPressed ? 0.15 : 0.15),
                                      offset: Offset(_isPasswordPressed ? 12 : 8, _isPasswordPressed ? 12 : 8),
                                      blurRadius: _isPasswordPressed ? 20 : 15,
                                      spreadRadius: _isPasswordPressed ? -3 : -5,
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(_isPasswordPressed ? 1 : 0.8),
                                      offset: Offset(_isPasswordPressed ? -12 : -8, _isPasswordPressed ? -12 : -8),
                                      blurRadius: _isPasswordPressed ? 20 : 15,
                                      spreadRadius: _isPasswordPressed ? -3 : -5,
                                    ),
                                    BoxShadow(
                                      color: Colors.black.withOpacity(_isPasswordPressed ? 0.08 : 0.07),
                                      offset: Offset(_isPasswordPressed ? 6 : 4, _isPasswordPressed ? 6 : 4),
                                      blurRadius: _isPasswordPressed ? 8 : 5,
                                      spreadRadius: _isPasswordPressed ? -2 : -3,
                                    ),
                                  ],
                                ),
                                child: CupertinoTextField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  placeholder: AppLocalizations.of(context)!.password,
                                  obscureText: true,
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  style: AppTypography.inputText,
                                  placeholderStyle: AppTypography.inputPlaceholder,
                                  onTap: () {
                                    setState(() => _isPasswordPressed = true);
                                    _passwordFocusNode.requestFocus();
                                  },
                                  textInputAction: TextInputAction.go,
                                  onSubmitted: (_) {
                                    _passwordFocusNode.unfocus();
                                    _handleLogin();
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
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
                  
                const SizedBox(height: 32),
                
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFF0F0F3),  // Еще светлее
                          Color(0xFFF0F0F3),  // Еще темнее
                        ],
                        stops: [0.2, 0.8],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        // Внешняя тень (более выраженная)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(8, 8),
                          blurRadius: 8,
                          spreadRadius: -5,
                        ),
                        // Внутреннее свечение (более яркое)
                        BoxShadow(
                          color: Colors.white.withOpacity(1),
                          offset: const Offset(-8, -8),
                          blurRadius: 8,
                          spreadRadius: -5,
                        ),
                        // Дополнительная внутренняя тень для глубины
                      ],
                    ),
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      borderRadius: BorderRadius.circular(12),
                      onPressed: _isLoading ? null : _handleLogin,
                      color: Colors.transparent, // Делаем кнопку прозрачной
                      child: _isLoading
                          ? const CupertinoActivityIndicator(color: CupertinoColors.white)
                          : Text(
                              AppLocalizations.of(context)!.login.toUpperCase(),
                              style: AppTypography.buttonText,
                            ),
                    ),
                  ),
                ).animate()
                  .fadeIn(
                    duration: 800.ms,
                    delay: 1200.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .slideY(
                    begin: 0.3,
                    curve: Curves.easeOutCubic,
                  ),
                  
                const SizedBox(height: 16),
                
                Center(
                  child: CupertinoButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const RegistrationScreen(),
                        ),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.createAccount,
                      style: AppTypography.createAccountText,
                    ),
                  ),
                ).animate()
                  .fadeIn(
                    duration: 800.ms,
                    delay: 1400.ms,
                  )
                  .then()
                  .shimmer(
                    duration: 3.seconds,
                    delay: 2.seconds,
                    color: const Color(0xFF4A4A4A).withOpacity(0.3),
                    angle: 45,
                  ),
                  
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF0F0F3),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFFF0F0F3).withOpacity(0.7),
        border: null,
        trailing: CupertinoButton(
          key: _languageButtonKey,
          padding: EdgeInsets.zero,
          onPressed: _toggleLanguage,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              boxShadow: [
                        // Внешняя тень (более выраженная)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                          spreadRadius: -1,
                        ),
                        // Внутреннее свечение (более яркое)
                        BoxShadow(
                          color: Colors.white.withOpacity(1),
                          offset: const Offset(-1, -1),
                          blurRadius: 2,
                          spreadRadius: -1,
                        ),
                        // Дополнительная внутренняя тень для глубины
                      ],
              color: const Color(0xFF4A4A4A).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              LocaleProvider.of(context).locale.languageCode.toUpperCase() == 'RU' ? 'EN' : 'RU',
              style: AppTypography.createAccountText.copyWith(
                fontSize: 14,
                color: const Color(0xFF4A4A4A),
              ),
            ),
          ),
        ),
      ),
      child: Stack(
        children: [
          _buildContent(false),
          if (_animatedWidget != null) _animatedWidget!,
        ],
      ),
    );
  }

  void _handleLogin() async {
    if (_emailController.text.trim().isEmpty || 
        _passwordController.text.trim().isEmpty) {
      _showErrorDialog(AppLocalizations.of(context)!.pleaseEnterBothEmailAndPassword);
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        if (!userCredential.user!.emailVerified) {
          await userCredential.user!.sendEmailVerification();
          _showErrorDialog(AppLocalizations.of(context)!.pleaseVerifyEmail);
          setState(() => _isLoading = false);
          return;
        }

        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => MainScreen(
              username: userCredential.user!.email?.split('@')[0] ?? 'User',
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = AppLocalizations.of(context)!.loginFailed;
      
      switch (e.code) {
        case 'user-not-found':
          errorMessage = AppLocalizations.of(context)!.noUserFound;
          break;
        case 'wrong-password':
          errorMessage = AppLocalizations.of(context)!.incorrectPassword;
          break;
        case 'too-many-requests':
          errorMessage = AppLocalizations.of(context)!.tooManyLoginAttempts;
          break;
      }

      _showErrorDialog(errorMessage);
    } catch (e) {
      _showErrorDialog(AppLocalizations.of(context)!.unexpectedError);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(AppLocalizations.of(context)!.loginError),
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
}