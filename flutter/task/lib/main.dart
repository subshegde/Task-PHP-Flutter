import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/constant.dart';
import 'package:task/data/repo/employee_repo_impl.dart';
import 'package:task/data/source/employee_remote_data_source.dart';
import 'package:task/domain/usecases/add_employee.dart';
import 'package:task/domain/usecases/delete_employee.dart';
import 'package:task/domain/usecases/get_employees.dart';
import 'presentation/features/employee/bloc/employee_bloc.dart';
import 'presentation/features/employee/pages/employee_list_page.dart';
import 'presentation/features/employee/pages/employee_form_page.dart';
import 'package:task/core/theme/app_colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  final employeeRepo = EmployeeRepositoryImpl(
    remoteDataSource:
        // Use 127.0.0.1 for ADB reverse port forwarding compatibility
        EmployeeRemoteDataSource(baseUrl: baseUrl),
  );
  runApp(MyApp(repository: employeeRepo));
}

class MyApp extends StatelessWidget {
  final EmployeeRepositoryImpl repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeBloc(
        getEmployees: GetEmployees(repository),
        addEmployee: AddEmployee(repository),
        deleteEmployee: DeleteEmployee(repository),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee Manager',
        theme: _buildTheme(Brightness.light),
        darkTheme: _buildTheme(Brightness.dark),
        themeMode: ThemeMode.system, // Respect system theme
        initialRoute: '/',
        routes: {
          '/': (context) => const EmployeeListPage(),
          '/add': (context) => const EmployeeFormPage(),
        },
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    var baseTheme = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorSchemeSeed: AppColors.primary, // Deep Navy Blue
    );

    return baseTheme.copyWith(
      scaffoldBackgroundColor: brightness == Brightness.light
          ? AppColors.backgroundLight // Off-white for light mode
          : AppColors.backgroundDark, // standard dark
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: brightness == Brightness.light
            ? AppColors.surfaceLight
            : AppColors.surfaceDark,
        titleTextStyle: TextStyle(
          color: brightness == Brightness.light ? AppColors.textLight : AppColors.textDark,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(
          color: brightness == Brightness.light ? AppColors.textLight : AppColors.textDark,
        ),
      ),
      // cardTheme removed to fix type error
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: brightness == Brightness.light
            ? Colors.grey.shade50
            : AppColors.inputFieldDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: brightness == Brightness.light
                ? Colors.grey.shade200
                : Colors.grey.shade700,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: TextStyle(
          color: brightness == Brightness.light
              ? Colors.grey.shade600
              : Colors.grey.shade400,
        ),
        prefixIconColor: brightness == Brightness.light
            ? Colors.grey.shade500
            : Colors.grey.shade400,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}