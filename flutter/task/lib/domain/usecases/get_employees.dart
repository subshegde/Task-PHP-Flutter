import '../repo/employee_repository.dart';
import '../entities/employee.dart';

class GetEmployees {
  final EmployeeRepository repository;

  GetEmployees(this.repository);

  Future<List<Employee>> call() async {
    return await repository.getAllEmployees();
  }
}
