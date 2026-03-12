import 'dart:async';
import 'package:flutter/material.dart';
import 'package:student_app/LoginPage/Dashboard/AskMeAnything.dart';
import 'package:student_app/LoginPage/Dashboard/Assisment.dart';
import 'package:student_app/LoginPage/Dashboard/Document.dart';
import 'package:student_app/LoginPage/Dashboard/Drawer.dart';
import 'package:student_app/LoginPage/Dashboard/Examination.dart';
import 'package:student_app/LoginPage/Dashboard/FeeDetails.dart';
import 'package:student_app/LoginPage/Dashboard/Homework.dart';
import 'package:student_app/LoginPage/Dashboard/MySyllabus.dart';
import 'package:student_app/LoginPage/Dashboard/Notification.dart';
import 'package:student_app/LoginPage/Dashboard/OnlineExam.dart';
import 'package:student_app/LoginPage/Dashboard/SyllabusCover.dart';
import 'package:student_app/LoginPage/Dashboard/TimeTable.dart';
import 'package:student_app/LoginPage/Dashboard/statastic.dart';
import 'package:student_app/GlobalClasses/Glb.dart' as Glb;

// MAIN DASHBOARD SCREEN
class StudentDashboard1 extends StatefulWidget {
  const StudentDashboard1({super.key});

  @override
  State<StudentDashboard1> createState() => _StudentDashboard1State();
}

class _StudentDashboard1State extends State<StudentDashboard1> {
  int _notificationCount = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Load initial notification count
    _updateNotificationCount();
    // Auto-update notification count every 30 seconds
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _updateNotificationCount();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateNotificationCount() {
    setState(() {
      _notificationCount = Glb.nid_lst.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const StudentDrawer(),
      appBar: AppBar(
        title: const Text(
          "STUDENT APP",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(206, 31, 141, 237),
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          // ===== HEADER =====
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF00BCD4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // === Notification Icon ===
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyTodayNotifications(),
                          ),
                        );
                        _updateNotificationCount(); // Refresh count when returning
                      },
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.notifications_none,
                            size: 30,
                            color: Colors.black87,
                          ),
                          Positioned(
                            right: 0,
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: const Color(0xFFF7F8FC),
                              child: Text(
                                "$_notificationCount",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFFAB47BC),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    // === Profile Icon (with popup) ===
                    GestureDetector(
                      onTap: () {
                        _showSelectStudentPopup(context);
                      },
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Hello,",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  Glb.student_name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                // ===== INSTITUTE CARD WITH POPUP =====
                GestureDetector(
                  onTap: () {
                    _showInstitutePopup(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Text(
                            "LATEST DEMO INSTITUTE\n\nClick here to Switch Institute ->",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(Icons.account_balance,
                            size: 40, color: Color(0xFF1976D2)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ===== SCROLLABLE GRID =====
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 0.9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  buildMenuItem(
                      context: context,
                      icon: Icons.calendar_today,
                      title: "Time Table",
                      page: const TimeTablePage(),
                      color: const Color.fromRGBO(57, 73, 171, 1)),
                  buildMenuItem(
                      context: context,
                      icon: Icons.assignment,
                      title: "Examination",
                      page: const OfflineExamApp(),
                      color: Colors.deepOrange.shade700),
                  buildMenuItem(
                      context: context,
                      icon: Icons.book,
                      title: "Homework",
                      page: const HomeworkApp(),
                      color: const Color.fromRGBO(109, 76, 65, 1)),
                  buildMenuItem(
                      context: context,
                      icon: Icons.computer,
                      title: "Online Exam",
                      page: const OnlineExamScreen(),
                      color: Colors.blue.shade600),
                  buildMenuItem(
                      context: context,
                      icon: Icons.library_books,
                      title: "Digital Library",
                      page: const DummyPage(title: 'Digital Library'),
                      color: Colors.purple.shade600),
                  buildMenuItem(
                      context: context,
                      icon: Icons.school,
                      title: "Scholar",
                      page: const DummyPage(title: 'Scholar'),
                      color: Colors.amber.shade700),
                  buildMenuItem(
                      context: context,
                      icon: Icons.menu_book,
                      title: "My Syllabus",
                      page: const ViewTopicsScreen(),
                      color: const Color.fromARGB(255, 0, 121, 107)),
                  buildMenuItem(
                      context: context,
                      icon: Icons.attach_money,
                      title: "Fees Details",
                      page: const FeesDetailsScreen(),
                      color: Colors.green.shade700),
                  buildMenuItem(
                      context: context,
                      icon: Icons.checklist,
                      title: "Assessments",
                      page: const AssessmentScreen(),
                      color: Colors.red.shade600),
                  buildMenuItem(
                      context: context,
                      icon: Icons.work,
                      title: "Placement",
                      page: const DummyPage(title: 'Placement'),
                      color: Colors.blueGrey.shade800),
                  buildMenuItem(
                      context: context,
                      icon: Icons.list_alt,
                      title: "Syllabus Cover",
                      page: const SyllabusCoveragePage(),
                      color: Colors.cyan.shade600),
                  buildMenuItem(
                      context: context,
                      icon: Icons.directions_bus,
                      title: "Bus Status",
                      page: const DummyPage(title: 'Bus Status'),
                      color: Colors.orange.shade700),
                  buildMenuItem(
                      context: context,
                      icon: Icons.cloud,
                      title: "Document\nManagement",
                      page: const StudentDocumentPage(),
                      color: const Color.fromARGB(255, 3, 169, 244)),
                  buildMenuItem(
                      context: context,
                      icon: Icons.question_answer,
                      title: "Ask me anything",
                      page: const AIIntegratedPage(),
                      color: const Color.fromARGB(255, 236, 64, 122)),
                  buildMenuItem(
                      context: context,
                      icon: Icons.bar_chart,
                      title: "Statistics",
                      page: const StudentDashboard(),
                      color: Colors.grey.shade900),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ====== Menu Card Widget ======
  Widget buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Widget page,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => page));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 35, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== POPUP FUNCTIONS ======
  void _showInstitutePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF9FAFB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        titlePadding: const EdgeInsets.only(top: 20),
        title: const Center(
          child: Text(
            "Select Institute",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF1A237E),
                letterSpacing: 0.5),
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(color: Color(0xFFBDBDBD), thickness: 1),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      backgroundColor: Color(0xFF1976D2),
                      content: Text("✅ LATEST DEMO INSTITUTE selected",
                          style: TextStyle(color: Colors.white))),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3))
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF1976D2),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.account_balance,
                          color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "LATEST DEMO INSTITUTE\nClass: 1 (A)",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded, color: Colors.white),
              label: const Text(
                "Close",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                elevation: 2,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _showSelectStudentPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF9FAFB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        titlePadding: const EdgeInsets.only(top: 20),
        title: const Center(
          child: Text(
            "Select Student",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF1A237E),
                letterSpacing: 0.5),
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(color: Color(0xFFBDBDBD), thickness: 1),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF1976D2),
                    content: Text(
                      Glb.student_name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3))
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF1976D2),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        Glb.student_name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded, color: Colors.white),
              label: const Text(
                "Close",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                elevation: 2,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
