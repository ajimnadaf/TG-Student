// ignore: file_names
import 'package:flutter/material.dart';
import 'package:student_app/LoginPage/Dashboard/Avg_marks.dart';
import 'package:student_app/LoginPage/Dashboard/MarksRep.dart';
import 'package:student_app/LoginPage/Dashboard/Exam_perf.dart';
import 'package:student_app/LoginPage/Dashboard/HomePage.dart';

// ---------------------
// Subject Model
// ---------------------
class Subject {
  final String name;
  final IconData icon;
  final Color color;
  final Color headerColor;

  const Subject(this.name, this.icon, this.color, this.headerColor);
}

void main() {
  runApp(const OfflineExamApp());
}

class OfflineExamApp extends StatelessWidget {
  const OfflineExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OfflineExamScreen(),
    );
  }
}

// ---------------------
// Offline Exam Screen
// ---------------------
class OfflineExamScreen extends StatefulWidget {
  const OfflineExamScreen({super.key});

  @override
  State<OfflineExamScreen> createState() => _OfflineExamScreenState();
}

class _OfflineExamScreenState extends State<OfflineExamScreen> {
  final List<Subject> availableSubjects = const [
    Subject("ENGLISH", Icons.menu_book_rounded, Color(0xFF1976D2), Color(0xFF42A5F5)),
    Subject("MATHEMATICS", Icons.calculate_rounded, Color(0xFFD32F2F), Color(0xFFFF7043)),
    Subject("SCIENCE", Icons.science_rounded, Color(0xFF2E7D32), Color(0xFF66BB6A)),
    Subject("HISTORY", Icons.museum_rounded, Color(0xFF6A1B9A), Color(0xFFAB47BC)),
    Subject("GEOGRAPHY", Icons.public_rounded, Color(0xFF0288D1), Color(0xFF26C6DA)),
    Subject("COMPUTER SCIENCE", Icons.computer_rounded, Color(0xFF512DA8), Color(0xFF7E57C2)),
  ];

  late Subject _selectedSubject;

  @override
  void initState() {
    super.initState();
    _selectedSubject = availableSubjects.first;
  }

  // --------------------- Subject Popup ---------------------
  void _showSubjectPopup() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: Column(
            children: [
              const Text(
                "Select Subject",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: availableSubjects.length,
                  itemBuilder: (context, index) {
                    final subject = availableSubjects[index];
                    final isSelected = _selectedSubject.name == subject.name;
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        setState(() => _selectedSubject = subject);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? subject.headerColor.withOpacity(0.1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(subject.icon, color: subject.color, size: 32),
                            const SizedBox(width: 14),
                            Text(
                              subject.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? subject.color : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
            ],
          ),
        ),
      ),
    );
  }

// --------------------- Marks Options Popup ---------------------
void _showMarksOptionsPopup() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "SELECT SUBJECT TO GET MARKS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 15),

            // --- 1️⃣ Subject-wise Chart ---
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExamPerformanceChart(
                      subject: _selectedSubject,
                      isAverage: false, // subject-wise marks
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.menu_book, color: Colors.blue.shade700, size: 40),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "${_selectedSubject.name} MARKS IN ALL EXAMS",
                      style: TextStyle(fontSize: 14, color: Colors.grey[800], fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // --- 2️⃣ Average Chart ---
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AvgPercentageChart(
                      subject: _selectedSubject,
                      isAverage: true, // ✅ opens average marks page
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.stacked_bar_chart, color: Colors.teal.shade700, size: 40),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "AVG. % OF ALL SUBJECTS IN ALL EXAMS",
                      style: TextStyle(fontSize: 14, color: Colors.grey[800], fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}



  // --------------------- UI ---------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 67, 43),
        elevation: 1,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const StudentDashboard1()),
                );
              },
            ),
            const SizedBox(width: 5),
            const Text(
              'OFFLINE EXAM',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart, color:Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConsolidatedMarksReport(subject: _selectedSubject.name),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.pie_chart, color:Colors.white),
            onPressed: _showMarksOptionsPopup,
          ),
        ],
      ),

      // --------------------- BODY ---------------------
      body: Column(
        children: [
          GestureDetector(
            onTap: _showSubjectPopup,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_selectedSubject.headerColor, _selectedSubject.color],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  Icon(_selectedSubject.icon, color: Colors.white, size: 42),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedSubject.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Tap to change subject",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "${_selectedSubject.name} Content Area",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
