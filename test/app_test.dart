import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:metrixa/app_state.dart';
import 'package:metrixa/categories_page.dart';
import 'package:metrixa/settings_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await appState.load();
    appState.subscribed.clear();
  });

  test('AppState toggleSub persists and updates state', () async {
    expect(appState.isSubscribed('home'), false);
    appState.toggleSub('home');
    expect(appState.isSubscribed('home'), true);

    // Simulate app reload
    final newAppState = AppState();
    await newAppState.load();
    expect(newAppState.isSubscribed('home'), true);

    // Toggle off
    newAppState.toggleSub('home');
    expect(newAppState.isSubscribed('home'), false);
  });

  testWidgets('Tapping category bells toggles subscription state', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CategoriesPage(),
        ),
      ),
    );

    expect(find.byIcon(Icons.notifications_active), findsNothing);

    // Tap bell on Home Safety
    final homeBell = find.byIcon(Icons.notifications_none).first;
    await tester.tap(homeBell);
    await tester.pumpAndSettle();

    expect(appState.isSubscribed('home'), true);
    expect(find.byIcon(Icons.notifications_active), findsOneWidget);

    // Tap bell on Night Out
    final nightBell = find.byIcon(Icons.notifications_none).at(2); // night is 4th category, index 2 among unselected
    await tester.tap(nightBell);
    await tester.pumpAndSettle();

    expect(appState.isSubscribed('night'), true);
    expect(find.byIcon(Icons.notifications_active), findsNWidgets(2));
  });

  testWidgets('Settings shows subscribed categories and small ✕ removes subscription', (tester) async {
    appState.toggleSub('home');
    appState.toggleSub('night');

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SettingsPage(),
        ),
      ),
    );

    expect(find.text('Home Safety'), findsOneWidget);
    expect(find.text('Night Out'), findsOneWidget);

    // Tap small ✕ on Home Safety chip
    final chipDeleteIcon = find.byIcon(Icons.cancel).first;
    await tester.tap(chipDeleteIcon);
    await tester.pumpAndSettle();

    expect(appState.isSubscribed('home'), false);
    expect(appState.isSubscribed('night'), true);
    expect(find.text('Home Safety'), findsNothing);
    expect(find.text('Night Out'), findsOneWidget);
  });
}
