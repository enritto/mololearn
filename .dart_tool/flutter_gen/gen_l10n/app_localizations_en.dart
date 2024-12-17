import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeBack => 'Welcome to Mololearn';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Log in';

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

  @override
  String get coursesTab => 'Courses';

  @override
  String get feedTab => 'Feed';

  @override
  String get profileTab => 'Profile';

  @override
  String get profile => 'Profile';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String get enterYourSpecialty => 'Enter your specialty';

  @override
  String get writeAboutYourself => 'Write something about yourself';

  @override
  String get coursesCompleted => 'Courses\nCompleted';

  @override
  String get overallProgress => 'Overall\nProgress';

  @override
  String get certificatesEarned => 'Certificates\nEarned';

  @override
  String get recentAchievements => 'Recent Achievements';

  @override
  String get completeFirstCourse => 'Complete your first course to earn achievements!';

  @override
  String get myCourses => 'My Courses';

  @override
  String get cosmetologyBasics => 'Cosmetology Basics';

  @override
  String get cosmetologyDesc => 'Fundamental techniques in modern cosmetology';

  @override
  String get medicalAnatomy => 'Medical Anatomy';

  @override
  String get anatomyDesc => 'Detailed human anatomy for medical professionals';

  @override
  String get category => 'Category';

  @override
  String get progress => 'Progress';

  @override
  String get latestNews => 'Latest News';

  @override
  String get newAdvances => 'New Advances in Cosmetology';

  @override
  String get advancesDesc => 'Discover the latest trends and techniques in the field.';

  @override
  String get healthTips => 'Health Tips from Experts';

  @override
  String get tipsDesc => 'Learn how to maintain a healthy lifestyle with expert advice.';

  @override
  String get currentCourses => 'Current Courses';

  @override
  String get achievements => 'Achievements';

  @override
  String get achievementFirstCourse => 'First Course Completed';

  @override
  String get achievementPerfectScore => 'Perfect Score';

  @override
  String get achievementEarlyBird => 'Early Bird';

  @override
  String get logout => 'Log Out';

  @override
  String get editYourProfile => 'Edit Your Profile';

  @override
  String get photoUpdated => 'Photo updated successfully';

  @override
  String get failedToUpdatePhoto => 'Failed to update photo';

  @override
  String get choosePhoto => 'Choose photo';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get personalInfo => 'Personal Information';

  @override
  String get aboutMe => 'About Me';

  @override
  String memberSince(Object date) {
    return 'Member since $date';
  }

  @override
  String get updateProfile => 'Update Profile';

  @override
  String get profileUpdated => 'Profile updated successfully';

  @override
  String get failedToUpdateProfile => 'Failed to update profile';

  @override
  String get discardChanges => 'Discard changes?';

  @override
  String get discardChangesMessage => 'Are you sure you want to discard your changes?';

  @override
  String get discard => 'Discard';

  @override
  String get keep => 'Keep editing';

  @override
  String get error => 'Error';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get name => 'Name';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get specialty => 'Specialty';

  @override
  String get bio => 'Bio';

  @override
  String get logoutConfirmTitle => 'Confirm Logout';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get learning => 'Learning';

  @override
  String get news => 'News';

  @override
  String get medicalFaculty => 'Medical\nFaculty';

  @override
  String get anatomyFaculty => 'Anatomy\nFaculty';

  @override
  String get pharmacologyFaculty => 'Pharmacology\nFaculty';

  @override
  String videosWatched(Object count, Object total) {
    return 'Videos watched: $count of $total';
  }

  @override
  String get watchMoreVideos => 'To increase progress, watch more educational videos';
}
