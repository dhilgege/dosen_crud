import 'package:flutter/material.dart';

import 'core/injection/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'features/dosen/presentation/pages/dosen_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Dosen CRUD',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const DosenListPage(),
    );
  }
}
