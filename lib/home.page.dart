import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_state.dart';
import 'category_detail_page.dart';
import 'data.dart';

Tip tipOfTheDay() {
  final now = DateTime.now();
  final day = now.difference(DateTime(now.year)).inDays;
  return tips[day % tips.length];
}

Widget _card(Widget child) {
  return Card(
    elevation: 0,
    color: Colors.white,
    margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Padding(padding: const EdgeInsets.all(16), child: child),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _callPolice(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final ok = await launchUrl(Uri(scheme: 'tel', path: '10111'));
    if (!ok) {
      messenger.showSnackBar(
          const SnackBar(content: Text('Could not open the phone dialer')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final tip = tipOfTheDay();
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final saved = appState.isSaved(tip.id);
        return ListView(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to Angel Guard',
                      style:
                      TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                  SizedBox(height: 2),
                  Text('Your personal safety companion',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            // Tip of the Day
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('☀️ Tip of the Day',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(tip.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(tip.body,
                      style:
                      TextStyle(color: Colors.grey.shade800, height: 1.4)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: saved ? Colors.grey : Colors.green,
                        ),
                        onPressed: () => appState.toggleSaved(tip.id),
                        child: Text(saved ? 'Saved ✓' : 'Save for Later'),
                      ),
                      const SizedBox(width: 10),
                      FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () =>
                            Share.share('${tip.title}\n\n${tip.body}'),
                        child: const Text('Share Tip'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Category tiles (first four categories)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.6,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  for (final c in categories.take(4))
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CategoryDetailPage(c)),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(c.icon, color: c.color, size: 32),
                            const SizedBox(height: 8),
                            Text(c.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Emergency contact
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Text('Emergency Contacts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            _card(
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Police Emergency',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        Text('10111'),
                        Text('For immediate police assistance',
                            style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Colors.pink),
                    onPressed: () => _callPolice(context),
                    child: const Text('Call'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}