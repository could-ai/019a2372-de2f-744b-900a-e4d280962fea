import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/student.dart';
import '../models/attendance.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final DateTime _selectedDate = DateTime.now();
  Map<String, AttendanceStatus> _attendanceRecords = {};

  @override
  void initState() {
    super.initState();
    // Initialize all students as absent by default
    for (var student in Student.sampleStudents) {
      _attendanceRecords[student.id] = AttendanceStatus.absent;
    }
  }

  void _updateAttendance(String studentId, AttendanceStatus status) {
    setState(() {
      _attendanceRecords[studentId] = status;
    });
  }

  void _saveAttendance() {
    // In a real app, this would save to a database
    // For now, just show a confirmation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Attendance Saved'),
        content: Text('Attendance for ${DateFormat('yyyy-MM-dd').format(_selectedDate)} has been recorded.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Attendance'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveAttendance,
            tooltip: 'Save Attendance',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Date: ${DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),n          ),
          Expanded(
            child: ListView.builder(
              itemCount: Student.sampleStudents.length,
              itemBuilder: (context, index) {
                final student = Student.sampleStudents[index];
                final status = _attendanceRecords[student.id] ?? AttendanceStatus.absent;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        student.rollNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    title: Text(
                      student.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('Roll No: ${student.rollNumber}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildStatusButton(
                          student.id,
                          AttendanceStatus.present,
                          'Present',
                          Colors.green,
                          status == AttendanceStatus.present,
                        ),
                        const SizedBox(width: 8),
                        _buildStatusButton(
                          student.id,
                          AttendanceStatus.late,
                          'Late',
                          Colors.orange,
                          status == AttendanceStatus.late,
                        ),
                        const SizedBox(width: 8),
                        _buildStatusButton(
                          student.id,
                          AttendanceStatus.absent,
                          'Absent',
                          Colors.red,
                          status == AttendanceStatus.absent,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryCard('Present', _countStatus(AttendanceStatus.present), Colors.green),
                _buildSummaryCard('Late', _countStatus(AttendanceStatus.late), Colors.orange),
                _buildSummaryCard('Absent', _countStatus(AttendanceStatus.absent), Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(String studentId, AttendanceStatus status, String label, Color color, bool isSelected) {
    return ElevatedButton(
      onPressed: () => _updateAttendance(studentId, status),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? color : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        minimumSize: const Size(70, 36),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _buildSummaryCard(String label, int count, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _countStatus(AttendanceStatus status) {
    return _attendanceRecords.values.where((s) => s == status).length;
  }
}