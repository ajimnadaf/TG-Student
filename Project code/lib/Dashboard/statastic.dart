import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:student_app/GlobalClasses/Glb.dart' as Glb;
import 'package:student_app/LoginPage/Dashboard/MarksRep.dart';
import 'package:student_app/LoginPage/Dashboard/social_skill.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title:const Text(
          " STUDENT",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Color.fromARGB(206, 31, 141, 237),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // 🔶 Top Student Card
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              color: Color.fromARGB(206, 31, 141, 237),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "LATEST DEMO INSTITUTE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          Glb.student_name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "CLASS 1(A)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _showSelectStudentPopup(context); // ← your popup function
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          

          // 🔶 Scrollable Cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                buildInfoCard(
                  icon: Icons.directions_bus,
                  iconColor: Colors.orange,
                  title: 'Bus Location',
                  subtitle: 'Current Location: Not Available',
                  onTap: () {},
                ),
                const SizedBox(height: 15),

                buildAttendanceCard(),
                const SizedBox(height: 15),

                // ✅ Exam Performance card
                buildInfoCard(
                  icon: Icons.assessment,
                  iconColor: Colors.green,
                  title: 'Exam Performance',
                  subtitle: 'Click here to view exam summary.',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ConsolidatedMarksReport(subject: "ENGLISH"),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),

                buildInfoCard(
                  icon: Icons.book,
                  iconColor: Colors.blue,
                  title: 'Homework',
                  subtitle: 'Click here to view Home Work.',
                  onTap: () {
                    _showHomeworkPopup(context);
                  },
                ),
                const SizedBox(height: 15),

                buildInfoCard(
                  icon: Icons.money,
                  iconColor: const Color.fromARGB(255, 184, 33, 243),
                  title: 'Fee Details',
                  subtitle: 'Click here to view Fee Details.',
                  onTap: () {
                    _showFeesDetailsPopup(context);
                  },
                ),
                const SizedBox(height: 15),

                // ✅ Social Skills
                buildInfoCard(
                  icon: Icons.psychology_outlined, // Modern icon
                  iconColor: const Color(0xFF1E3A8A), // Deep Blue color
                  title: 'Social Skills',
                  subtitle: 'Help Your Child Grow!',
                  isGradient: true, // Gradient property add ki hai niche
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DailyStudentReportPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),

                // ✅ Borrowed Books Popup
                buildInfoCard(
                  icon: Icons.library_books,
                  iconColor: const Color.fromARGB(255, 243, 33, 89),
                  title: 'Borrowed Books From Library',
                  subtitle:
                      'Total Borrowed Books: \nFine Per day: \nTotal Fine:',
                  onTap: () {
                    showBorrowedBooksPopup(context);
                  },
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔸 Reusable Info Card Widget
  Widget buildInfoCard({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  bool isGradient = false, // Naya parameter
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4), // Spacing
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            // Agar social skills hai toh halka gradient background
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: isGradient 
                ? LinearGradient(
                    colors: [Colors.white, Color(0xFFF1F5F9)], // Sublte consistency
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Icon Container
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isGradient ? const Color(0xFF1E3A8A).withOpacity(0.1) : iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 30, color: isGradient ? const Color(0xFF1E3A8A) : iconColor),
                ),
                const SizedBox(width: 16),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B), // Dark blue-grey text
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔸 Attendance Card Widget
  Widget buildAttendanceCard() {
  return GestureDetector(
    onTap: () {
      _showAttendancePopup(context); 
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.verified_user, size: 40, color: Colors.red),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Attendance Performance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text("Click here to view Attendance.",
                      style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  // 🔸 Borrowed Books Popup
  void showBorrowedBooksPopup(BuildContext context) {
    final borrowedBooks = [
      {
        "title": "Physics",
        "accNo": "1224567",
        "author": "Dr. A. Einstein",
        "edition": "10th",
        "issueDate": "13-Oct-2025",
        "returnDate": "20-Oct-2025",
        "fine": "₹10"
      },
      {
        "title": "Chemistry",
        "accNo": "7654321",
        "author": "Marie Curie",
        "edition": "8th",
        "issueDate": "10-Oct-2025",
        "returnDate": "18-Oct-2025",
        "fine": "₹0"
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Borrowed Books",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 0, 72),
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: borrowedBooks.length,
            itemBuilder: (context, index) {
              final book = borrowedBooks[index];
              return Card(
                color: Colors.orange[50],
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.book, color: Colors.orange),
                  title: Text(
                    book["title"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Acc No: ${book["accNo"]}\n"
                    "Author: ${book["author"]}\n"
                    "Edition: ${book["edition"]}\n"
                    "Issue Date: ${book["issueDate"]}\n"
                    "Return Date: ${book["returnDate"]}\n"
                    "Fine: ${book["fine"]}",
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Close",
              style: TextStyle(color:Color.fromARGB(255, 255, 0, 72)),
            ),
          ),
        ],
      ),
    );
  }
}

  // ===== POPUP FUNCTION (STUDENT SELECT) ======
  void _showSelectStudentPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF9FAFB), // Soft modern background
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        titlePadding: const EdgeInsets.only(top: 20),
        title: const Center(
          child: Text(
            "Select Student",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF1A237E), // Deep Indigo title color
              letterSpacing: 0.5,
            ),
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              color: Color(0xFFBDBDBD),
              thickness: 1,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Color(0xFF1976D2),
                    content: Text(
                      Glb.student_name,
                      style: TextStyle(color: Colors.white),
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
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF1976D2), // Professional blue circle
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
                backgroundColor:
                    const Color(0xFF1976D2), // Deep professional blue
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

// ===== FEES DETAILS POPUP =====
void _showFeesDetailsPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      title: const Center(
        child: Text(
          "Fee Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF4A148C),
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(color: Colors.grey, thickness: 1),

          const SizedBox(height: 10),

          _feeRow("Total Fee", "₹15,700.00"),
          const SizedBox(height: 8),

          _feeRow("Paid Amount", "₹10,000.00"),
          const SizedBox(height: 8),

          _feeRow("Remaining", "₹5,700.00"),
          const SizedBox(height: 8),

          _feeRow("Last Paid Date", "12-Nov-2025"),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _showPaymentPopup(context);
            },
            icon: const Icon(Icons.payment, color: Colors.white),
            label: const Text(
              "Pay Now",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4A148C),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Close",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF4A148C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}

void _showPaymentPopup(BuildContext context) {
}

// Reusable Row Widget
Widget _feeRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    ],
  );
}

