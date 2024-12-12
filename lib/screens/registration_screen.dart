import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final Locale currentLocale;
  final Function(Locale) onLocaleChanged;

  const RegistrationScreen({
    Key? key, 
    required this.currentLocale, 
    required this.onLocaleChanged
  }) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isObscured = true;
  bool _isLoading = false;
  bool _isEmailSent = false;

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
        _isEmailSent = true;
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

  void _handleVerificationCheck() async {
    User? user = _auth.currentUser;
    
    if (user != null) {
      await user.reload();
      
      if (user.emailVerified) {
        // Navigate to Login Screen
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (_) => LoginScreen(
              currentLocale: widget.currentLocale,
              onLocaleChanged: widget.onLocaleChanged,
            ),
          )
        );
      } else {
        _showErrorDialog(AppLocalizations.of(context)!.pleaseVerifyEmail);
      }
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
    // If email verification is sent, show verification screen
    if (_isEmailSent) {
      return CupertinoPageScaffold(
        backgroundColor: Color(0xFFF8F0E6),
        navigationBar: CupertinoNavigationBar(
          middle: Text(AppLocalizations.of(context)!.verifyEmail),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text(widget.currentLocale.languageCode == 'en' ? 'RU' : 'EN'),
            onPressed: () {
              // Toggle between English and Russian
              Locale newLocale = widget.currentLocale.languageCode == 'en'
                  ? const Locale('ru')
                  : const Locale('en');
              widget.onLocaleChanged(newLocale);
            },
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.mail_solid, 
                  size: 100, 
                  color: Color(0xFF7A7170)
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.verifyYourEmail,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7A7170),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.verificationEmailSent(_emailController.text.trim()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                const SizedBox(height: 30),
                CupertinoButton.filled(
                  onPressed: _handleVerificationCheck,
                  child: Text(AppLocalizations.of(context)!.iHaveVerifiedMyEmail),
                ),
                const SizedBox(height: 20),
                CupertinoButton(
                  child: Text(AppLocalizations.of(context)!.resendVerificationEmail),
                  onPressed: () async {
                    try {
                      await _auth.currentUser?.sendEmailVerification();
                      _showSuccessDialog(AppLocalizations.of(context)!.verificationEmailResent);
                    } catch (e) {
                      _showErrorDialog(AppLocalizations.of(context)!.failedToResendVerificationEmail);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      );
    }

    // Original registration screen
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFF8F0E6),
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context)!.createAccount),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(widget.currentLocale.languageCode == 'en' ? 'RU' : 'EN'),
          onPressed: () {
            // Toggle between English and Russian
            Locale newLocale = widget.currentLocale.languageCode == 'en'
                ? const Locale(' ru')
                : const Locale('en');
            widget.onLocaleChanged(newLocale);
          },
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
                
                Text(
                  AppLocalizations.of(context)!.createYourAccount,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7A7170),
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.5),
                
                const SizedBox(height: 10),
                
                Text(
                  AppLocalizations.of(context)!.signUpToContinue,
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
                
                const SizedBox(height: 20),
                
                // Confirm Password Input
                _buildConfirmPasswordField(),
                
                const SizedBox(height: 30),
                
                // Register Button
                _buildRegisterButton(),
                
                const SizedBox(height: 20),
                
                // Login Option
                Center(
                  child: CupertinoButton(
                    child: Text(
                      AppLocalizations.of(context)!.alreadyHaveAnAccount,
                      style: TextStyle(color: Color(0xFF7A7170)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
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
    bool isPassword = false,
  }) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      prefix: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Icon(prefixIcon, color: CupertinoColors.systemGrey),
      ),
      obscureText: isPassword ? _isObscured : false,
      style: const TextStyle(fontSize: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Widget _buildPasswordField() {
    return CupertinoTextField(
      controller: _passwordController,
      placeholder: AppLocalizations.of(context)!.password,
      prefix: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Icon(CupertinoIcons.lock, color: CupertinoColors.systemGrey),
      ),
      suffix: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
          child: Icon(
            _isObscured 
              ? CupertinoIcons.eye_slash 
              : CupertinoIcons.eye,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ),
      obscureText: _isObscured,
      style: const TextStyle(fontSize: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.5);
  }

  Widget _buildConfirmPasswordField() {
    return CupertinoTextField(
      controller: _confirmPasswordController,
      placeholder: AppLocalizations.of(context)!.confirmPassword,
      prefix: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Icon(CupertinoIcons.lock, color: CupertinoColors.systemGrey),
      ),
      suffix: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
          child: Icon(
            _isObscured 
              ? CupertinoIcons.eye_slash 
              : CupertinoIcons.eye,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ),
      obscureText: _isObscured,
      style: const TextStyle(fontSize: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.5);
  }

  Widget _buildRegisterButton() {
    return CupertinoButton.filled(
      borderRadius: BorderRadius.circular(12),
      onPressed: _handleRegistration,
      child: Center(
        child: _isLoading
            ? const CupertinoActivityIndicator(color: CupertinoColors.white)
            : Text(
                AppLocalizations.of(context)!.register,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    ).animate().fadeIn(duration: 600.ms).scaleXY(begin: 0.8);
  }
}