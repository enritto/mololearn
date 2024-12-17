class Course {
  final String id;
  final String title;
  final String description;
  final String duration;
  final List<String> materials;
  final List<Test> tests;
  final List<Exam> exams;
  final String category;
  final double progress;
  final String? imageUrl;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.materials,
    required this.tests,
    required this.exams,
    this.category = '',
    this.progress = 0.0,
    this.imageUrl,
  });
}

class Test {
  final String title;
  final int questions;
  final int timeLimit;

  Test({
    required this.title,
    required this.questions,
    required this.timeLimit,
  });
}

class Exam {
  final String title;
  final int questions;
  final int timeLimit;
  final int passingScore;

  Exam({
    required this.title,
    required this.questions,
    required this.timeLimit,
    required this.passingScore,
  });
}