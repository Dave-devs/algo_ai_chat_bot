import 'package:algo_ai_chat_bot/common/pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375.w, 875.h),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) =>
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Algo',
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Pallete.bgColor,
          appBarTheme: AppBarTheme(backgroundColor: Pallete.bgColor)
        ),
        home: const Placeholder()
      ),
    );
  }
}