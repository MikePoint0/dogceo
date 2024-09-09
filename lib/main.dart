import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'data/services/dog_api_service.dart';
import 'presentation/bloc/dog_bloc.dart';
import 'presentation/pages/main_page.dart';
import 'presentation/pages/details_page.dart';
import 'presentation/pages/splash_screen.dart';
import 'presentation/pages/offline_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  List<ConnectivityResult> _connectivityResult = [];

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _checkConnectivity(); // Check connectivity at start
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  Future<void> _checkConnectivity() async {
    // Get the initial connectivity status
    _connectivityResult = await _connectivity.checkConnectivity();
    setState(() {});
  }

  void _updateConnectivityStatus(List<ConnectivityResult> results) {
    setState(() {
      _connectivityResult = results;
    });

    // Navigate to OfflinePage if there's no internet
    if (_connectivityResult.contains(ConnectivityResult.none)) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OfflinePage()),
        );
      });
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel(); // Cancel the subscription to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => DogApiService()),

        // Conditionally create the Bloc based on internet connectivity
        BlocProvider(
          create: (context) {
            if (_connectivityResult.contains(ConnectivityResult.none)) {
              // No internet: return a placeholder bloc and navigate to OfflinePage
              Future.microtask(() => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OfflinePage()),
              ));
              return DogBloc(context.read<DogApiService>());
            } else {
              // Internet is available: Proceed with API request
              return DogBloc(context.read<DogApiService>())
                ..add(DogFetchEvent());
            }
          },
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Dog CEO APP',
            debugShowCheckedModeBanner: false,
            // Automatically switch between light and dark themes based on system settings
            themeMode: ThemeMode.system,
            // Define Light Theme
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.light,
              ),
              fontFamily: 'Roboto', // Custom font
              textTheme: TextTheme(
                bodyMedium: TextStyle(fontSize: 16.sp, color: Colors.black87),
                headlineSmall: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            // Define Dark Theme
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
              fontFamily: 'Roboto', // Custom font
              textTheme: TextTheme(
                bodyMedium: TextStyle(fontSize: 16.sp, color: Colors.white70),
                headlineSmall: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[200],
                ),
              ),
            ),

            initialRoute: '/splash',
            routes: {
              '/splash': (context) => SplashScreen(),
              '/': (context) => MainPage(),
              '/details': (context) => DetailsPage(),
              '/offline': (context) => OfflinePage(),
            },
          );
        },
      ),
    );
  }
}