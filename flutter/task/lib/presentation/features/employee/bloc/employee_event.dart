import 'package:equatable/equatable.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class LoadEmployees extends EmployeeEvent {}

class SearchEmployees extends EmployeeEvent {
  final String query;
  const SearchEmployees(this.query);

  @override
  List<Object> get props => [query];
}

class ToggleSearch extends EmployeeEvent {
  final bool isSearching;
  const ToggleSearch(this.isSearching);

  @override
  List<Object> get props => [isSearching];
}

// Form Events
class UpdateFormDate extends EmployeeEvent {
  final DateTime date;
  const UpdateFormDate(this.date);

  @override
  List<Object> get props => [date];
}

class UpdateFormActiveStatus extends EmployeeEvent {
  final bool isActive;
  const UpdateFormActiveStatus(this.isActive);

  @override
  List<Object> get props => [isActive];
}

class ResetForm extends EmployeeEvent {}

class AddEmployeeEvent extends EmployeeEvent {
  final String name;
  final String designation;
  final String email;
  final String phone;

  const AddEmployeeEvent({
    required this.name,
    required this.designation,
    required this.email,
    required this.phone,
  });

  @override
  List<Object> get props => [name, designation, email, phone];
}

class DeleteEmployeeEvent extends EmployeeEvent {
  final int id;
  const DeleteEmployeeEvent(this.id);

  @override
  List<Object> get props => [id];
}