import 'dart:io';
import 'package:metrix/core/routes/generated_routes.dart';
import 'package:metrix/core/theme/app_theme.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

void main() async {
  // Initilizing The Widget Bindings Before Starting With Application Configuration
  WidgetsFlutterBinding.ensureInitialized();
  // Creating a Local Hive Database In a Particular Location
  Directory appDocDirectory = await getApplicationDocumentsDirectory();
  String hivePath = appDocDirectory.path;
  Hive.init(hivePath);
  final box = await Hive.openBox('user_details');
  final String? token = box.get('token');
  box.close();
  // Running the Application
  runApp(BiometricApplication(token: token));
}

class BiometricApplication extends StatelessWidget {
  final String? token;
  const BiometricApplication({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Using Generated Routes
      onGenerateRoute: Routes.onGenerate,
      // Auto Login Via Token Verification
      initialRoute: (token == null) ? "/login" : "/home",
      // Application Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
    );
  }
}
