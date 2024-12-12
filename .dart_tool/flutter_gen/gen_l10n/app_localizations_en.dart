import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeBack => 'Welcome Back to MoloLearn';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get createAccount => 'Create an Account';

  @override
  String get loginError => 'Login Error';

  @override
  String get ok => 'OK';

  @override
  String get pleaseEnterEmail => 'Please enter your email';

  @override
  String get pleaseEnterBothEmailAndPassword => 'Please enter both email and password';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get noUserFound => 'No user found with this email';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get tooManyLoginAttempts => 'Too many login attempts. Please try again later.';

  @override
  String get unexpectedError => 'An unexpected error occurred';

  @override
  String get passwordReset => 'Password Reset';

  @override
  String get passwordResetLinkSent => 'Password reset link has been sent to your email';

  @override
  String get failedToSendPasswordReset => 'Failed to send password reset email';

  @override
  String get pleaseVerifyEmail => 'Please verify your email before logging in';

  @override
  String get createYourAccount => 'Create Your Account';

  @override
  String get signUpToContinue => 'Sign up to continue';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get register => 'Register';

  @override
  String get alreadyHaveAnAccount => 'Already have an account? Login';

  @override
  String get registrationError => 'Registration Error';

  @override
  String get registrationFailed => 'Registration failed';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordTooWeak => 'The password is too weak';

  @override
  String get emailAlreadyInUse => 'An account already exists with this email';

  @override
  String get verifyEmail => 'Verify Email';

  @override
  String get verifyYourEmail => 'Verify Your Email';

  @override
  String verificationEmailSent(Object email) {
    return 'We have sent a verification email to $email. Please check your inbox and click the verification link.';
  }

  @override
  String get iHaveVerifiedMyEmail => 'I have verified my email';

  @override
  String get resendVerificationEmail => 'Resend Verification Email';

  @override
  String get verificationEmailResent => 'Verification email resent';

  @override
  String get failedToResendVerificationEmail => 'Failed to resend verification email';

  @override
  String get success => 'Success';
}
