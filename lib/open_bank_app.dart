import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'app_router.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/repositories/auth_repository_impl.dart';
import 'features/home/bloc/tab_bloc.dart';

class OpenBanckApp extends StatelessWidget {
  // This widget is the root of your application.
  const OpenBanckApp({
    Key? key,
    required AuthRepositoryImpl authRepository,
  })  : _authRepository = authRepository,
        super(key: key);

  final AuthRepositoryImpl _authRepository;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthBloc(authRepository: _authRepository)),
        ChangeNotifierProvider(create: (BuildContext context) => TabBloc()),
      ],
      child: const _MyApp(),
    );
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: MaterialApp(
            title: 'Take Home Projects',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme:
                  GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
            ),
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
      },
    );
  }
}
