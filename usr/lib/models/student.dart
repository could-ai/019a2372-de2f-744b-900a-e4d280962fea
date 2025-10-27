class Student {
  final String id;
  final String name;
  final String rollNumber;

  Student({
    required this.id,
    required this.name,
    required this.rollNumber,
  });

  // Sample data for demonstration
  static List<Student> sampleStudents = [
    Student(id: '1', name: 'Alice Johnson', rollNumber: '001'),
    Student(id: '2', name: 'Bob Smith', rollNumber: '002'),
    Student(id: '3', name: 'Charlie Brown', rollNumber: '003'),
    Student(id: '4', name: 'Diana Wilson', rollNumber: '004'),
    Student(id: '5', name: 'Edward Davis', rollNumber: '005'),
    Student(id: '6', name: 'Fiona Garcia', rollNumber: '006'),
    Student(id: '7', name: 'George Miller', rollNumber: '007'),
    Student(id: '8', name: 'Helen Taylor', rollNumber: '008'),
    Student(id: '9', name: 'Ian Anderson', rollNumber: '009'),
    Student(id: '10', name: 'Julia Thomas', rollNumber: '010'),
  ];
}