// ===== HOMEWORK POPUP =====
void _showHomeworkPopup(BuildContext context) {
  final homeworkList = [
    {
      "subject": "English",
      "date": "18-Nov-2025",
      "details": "Write a paragraph on 'My Best Friend'."
    },
    {
      "subject": "Maths",
      "date": "18-Nov-2025",
      "details": "Solve Exercise 5.2 (Q1 - Q10)."
    },
    {
      "subject": "Science",
      "date": "17-Nov-2025",
      "details": "Draw the diagram of the Water Cycle."
    },
  ];

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      title: const Center(
        child: Text(
          "Homework Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF1565C0),
          ),
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: homeworkList.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    "No Homework Assigned.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: homeworkList.length,
                itemBuilder: (context, index) {
                  final hw = homeworkList[index];

                  return Card(
                    elevation: 2,
                    color: Colors.blue[50],
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.book_outlined,
                          size: 35, color: Color(0xFF1565C0)),
                      title: Text(
                        hw["subject"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        "Date: ${hw["date"]}\n"
                        "Homework: ${hw["details"]}",
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Close",
              style: TextStyle(
                color: Color(0xFF1565C0),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}


// ===== ATTENDANCE PERFORMANCE POPUP =====
void _showAttendancePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      titlePadding: const EdgeInsets.only(top: 20),
      title: const Center(
        child: Text(
          "Attendance Performance",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Color(0xFF1565C0), // Professional blue
          ),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(color: Colors.grey),

          const SizedBox(height: 15),

          // Today's Attendance
          _attendanceItem(
            label: "Today's Attendance",
            value: "Not Taken",
            icon: Icons.today,
            iconColor: Colors.deepPurple,
          ),

          const SizedBox(height: 15),

          // Last 7 Days
          _attendanceItem(
            label: "Last 7 Days",
            value: "Not Taken",
            icon: Icons.calendar_today,
            iconColor: Colors.green,
          ),

          const SizedBox(height: 15),

          // Till Date
          _attendanceItem(
            label: "Till Date Attendance",
            value: "0 / 1",
            icon: Icons.check_circle,
            iconColor: Colors.orange,
          ),

          const SizedBox(height: 15),
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.white),
            label: const Text(
              "Close",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1565C0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}

// Reusable Attendance Row
Widget _attendanceItem({
  required String label,
  required String value,
  required IconData icon,
  required Color iconColor,
}) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 28),
      ),
      const SizedBox(width: 15),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
