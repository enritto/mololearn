import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/course.dart';
import '../screens/main_screen.dart';
import '../utils/app_colors.dart';
class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF0F0F3),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFFF0F0F3).withOpacity(0.7),
        border: null,
        middle: Text(
          course.title,
          style: const TextStyle(
            color: AppColors.textPrimary,
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
              if (course.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    course.imageUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                course.description,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              _buildSection('Материалы курса', course.materials),
              const SizedBox(height: 16),
              _buildSection('Тесты', 
                course.tests.map((test) => '${test.title} (${test.questions} вопросов)').toList()
              ),
              const SizedBox(height: 16),
              _buildSection('Экзамены', 
                course.exams.map((exam) => 
                  '${exam.title} (${exam.questions} вопросов, проходной балл: ${exam.passingScore}%)'
                ).toList()
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.circle_fill,
                size: 8,
                color: AppColors.textPrimary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }
} 