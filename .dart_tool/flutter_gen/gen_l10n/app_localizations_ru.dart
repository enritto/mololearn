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

  @override
  String get coursesTab => 'Курсы';

  @override
  String get feedTab => 'Новости';

  @override
  String get profileTab => 'Профиль';

  @override
  String get profile => 'Профиль';

  @override
  String get edit => 'Изменить';

  @override
  String get save => 'Сохранить';

  @override
  String get enterYourSpecialty => 'Введите вашу специализацию';

  @override
  String get writeAboutYourself => 'Напишите что-нибудь о себе';

  @override
  String get coursesCompleted => 'Завершено\nкурсов';

  @override
  String get overallProgress => 'Общий\nпрогресс';

  @override
  String get certificatesEarned => 'Получено\nсертификатов';

  @override
  String get recentAchievements => 'Последние достижения';

  @override
  String get completeFirstCourse => 'Завершите первый курс, чтобы получить достижения!';

  @override
  String get myCourses => 'Мои курсы';

  @override
  String get cosmetologyBasics => 'Основы косметологии';

  @override
  String get cosmetologyDesc => 'Фундаментальные техники современной косметологии';

  @override
  String get medicalAnatomy => 'Медицинская анатомия';

  @override
  String get anatomyDesc => 'Детальная анатомия человека для медицинских работников';

  @override
  String get category => 'Категория';

  @override
  String get progress => 'Прогресс';

  @override
  String get latestNews => 'Последние новости';

  @override
  String get newAdvances => 'Новые достижения в косметологии';

  @override
  String get advancesDesc => 'Узнайте о последних трендах и техниках в области.';

  @override
  String get healthTips => 'Советы экспертов по здоровью';

  @override
  String get tipsDesc => 'Узнайте, как поддерживать здоровый образ жизни с советами экспертов.';

  @override
  String get currentCourses => 'Текущие курсы';

  @override
  String get achievements => 'Достижения';

  @override
  String get achievementFirstCourse => 'Первый курс пройден';

  @override
  String get achievementPerfectScore => 'Отличный результат';

  @override
  String get achievementEarlyBird => 'Ранняя пташка';

  @override
  String get logout => 'Выйти';

  @override
  String get editYourProfile => 'Редактирование профиля';

  @override
  String get photoUpdated => 'Фото успешно обновлено';

  @override
  String get failedToUpdatePhoto => 'Не удалось обновить фото';

  @override
  String get choosePhoto => 'Выбрать фото';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get removePhoto => 'Удалить фото';

  @override
  String get personalInfo => 'Личная информация';

  @override
  String get aboutMe => 'О себе';

  @override
  String memberSince(Object date) {
    return 'Участник с $date';
  }

  @override
  String get updateProfile => 'Обновить профиль';

  @override
  String get profileUpdated => 'Профиль успешно обновлен';

  @override
  String get failedToUpdateProfile => 'Не удалось обновить профиль';

  @override
  String get discardChanges => 'Отменить изменения?';

  @override
  String get discardChangesMessage => 'Вы уверены, что хотите отменить изменения?';

  @override
  String get discard => 'Отменить';

  @override
  String get keep => 'Продолжить редактирование';

  @override
  String get error => 'Ошибка';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get name => 'Имя';

  @override
  String get enterYourName => 'Введите ваше имя';

  @override
  String get specialty => 'Специальность';

  @override
  String get bio => 'О себе';

  @override
  String get logoutConfirmTitle => 'Подтверждение выхода';

  @override
  String get logoutConfirmMessage => 'Вы уверены, что хотите выйти?';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get learning => 'Обучение';

  @override
  String get news => 'Новости';

  @override
  String get medicalFaculty => 'Медицинский\nфакультет';

  @override
  String get anatomyFaculty => 'Анатомический\nфакультет';

  @override
  String get pharmacologyFaculty => 'Фармакологический\nфакультет';

  @override
  String videosWatched(Object count, Object total) {
    return 'Просмотрено видео: $count из $total';
  }

  @override
  String get watchMoreVideos => 'Чтобы увеличить прогресс, смотрите больше обучающих видео';
}
