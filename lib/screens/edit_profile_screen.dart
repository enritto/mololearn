import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../models/user_profile.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile userProfile;
  final Function(UserProfile) onProfileUpdated;

  const EditProfileScreen({
    Key? key,
    required this.userProfile,
    required this.onProfileUpdated,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _specialtyController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userProfile.name);
    _bioController = TextEditingController(text: widget.userProfile.bio);
    _specialtyController = TextEditingController(text: widget.userProfile.specialty);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _specialtyController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    setState(() => _isLoading = true);

    try {
      // Создаем обновленный профиль
      final updatedProfile = UserProfile(
        uid: widget.userProfile.uid,
        name: _nameController.text.trim(),
        email: widget.userProfile.email,
        bio: _bioController.text.trim(),
        specialty: _specialtyController.text.trim(),
        profilePicture: widget.userProfile.profilePicture,
        joinDate: widget.userProfile.joinDate,
        coursesCompleted: widget.userProfile.coursesCompleted,
        overallProgress: widget.userProfile.overallProgress,
        certificatesEarned: widget.userProfile.certificatesEarned,
        achievements: widget.userProfile.achievements,
        currentCourses: widget.userProfile.currentCourses,
        courseProgress: widget.userProfile.courseProgress,
      );

      // Вызываем колбэк для обновления профиля
      widget.onProfileUpdated(updatedProfile);

      // Возвращаемся назад
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(AppLocalizations.of(context)!.error),
            content: Text(e.toString()),
            actions: [
              CupertinoDialogAction(
                child: Text(AppLocalizations.of(context)!.ok),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF8F0E6),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFFF8F0E6).withOpacity(0.7),
        border: null,
        middle: Text(
          AppLocalizations.of(context)!.editProfile,
          style: const TextStyle(
            color: Color(0xFF7A7170),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(
            CupertinoIcons.back,
            color: AppColors.primaryColor,
          ),
        ),
        trailing: _isLoading
            ? const CupertinoActivityIndicator()
            : CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _saveChanges,
                child: Text(
                  AppLocalizations.of(context)!.save,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Фото профиля
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textPrimary.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          widget.userProfile.profilePicture,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CupertinoButton(
                        padding: const EdgeInsets.all(8),
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        onPressed: () {
                          // TODO: Добавить функционал изменения фото
                        },
                        child: const Icon(
                          CupertinoIcons.camera_fill,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Имя
              Text(
                AppLocalizations.of(context)!.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7A7170),
                ),
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: _nameController,
                padding: const EdgeInsets.all(16),
                placeholder: AppLocalizations.of(context)!.enterYourName,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF7A7170).withOpacity(0.2),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Специальность
              Text(
                AppLocalizations.of(context)!.specialty,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7A7170),
                ),
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: _specialtyController,
                padding: const EdgeInsets.all(16),
                placeholder: AppLocalizations.of(context)!.enterYourSpecialty,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF7A7170).withOpacity(0.2),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Био
              Text(
                AppLocalizations.of(context)!.bio,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7A7170),
                ),
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: _bioController,
                padding: const EdgeInsets.all(16),
                placeholder: AppLocalizations.of(context)!.writeAboutYourself,
                maxLines: 4,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF7A7170).withOpacity(0.2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
