import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Splash Screen
import 'screens/splash_screen.dart';

// Auth Screens
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

// Home Screens
import 'screens/home/home_screen.dart' as home;
import 'screens/home/video_screen.dart' as video;
import 'screens/profile/profile_screen.dart' as profile;
import 'screens/careers/careers_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/settings_screen.dart';

// Providers
import 'providers/user_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Social Media App',
          
          // Custom Light Theme
          theme: ThemeData(
            primarySwatch: MaterialColor(0xFF6A11CB, {
              50: Color(0xFFF3E5F5),
              100: Color(0xFFE1BEE7),
              200: Color(0xFFCE93D8),
              300: Color(0xFFBA68C8),
              400: Color(0xFFAB47BC),
              500: Color(0xFF9C27B0),
              600: Color(0xFF8E24AA),
              700: Color(0xFF7B1FA2),
              800: Color(0xFF6A1B9A),
              900: Color(0xFF4A148C),
            }),
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Color(0xFF6A11CB)),
              titleTextStyle: TextStyle(
                color: Color(0xFF6A11CB),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.black87),
              bodyMedium: TextStyle(color: Colors.black54),
            ),
          ),
          
          // Dark Theme
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: Color(0xFF6A11CB),
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.black,
              elevation: 0,
            ),
          ),
          
          // Theme Mode from Provider
          themeMode: themeProvider.themeMode,
          
          // Initial Route
          initialRoute: '/',
          
          // Named Routes
          routes: {
            '/': (context) => SplashScreen(),
            '/login': (context) => LoginScreen(),
            '/register': (context) => RegisterScreen(),
            '/home': (context) => home.HomeScreen(),
            '/videos': (context) => video.VideoScreen(),
            '/profile': (context) => profile.ProfileScreen(),
            '/careers': (context) => CareersScreen(),
            '/chat': (context) => ChatScreen(),
            '/settings': (context) => SettingsScreen(),
          },
          
          // Optional: Custom Route Generator for more complex routing
          onGenerateRoute: (settings) {
            // Custom route animations or conditional routing can be added here
            return null;
          },
        );
      },
    );
  }
}