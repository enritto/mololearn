import 'package:flutter/cupertino.dart';
import '../models/course.dart';
import '../utils/app_colors.dart';

class DashboardTab extends StatelessWidget {
  final List<Course> courses = [
    Course(
      title: 'Cosmetology Basics',
      description: 'Fundamental techniques in modern cosmetology',
      category: 'Cosmetology',
      progress: 0.6,
      imageUrl: 'assets/cosmeto.jpg',
    ),
    Course(
      title: 'Medical Anatomy',
      description: 'Detailed human anatomy for medical professionals',
      category: 'Medicine',
      progress: 0.4,
      imageUrl: 'assets/anatomy.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('My Courses', 
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: 
                [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(course.imageUrl, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          course.description,
                          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}