// ignore: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_app/LoginPage/Dashboard/Attendence_perf.dart';
import 'package:student_app/LoginPage/Dashboard/FullWeekTimeTable.dart';
import 'package:student_app/LoginPage/Dashboard/TodayTimeTable.dart';
import 'TomorrowTimeTable.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  late String todayDate;
  late String todayDay;
  late String tomorrowDate;
  late String tomorrowDay;

  // 🎨 Professional Color Palette
  final Color primaryBlue = const Color(0xFF1565C0); // Deep blue for titles/icons
  final Color accentTeal = const Color(0xFF00897B); // Secondary accent for highlights
  final Color lightBg = const Color(0xFFF5F7FA); // Page background
  final Color cardTextColor = Colors.black87;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    todayDate = DateFormat('dd-MM-yyyy').format(now);
    todayDay = DateFormat('EEE').format(now).toUpperCase();

    final tomorrow = now.add(const Duration(days: 1));
    tomorrowDate = DateFormat('dd-MM-yyyy').format(tomorrow);
    tomorrowDay = DateFormat('EEE').format(tomorrow).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBg,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 57, 73, 171),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Icon(Icons.schedule, color: Colors.white, size: 26),
            const SizedBox(width: 8),
            const Text(
              "Time Table",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Info bar (Blue Gradient)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: const [
                  Icon(Icons.info_outline, color: Colors.white, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "To view your today's, tomorrow's, or full-week timetable, choose an option below.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Today card
            _buildDayCard(
              title: "Today's Time Table",
              day: todayDay,
              date: todayDate,
              dayColor: primaryBlue,
              iconColor: primaryBlue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TodaysTimetablePage(),
                  ),
                );
              },
            ),

            // Tomorrow card
            _buildDayCard(
              title: "Tomorrow's Time Table",
              day: tomorrowDay,
              date: tomorrowDate,
              dayColor: accentTeal,
              iconColor: accentTeal,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TomorrowsTimetablePage(),
                  ),
                );
              },
            ),

            // Full week card
            _buildIconCard(
              title: "Full Week Time Table",
              icon: Icons.table_chart_rounded,
              iconColor: primaryBlue,
              bgColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullWeekTimeTablePage(),
                  ),
                );
              },
            ),

            // Attendance Performance
            _buildIconCard(
              title: "Attendance Performance",
              icon: Icons.bar_chart_rounded,
              iconColor: const Color(0xFFEF6C00),
              bgColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendancePerformancePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // =============== Helper Cards ===============

  Widget _buildDayCard({
    required String title,
    required String day,
    required String date,
    required Color dayColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.black26,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Left Icon Box
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: dayColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calendar_today,
                  size: 30,
                  color: iconColor,
                ),
              ),

              const SizedBox(width: 14),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: cardTextColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.date_range,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          "$day - $date",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.black26,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: iconColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: cardTextColor,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
