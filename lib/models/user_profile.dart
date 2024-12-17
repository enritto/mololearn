class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String bio;
  final String specialty;
  final String profilePicture;
  final DateTime joinDate;
  final int coursesCompleted;
  final double overallProgress;
  final int certificatesEarned;
  final List<String> achievements;
  final List<String> currentCourses;
  final Map<String, double> courseProgress;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    this.bio = '',
    this.specialty = '',
    required this.profilePicture,
    required this.joinDate,
    this.coursesCompleted = 0,
    this.overallProgress = 0.0,
    this.certificatesEarned = 0,
    this.achievements = const [],
    this.currentCourses = const [],
    this.courseProgress = const {},
  });

  UserProfile copyWith({
    String? bio,
    String? specialty,
    String? profilePicture,
    int? coursesCompleted,
    double? overallProgress,
    int? certificatesEarned,
    List<String>? achievements,
    List<String>? currentCourses,
    Map<String, double>? courseProgress,
  }) {
    return UserProfile(
      uid: uid,
      name: name,
      email: email,
      bio: bio ?? this.bio,
      specialty: specialty ?? this.specialty,
      profilePicture: profilePicture ?? this.profilePicture,
      joinDate: joinDate,
      coursesCompleted: coursesCompleted ?? this.coursesCompleted,
      overallProgress: overallProgress ?? this.overallProgress,
      certificatesEarned: certificatesEarned ?? this.certificatesEarned,
      achievements: achievements ?? this.achievements,
      currentCourses: currentCourses ?? this.currentCourses,
      courseProgress: courseProgress ?? this.courseProgress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'bio': bio,
      'specialty': specialty,
      'profilePicture': profilePicture,
      'joinDate': joinDate.toIso8601String(),
      'coursesCompleted': coursesCompleted,
      'overallProgress': overallProgress,
      'certificatesEarned': certificatesEarned,
      'achievements': achievements,
      'currentCourses': currentCourses,
      'courseProgress': courseProgress,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      specialty: json['specialty'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      joinDate: json['joinDate'] != null 
          ? DateTime.parse(json['joinDate']) 
          : DateTime.now(),
      coursesCompleted: json['coursesCompleted'] ?? 0,
      overallProgress: json['overallProgress']?.toDouble() ?? 0.0,
      certificatesEarned: json['certificatesEarned'] ?? 0,
      achievements: List<String>.from(json['achievements'] ?? []),
      currentCourses: List<String>.from(json['currentCourses'] ?? []),
      courseProgress: Map<String, double>.from(json['courseProgress'] ?? {}),
    );
  }
}