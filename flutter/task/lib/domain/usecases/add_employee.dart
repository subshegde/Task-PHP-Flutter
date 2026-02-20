import '../repo/employee_repository.dart';
import '../entities/employee.dart';

class AddEmployee {
  final EmployeeRepository repository;

  AddEmployee(this.repository);

  Future<Employee> call(Employee employee) async {
    return await repository.addEmployee(employee);
  }
}
