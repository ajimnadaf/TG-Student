import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:student_app/LoginPage/Dashboard/Examination.dart'; // for Subject class

// --- 1. Data Structure ---
class ExamData {
  final double x;
  final double y;
  final String label;

  ExamData(this.x, this.y, this.label);
}

// --- 2. Main Chart Widget ---
class ExamPerformanceChart extends StatefulWidget {
  final Subject subject;

  const ExamPerformanceChart({
    super.key,
    required this.subject,
    required bool isAverage,
  });

  @override
  State<ExamPerformanceChart> createState() => _ExamPerformanceChartState();
}

class _ExamPerformanceChartState extends State<ExamPerformanceChart> {
  // Mock Data Points
  final List<ExamData> examPoints = [
    ExamData(0.0, 80.0, 'FA-1'),
    ExamData(0.9, 30.0, 'FA-2'),
    ExamData(1.8, 40.0, 'FA-3'),
  ];

  final double upperLimit = 100.0;
  final double lowerLimit = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ✅ Gradient Header with Back Arrow
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [widget.subject.headerColor, widget.subject.color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // ✅ White Back Arrow
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Icon(widget.subject.icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              widget.subject.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: LineChart(mainData()),
            ),
            const SizedBox(height: 30),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'EXAM PERFORMANCE - ${widget.subject.name}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // --- ✅ Centered Button + Text ---
  Widget _buildLegend() {
    return Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.subject.color,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
            ),
            child: const Text(
              'VIEW MARKS',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Online Exam Percentage',
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 40,
        verticalInterval: 0.3,
        getDrawingHorizontalLine: (value) => const FlLine(
          color: Color(0xFFE0E0E0),
          strokeWidth: 1,
          dashArray: [5, 5],
        ),
        getDrawingVerticalLine: (value) => const FlLine(
          color: Color(0xFFE0E0E0),
          strokeWidth: 1,
          dashArray: [5, 5],
        ),
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 40,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      minX: 0,
      maxX: 2.1,
      minY: -40,
      maxY: 200,
      lineBarsData: [
        LineChartBarData(
          spots: examPoints.map((data) => FlSpot(data.x, data.y)).toList(),
          isCurved: false,
          color: widget.subject.color,
          barWidth: 2,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 4,
              color: widget.subject.color,
              strokeWidth: 2,
              strokeColor: Colors.black,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            color: widget.subject.color.withOpacity(0.2),
          ),
        ),
      ],
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
            y: upperLimit,
            color: Colors.red,
            strokeWidth: 3,
            dashArray: [8, 8],
            label: HorizontalLineLabel(
              show: true,
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              style: const TextStyle(color: Colors.black, fontSize: 12),
              labelResolver: (line) => 'Upper Limit',
            ),
          ),
          HorizontalLine(
            y: lowerLimit,
            color: Colors.red,
            strokeWidth: 3,
            dashArray: [8, 8],
            label: HorizontalLineLabel(
              show: true,
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              style: const TextStyle(color: Colors.black, fontSize: 12),
              labelResolver: (line) => 'Lower Limit',
            ),
          ),
        ],
      ),
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              final examData = examPoints.firstWhere(
                  (data) => data.x == spot.x && data.y == spot.y);
              return LineTooltipItem(
                '${examData.label}\n${spot.y.toStringAsFixed(1)}',
                const TextStyle(color: Colors.white),
              );
            }).toList();
          },
          getTooltipColor: (FlSpot spot) => widget.subject.color.withOpacity(0.9),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final data = examPoints.firstWhere(
      (element) => element.x.toStringAsFixed(1) == value.toStringAsFixed(1),
      orElse: () => ExamData(value, 0, ''),
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        data.label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (value % 40 != 0 || value < 0) return Container();
    return Text(
      value.toStringAsFixed(0),
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      textAlign: TextAlign.left,
    );
  }
}
