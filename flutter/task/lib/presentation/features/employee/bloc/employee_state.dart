import 'package:equatable/equatable.dart';
import '../../../../../domain/entities/employee.dart';

enum EmployeeStatus { initial, loading, success, failure }
enum FormStatus { initial, submitting, success, failure }

class EmployeeState extends Equatable {
  final EmployeeStatus status;
  final List<Employee> employees;
  final List<Employee> filteredEmployees;
  final String? errorMessage;

  // Search State
  final bool isSearching;
  final String searchQuery;

  // Form State
  final FormStatus formStatus;
  final DateTime? formJoiningDate;
  final bool formIsActive;
  final String? formErrorMessage;

  const EmployeeState({
    this.status = EmployeeStatus.initial,
    this.employees = const [],
    this.filteredEmployees = const [],
    this.errorMessage,
    this.isSearching = false,
    this.searchQuery = '',
    this.formStatus = FormStatus.initial,
    this.formJoiningDate,
    this.formIsActive = true,
    this.formErrorMessage,
  });

  EmployeeState copyWith({
    EmployeeStatus? status,
    List<Employee>? employees,
    List<Employee>? filteredEmployees,
    String? errorMessage,
    bool? isSearching,
    String? searchQuery,
    FormStatus? formStatus,
    DateTime? formJoiningDate,
    bool? formIsActive,
    String? formErrorMessage,
    bool? resetFormDate,
  }) {
    return EmployeeState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
      filteredEmployees: filteredEmployees ?? this.filteredEmployees,
      errorMessage: errorMessage ?? this.errorMessage,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
      formStatus: formStatus ?? this.formStatus,
      // allow resetting date to null if specific flag passed
      formJoiningDate: resetFormDate == true ? null : (formJoiningDate ?? this.formJoiningDate),
      formIsActive: formIsActive ?? this.formIsActive,
      formErrorMessage: formErrorMessage ?? this.formErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        employees,
        filteredEmployees,
        errorMessage,
        isSearching,
        searchQuery,
        formStatus,
        formJoiningDate,
        formIsActive,
        formErrorMessage,
      ];
}