import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get welcomeBack => 'Добро пожаловать в Mololearn';

  @override
  String get signInToContinue => 'Войдите, чтобы продолжить';

  @override
  String get email => 'Электронная почта';

  @override
  String get password => 'Пароль';

  @override
  String get login => 'Войти';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get loginError => 'Ошибка входа';

  @override
  String get ok => 'ОК';

  @override
  String get pleaseEnterEmail => 'Пожалуйста, введите электронную почту';

  @override
  String get pleaseEnterBothEmailAndPassword => 'Пожалуйста, введите почту и пароль';

  @override
  String get loginFailed => 'Не удалось войти';

  @override
  String get noUserFound => 'Пользователь с такой почтой не найден';

  @override
  String get incorrectPassword => 'Неверный пароль';

  @override
  String get tooManyLoginAttempts => 'Слишком много попыток входа. Попробуйте позже.';

  @override
  String get unexpectedError => 'Произошла непредвиденная ошибка';

  @override
  String get passwordReset => 'Сброс пароля';

  @override
  String get passwordResetLinkSent => 'Ссылка для сброса пароля отправлена на вашу почту';

  @override
  String get failedToSendPasswordReset => 'Не удалось отправить письмо для сброса пароля';

  @override
  String get pleaseVerifyEmail => 'Пожалуйста, подтвердите вашу электронную почту перед входом';

  @override
  String get createYourAccount => 'Создайте свой аккаунт';

  @override
  String get signUpToContinue => 'Зарегистрируйтесь, чтобы продолжить';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get register => 'Зарегистрироваться';

  @override
  String get alreadyHaveAnAccount => 'Уже есть аккаунт? Войти';

  @override
  String get registrationError => 'Ошибка регистрации';

  @override
  String get registrationFailed => 'Не удалось зарегистрироваться';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get passwordTooWeak => 'Пароль слишком простой';

  @override
  String get emailAlreadyInUse => 'Учетная запись с этой почтой уже существует';

  @override
  String get verifyEmail => 'Подтвердить почту';

  @override
  String get verifyYourEmail => 'Подтвердите вашу почту';

  @override
  String verificationEmailSent(Object email) {
    return 'Мы отправили письмо для подтверждения на $email. Пожалуйста, проверьте входящие и перейдите по ссылке.';
  }

  @override
  String get iHaveVerifiedMyEmail => 'Я подтвердил почту';

  @override
  String get resendVerificationEmail => 'Отправить письмо повторно';

  @override
  String get verificationEmailResent => 'Письмо для подтверждения отправлено повторно';

  @override
  String get failedToResendVerificationEmail => 'Не удалось отправить письмо для подтверждения';

  @override
  String get success => 'Успешно';
}
