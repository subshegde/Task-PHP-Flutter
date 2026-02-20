class Employee {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String designation;
  final DateTime joiningDate;
  final bool isActive;

  Employee({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.designation,
    required this.joiningDate,
    required this.isActive,
  });
}