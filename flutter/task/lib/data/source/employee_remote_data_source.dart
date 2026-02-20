import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import '../models/employee_model.dart';

class EmployeeRemoteDataSource {
  final String baseUrl;

  EmployeeRemoteDataSource({required this.baseUrl});

  Future<List<EmployeeModel>> getAllEmployees() async {
    try {
      developer.log('Fetching employees from: $baseUrl/api/employees');
      final response = await http.get(
        Uri.parse('$baseUrl/api/employees'),
      ).timeout(const Duration(seconds: 10));
      developer.log('Response status: ${response.statusCode}');
      developer.log('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((e) => EmployeeModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch employees: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('GET /employees error: $e', error: e);
      rethrow;
    }
  }

  Future<EmployeeModel> addEmployee(EmployeeModel employee) async {
    try {
      developer.log('Adding employee to: $baseUrl/api/employees');
      developer.log('Body: ${json.encode(employee.toJson())}');
      final response = await http.post(
        Uri.parse('$baseUrl/api/employees'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(employee.toJson()),
      ).timeout(const Duration(seconds: 10));
      developer.log('Response status: ${response.statusCode}');
      developer.log('Response body: ${response.body}');
      if (response.statusCode == 201) {
        return EmployeeModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add employee: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      developer.log('POST /employees error: $e', error: e);
      rethrow;
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/employees/$id'),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete employee: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('DELETE /employees/$id error: $e', error: e);
      rethrow;
    }
  }
}