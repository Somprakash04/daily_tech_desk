import 'package:daily_tech_desk/core/routes/app_router.dart';
import 'package:daily_tech_desk/core/theme/app_theme.dart';
import 'package:daily_tech_desk/core/theme/theme_cubit.dart';
import 'package:daily_tech_desk/features/authentication/data/repositories/local_auth_session_repository.dart';
import 'package:daily_tech_desk/features/authentication/presentation/cubit/auth_session_cubit.dart';
import 'package:daily_tech_desk/features/menu/presentation/cubit/saved_articles_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_tech_desk/features/menu/presentation/cubit/saved_articles_cubit.dart';
import 'package:daily_tech_desk/features/menu/presentation/cubit/saved_articles_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferences.getInstance();

  runApp(const DailyTechDeskApp());
}

class DailyTechDeskApp extends StatelessWidget {
  const DailyTechDeskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider<AuthSessionCubit>(
          create: (_) =>
          AuthSessionCubit(LocalAuthSessionRepository())..restore(),
        ),
        BlocProvider<SavedArticlesCubit>(
          create: (_) => SavedArticlesCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (BuildContext context, ThemeMode themeMode) {
          return MaterialApp.router(
            title: 'Daily Tech Desk',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}