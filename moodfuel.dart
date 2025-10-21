import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'models/user.dart';
import 'models/mood_entry.dart';
import 'services/auth_service.dart';
import 'services/mood_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(MoodEntryAdapter());

  // Open Hive boxes
  await Hive.openBox<User>('users');
  await Hive.openBox<MoodEntry>('moodEntries');

  // Run the app with multiple providers
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => MoodService()),
      ],
      child: const MoodFuelApp(),
    ),
  );
}
