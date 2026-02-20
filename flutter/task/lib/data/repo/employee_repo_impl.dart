import 'package:task/data/source/employee_remote_data_source.dart';
import 'package:task/domain/repo/employee_repository.dart';

import '../../domain/entities/employee.dart';
import '../models/employee_model.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;

  EmployeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Employee>> getAllEmployees() => remoteDataSource.getAllEmployees();

  @override
  Future<Employee> addEmployee(Employee employee) =>
      remoteDataSource.addEmployee(EmployeeModel(
        name: employee.name,
        email: employee.email,
        phone: employee.phone,
        designation: employee.designation,
        joiningDate: employee.joiningDate,
        isActive: employee.isActive,
      ));

  @override
  Future<void> deleteEmployee(int id) => remoteDataSource.deleteEmployee(id);
}