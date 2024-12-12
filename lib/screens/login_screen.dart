import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_screen.dart';
import 'registration_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  final Locale currentLocale;
  final Function(Locale) onLocaleChanged;

  const LoginScreen({
    Key? key, 
    required this.currentLocale, 
    required this.onLocaleChanged
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isObscured = true;
  bool _isLoading = false;

  void _handleLogin() async {
    // Validate input first
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

      // Additional email verification check
      if (userCredential.user != null) {
        if (!userCredential.user!.emailVerified) {
          await userCredential.user!.sendEmailVerification();
          _showErrorDialog(AppLocalizations.of(context)!.pleaseVerifyEmail);
          setState(() => _isLoading = false);
          return;
        }

        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (_) => MainScreen(
              username: userCredential.user!.email?.split('@')[0] ?? 'User ',
            )
          )
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

  // Method to toggle language
  void _toggleLanguage() {
    Locale newLocale = widget.currentLocale.languageCode == 'en'
        ? const Locale('ru')
        : const Locale('en');
    
    widget.onLocaleChanged(newLocale);
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

  void _handleForgotPassword() async {
    if (_emailController.text.trim().isEmpty) {
      _showErrorDialog(AppLocalizations.of(context)!.pleaseEnterEmail);
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(AppLocalizations.of(context)!.passwordReset),
          content: Text(AppLocalizations.of(context)!.passwordResetLinkSent),
          actions: [
            CupertinoDialogAction(
              child: Text(AppLocalizations.of(context)!.ok),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    } catch (e) {
      _showErrorDialog(AppLocalizations.of(context)!.failedToSendPasswordReset);
    }
  }

  void _navigateToRegistration() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => RegistrationScreen(
          currentLocale: widget.currentLocale,
          onLocaleChanged: widget.onLocaleChanged,
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFF8F0E6),
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(widget.currentLocale.languageCode == 'en' ? 'RU' : 'EN'),
          onPressed: _toggleLanguage,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                
                // Title with animation
                Text(
                  AppLocalizations.of(context)!.welcomeBack,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.black,
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.5),
                
                const SizedBox(height: 10),
                
                Text(
                  AppLocalizations.of(context)!.signInToContinue,
                  style: TextStyle(
                    fontSize: 18,
                    color: CupertinoColors.systemGrey,
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.5),
                
                const SizedBox(height: 50),
                
                // Email Input
                _buildInputField(
                  controller: _emailController,
                  placeholder: AppLocalizations.of(context)!.email,
                  prefixIcon: CupertinoIcons.mail,
                ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.5),
                
                const SizedBox(height: 20),
                
                // Password Input
                _buildPasswordField(),
                
                const SizedBox(height: 30),
                
                // Login Button
                _buildLoginButton(),
                
                const SizedBox(height: 20),
                
                // Forgot Password
                Center(
                  child: CupertinoButton(
                    child: Text(
                      AppLocalizations.of(context)!.forgotPassword,
                      style: TextStyle(color: Color(0xFF7A7170)),
                    ),
                    onPressed: _handleForgotPassword,
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Create Account
                Center(
                  child: CupertinoButton(
                    child: Text(
                      AppLocalizations.of(context )!.createAccount,
                      style: TextStyle(color: Color(0xFF7A7170)),
                    ),
                    onPressed: _navigateToRegistration,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Social Login Options
                _buildSocialLogins(),
                
                const SizedBox(height: 20),
                
                // Logo
                Center(
                  child: Image.asset(
                    'assets/molodost.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String placeholder,
    required IconData prefixIcon,
  }) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      prefix: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(prefixIcon, color: CupertinoColors.systemGrey),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    );
  }

  Widget _buildPasswordField() {
    return CupertinoTextField(
      controller: _passwordController,
      placeholder: AppLocalizations.of(context)!.password,
      prefix: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(CupertinoIcons.lock, color: CupertinoColors.systemGrey),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      obscureText: _isObscured,
      suffix: GestureDetector(
        onTap: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            _isObscured ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
  return Center(
    child: SizedBox(
      width: 100, // or any other width you want
      height: 40, // or any other height you want
      child: CupertinoButton(
        padding: const EdgeInsets.all(0), // remove default padding
        color: Color(0xFF7A7170),
        child: Text(
          AppLocalizations.of(context)!.login,
          style: const TextStyle(color: Color(0xFFF8F0E6)),
        ),
        onPressed: _isLoading ? null : _handleLogin,
      ),
    ),
  );
}

  Widget _buildSocialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialLoginButton(
          icon: CupertinoIcons.globe,
          onTap: _toggleLanguage,
          label: widget.currentLocale.languageCode == 'en' ? 'RU' : 'EN',
        ),
      ],
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _socialLoginButton({
    required IconData icon,
    required VoidCallback onTap,
    required String label,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF7A7170)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, size: 24, color: CupertinoColors.systemGrey),
            const SizedBox(width: 8),
            Text(
              label, 
              style: TextStyle(
                color: CupertinoColors.systemGrey, 
                fontWeight: FontWeight.bold
              )
            ),
          ],
        ),
        onPressed: onTap,
      ),
    );
  }
}