enum AttendanceStatus {
  present,
  absent,
  late,
}

class AttendanceRecord {
  final String studentId;
  final String date;
  AttendanceStatus status;

  AttendanceRecord({
    required this.studentId,
    required this.date,
    required this.status,
  });

  AttendanceRecord copyWith({AttendanceStatus? status}) {
    return AttendanceRecord(
      studentId: studentId,
      date: date,
      status: status ?? this.status,
    );
  }
}