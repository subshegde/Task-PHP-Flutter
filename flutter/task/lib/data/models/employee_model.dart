import '../../domain/entities/employee.dart';

class EmployeeModel extends Employee {
  EmployeeModel({
    int? id,
    required String name,
    required String email,
    required String phone,
    required String designation,
    required DateTime joiningDate,
    required bool isActive,
  }) : super(
          id: id,
          name: name,
          email: email,
          phone: phone,
          designation: designation,
          joiningDate: joiningDate,
          isActive: isActive,
        );

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      designation: json['designation'],
      joiningDate: DateTime.parse(json['joining_date']),
      isActive: json['is_active'] == 1 || json['is_active'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'designation': designation,
      'joining_date': joiningDate.toIso8601String(),
      'is_active': isActive,
    };
  }
}