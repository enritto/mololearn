import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/course.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'course_detail_screen.dart';

class DashboardTab extends StatelessWidget {
  final List<Course> medicalCourses = [
    Course(
      id: '1',
      title: 'Основы кардиологии',
      description: 'Комплексный курс по основам кардиологии для начинающих специалистов',
      duration: '12 недель',
      materials: [
        'Анатомия сердца и сосудистой системы',
        'Основы ЭКГ диагностики',
        'Нарушения ритма сердца',
        'Ишемическая болезнь сердца',
        'Артериальная гипертензия',
        'Сердечная недостаточность',
        'Неотложные состояния в кардиологии',
        'Профилактическая кардиология'
      ],
      tests: [
        Test(
          title: 'Анатомия сердца',
          questions: 20,
          timeLimit: 30,
        ),
        Test(
          title: 'ЭКГ диагностика',
          questions: 25,
          timeLimit: 40,
        ),
        Test(
          title: 'Нарушения ритма',
          questions: 15,
          timeLimit: 25,
        ),
      ],
      exams: [
        Exam(
          title: 'Промежуточный экзамен',
          questions: 40,
          timeLimit: 60,
          passingScore: 75,
        ),
        Exam(
          title: 'Итоговый экзамен',
          questions: 80,
          timeLimit: 120,
          passingScore: 80,
        ),
      ],
      category: 'Кардиология',
      progress: 0.0,
      imageUrl: 'assets/images/cardiology.jpg',
    ),
    Course(
      id: '2',
      title: 'Анатомия человека',
      description: 'Фундаментальный курс по анатомии человека с практическими занятиями',
      duration: '16 недель',
      materials: [
        'Введение в анатомию',
        'Опорно-двигательный аппарат',
        'Миология',
        'Спланхнология',
        'Сердечно-сосудистая система',
        'Нервная система',
        'Органы чувств',
        'Эндокринная система',
        'Лимфатическая система',
        'Топографическая анатомия'
      ],
      tests: [
        Test(
          title: 'Опорно-двигательный аппарат',
          questions: 30,
          timeLimit: 45,
        ),
        Test(
          title: 'Внутренние органы',
          questions: 35,
          timeLimit: 50,
        ),
        Test(
          title: 'Нервная система',
          questions: 25,
          timeLimit: 40,
        ),
      ],
      exams: [
        Exam(
          title: 'Промежуточный экзамен 1',
          questions: 50,
          timeLimit: 75,
          passingScore: 70,
        ),
        Exam(
          title: 'Промежуточный экзамен 2',
          questions: 50,
          timeLimit: 75,
          passingScore: 70,
        ),
        Exam(
          title: 'Итоговый экзамен',
          questions: 100,
          timeLimit: 150,
          passingScore: 75,
        ),
      ],
      category: 'Анатомия',
      progress: 0.0,
      imageUrl: 'assets/images/anatomy.jpg',
    ),
  ];

  DashboardTab({super.key});

  void _navigateToCourse(BuildContext context, Course course) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => CourseDetailScreen(course: course),
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
        middle: Text(
          AppLocalizations.of(context)!.myCourses,
          style: const TextStyle(
            color: Color(0xFF7A7170),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.learning,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7A7170),
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: medicalCourses.length,
                itemBuilder: (context, index) {
                  final course = medicalCourses[index];
                  return _buildCourseCard(context, course);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    return GestureDetector(
      onTap: () => _navigateToCourse(context, course),
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7A7170).withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: -5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (course.imageUrl != null)
                  Expanded(
                    flex: 3,
                    child: Image.asset(
                      course.imageUrl!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7A7170),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          course.category,
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF7A7170).withOpacity(0.8),
                          ),
                        ),
                        const Spacer(),
                        LinearProgressIndicator(
                          value: course.progress,
                          backgroundColor: const Color(0xFF7A7170).withOpacity(0.1),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF8A65)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}