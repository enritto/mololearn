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
      title: 'Изучение консультативного приема в клинике',
      description: 'Курс о первичной консультации от Лесниковой АШ',
      duration: '1 неделя',
      materials: [
        'Статья о первичной консультации',
        'Видеоролик с первичной консультации пациента',
        'Памятка с картинками',
      ],
      tests: [
        Test(
          title: 'Тестирование',
          questions: 10,
          timeLimit: 15,
        ),
      ],
      exams: [],
      category: 'Врачи',
      progress: 0.0,
      imageUrl: 'assets/images/consultation.jpg',
    ),
    Course(
      id: '2',
      title: 'Изучение консультативного приема 3.0 (Дерматология)',
      description: 'Курс по дерматологии с клиническими рекомендациями',
      duration: '2 недели',
      materials: [
        'Клинические рекомендации',
        'Обучающая презентация по акне',
        'Обучающая презентация по розацеа',
        'Видео с консультации по акне/розацеа',
        'Протокол консультирования акне и розацеа (4 файла)',
      ],
      tests: [
        Test(
          title: 'Тестирование',
          questions: 15,
          timeLimit: 20,
        ),
      ],
      exams: [],
      category: 'Врачи',
      progress: 0.0,
      imageUrl: 'assets/images/dermatology.jpg',
    ),
    Course(
      id: '3',
      title: 'Аппаратные методики',
      description: 'Курс по аппаратным методикам',
      duration: '3 недели',
      materials: [
        'Candela Nordlys (обучающее видео и тестирование)',
        'DEKA СО-2 лазер (обучающее видео и тестирование)',
        'InMode Morpheus-8 (обучающее видео и тестирование)',
        'InMode Diolaze (обучающее видео и тестирование)',
        'InMode Forma (обучающее видео и тестирование)',
        'Ultraformer MPT-4 (обучающее видео и тестирование)',
        'Криолифтинг (обучающее видео и тестирование)',
        'Микротоки (обучающее видео и тестирование)',
        'ФДТ Revixan (обучающее видео и тестирование)',
      ],
      tests: [],
      exams: [],
      category: 'Врачи',
      progress: 0.0,
      imageUrl: 'assets/images/hardware_techniques.jpg',
    ),
    Course(
      id: '4',
      title: 'Инъекционные методики',
      description: 'Курс по инъекционным методикам',
      duration: '2 недели',
      materials: [
        'БТА',
        'Филлеры',
        'Коллаген Стимуляторы',
        'Биоревитализанты',
        'Плазмотерапия',
      ],
      tests: [],
      exams: [],
      category: 'Врачи',
      progress: 0.0,
      imageUrl: 'assets/images/injection_techniques.jpg',
    ),
    Course(
      id: '5',
      title: 'Уходо����ые и эстетические процедуры',
      description: 'Курс по уходовым и эстетическим процедурам',
      duration: '2 недели',
      materials: [
        'Пилинги',
        'Чистка лица',
      ],
      tests: [],
      exams: [],
      category: 'Врачи',
      progress: 0.0,
      imageUrl: 'assets/images/cosmetic_procedures.jpg',
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

  // Неоморфное оформление
  BoxDecoration _neomorphicDecoration({
    BorderRadius? borderRadius,
    bool isPressed = false,
  }) {
    return BoxDecoration(
      color: const Color(0xFFF0F0F3),
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      boxShadow: isPressed
          ? null
          : [
              BoxShadow(
                color: const Color(0xFFA0A0A4).withOpacity(0.2),
                offset: const Offset(4, 6),
                blurRadius: 8,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.7),
                offset: const Offset(-4, -6),
                blurRadius: 8,
                spreadRadius: 2,
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
        decoration: _neomorphicDecoration(
          borderRadius: BorderRadius.circular(12),
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