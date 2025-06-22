import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:judge/presentation/routes/export.dart';
import 'package:judge/presentation/providers/export.dart';
import 'package:judge/shared/export.dart';

import 'dependency_injection.dart';
import 'env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);

  configureDependencies();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthenticationBloc>(),
      child: OKToast(
        position: ToastPosition.bottom,
        child: MaterialApp.router(
          theme: getIt<DarkThemeData>().themeData,
          routerConfig: getIt<AppRouter>().config(),
        ),
      ),
    );
  }
}
