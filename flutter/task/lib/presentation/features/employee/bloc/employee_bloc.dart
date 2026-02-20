import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/domain/usecases/add_employee.dart';
import 'package:task/domain/usecases/delete_employee.dart';
import 'package:task/domain/usecases/get_employees.dart';
import 'package:task/domain/entities/employee.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetEmployees getEmployees;
  final AddEmployee addEmployee;
  final DeleteEmployee deleteEmployee;

  EmployeeBloc({
    required this.getEmployees,
    required this.addEmployee,
    required this.deleteEmployee,
  }) : super(const EmployeeState()) {
    on<LoadEmployees>(_onLoadEmployees);
    on<SearchEmployees>(_onSearchEmployees);
    on<ToggleSearch>(_onToggleSearch);
    on<UpdateFormDate>(_onUpdateFormDate);
    on<UpdateFormActiveStatus>(_onUpdateFormActiveStatus);
    on<ResetForm>(_onResetForm);
    on<AddEmployeeEvent>(_onAddEmployee);
    on<DeleteEmployeeEvent>(_onDeleteEmployee);
  }

  Future<void> _onLoadEmployees(
    LoadEmployees event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(state.copyWith(status: EmployeeStatus.loading));
    try {
      final employees = await getEmployees();
      emit(state.copyWith(
        status: EmployeeStatus.success,
        employees: employees,
        filteredEmployees: _applySearch(employees, state.searchQuery),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: EmployeeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSearchEmployees(
    SearchEmployees event,
    Emitter<EmployeeState> emit,
  ) {
    final filtered = _applySearch(state.employees, event.query);
    emit(state.copyWith(
      searchQuery: event.query,
      filteredEmployees: filtered,
    ));
  }

  void _onToggleSearch(
    ToggleSearch event,
    Emitter<EmployeeState> emit,
  ) {
    emit(state.copyWith(
      isSearching: event.isSearching,
      searchQuery: event.isSearching ? state.searchQuery : '',
      filteredEmployees: event.isSearching 
          ? state.filteredEmployees 
          : state.employees,
    ));
  }

  void _onUpdateFormDate(
    UpdateFormDate event,
    Emitter<EmployeeState> emit,
  ) {
    emit(state.copyWith(formJoiningDate: event.date));
  }

  void _onUpdateFormActiveStatus(
    UpdateFormActiveStatus event,
    Emitter<EmployeeState> emit,
  ) {
    emit(state.copyWith(formIsActive: event.isActive));
  }

  void _onResetForm(
    ResetForm event,
    Emitter<EmployeeState> emit,
  ) {
    emit(state.copyWith(
      formStatus: FormStatus.initial,
      formErrorMessage: null,
      resetFormDate: true, 
      formIsActive: true,
    ));
  }

  Future<void> _onAddEmployee(
    AddEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    if (state.formJoiningDate == null) {
      emit(state.copyWith(
        formStatus: FormStatus.failure,
        formErrorMessage: 'Please select a joining date',
      ));
      return;
    }

    emit(state.copyWith(formStatus: FormStatus.submitting));

    try {
      final employee = Employee(
        name: event.name,
        designation: event.designation,
        email: event.email,
        phone: event.phone,
        joiningDate: state.formJoiningDate!,
        isActive: state.formIsActive,
      );

      await addEmployee(employee);
      
      final employees = await getEmployees();
      
      emit(state.copyWith(
        formStatus: FormStatus.success,
        status: EmployeeStatus.success,
        employees: employees,
        filteredEmployees: _applySearch(employees, state.searchQuery),
      ));
    } catch (e) {
      emit(state.copyWith(
        formStatus: FormStatus.failure,
        formErrorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteEmployee(
    DeleteEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(state.copyWith(status: EmployeeStatus.loading));
    try {
      await deleteEmployee(event.id);
      final employees = await getEmployees();
      emit(state.copyWith(
        status: EmployeeStatus.success,
        employees: employees,
        filteredEmployees: _applySearch(employees, state.searchQuery),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: EmployeeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  List<Employee> _applySearch(List<Employee> employees, String query) {
    if (query.isEmpty) return employees;
    final lowercaseQuery = query.toLowerCase();
    return employees.where((e) {
      return e.name.toLowerCase().contains(lowercaseQuery) ||
          e.designation.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}