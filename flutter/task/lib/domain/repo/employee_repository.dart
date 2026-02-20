import '../entities/employee.dart';

abstract class EmployeeRepository {
  Future<List<Employee>> getAllEmployees();
  Future<Employee> addEmployee(Employee employee);
  Future<void> deleteEmployee(int id);
}