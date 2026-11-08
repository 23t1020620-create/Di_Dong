import 'package:flutter/material.dart';
import 'package:shopeasy/login.dart';
import 'package:shopeasy/app_setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppSettings.instance,
      builder: (context, child) {
        final settings = AppSettings.instance;

        return MaterialApp(
          debugShowCheckedModeBanner: false,

          // Chế độ sáng và tối áp dụng cho toàn bộ ứng dụng.
          themeMode: settings.cheDoToi ? ThemeMode.dark : ThemeMode.light,

          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF121212),
            cardColor: const Color(0xFF242424),
            useMaterial3: true,
          ),

          // Truyền cài đặt đến tất cả các màn hình.
          builder: (context, child) {
            return AppSettingsScope(
              notifier: settings,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(
                    settings.kichThuocChu,
                  ),
                ),
                child: child!,
              ),
            );
          },

          home: const DangNhap(),
        );
      },
    );
  }
}
