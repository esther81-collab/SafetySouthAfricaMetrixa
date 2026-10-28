import 'package:flutter/material.dart';
import 'app_state.dart';
import 'data.dart';
import 'login_page.dart';
import 'strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _pickLanguage(BuildContext context) async {
    final picked = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(appState.t('chooseLang')),
        children: [
          for (final e in langNames.entries)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, e.key),
              child: Text(e.value),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(appState.t('cancel')),
            ),
          ),
        ],
      ),
    );
    if (picked != null) appState.setLang(picked);
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

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final subs = categories.where((c) => appState.isSubscribed(c.id));
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appState.t('settings'),
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  const Text('Manage your app preferences & account',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            // Account & Login
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Account',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFF5B3FD0),
                        child: Text(
                          appState.userEmail.isNotEmpty
                              ? appState.userEmail[0].toUpperCase()
                              : 'G',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appState.userEmail.isNotEmpty
                                  ? appState.userEmail
                                  : 'Guest User',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              appState.isLoggedIn
                                  ? 'Logged in'
                                  : 'Browsing as Guest',
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await appState.logout();
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()),
                            (route) => false,
                          );
                        }
                      },
                      icon: const Icon(Icons.logout, color: Colors.redAccent),
                      label: const Text('Log Out',
                          style: TextStyle(color: Colors.redAccent)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.redAccent),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Language
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appState.t('language'),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('Choose your preferred language',
                      style: TextStyle(color: Colors.grey.shade600)),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () => _pickLanguage(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(langNames[appState.lang]!),
                    ),
                  ),
                ],
              ),
            ),

            // Notifications
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Notifications',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  Text('Manage your notification preferences',
                      style: TextStyle(color: Colors.grey.shade600)),
                  const SizedBox(height: 12),
                  const Text('Subscribed Categories',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  if (subs.isEmpty)
                    Text('None yet. Tap the bell on a category.',
                        style: TextStyle(color: Colors.grey.shade500))
                  else
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final c in subs)
                          Chip(
                            label: Text(c.name),
                            onDeleted: () => appState.toggleSub(c.id),
                          ),
                      ],
                    ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Daily Safety Tips'),
                    value: appState.dailyTips,
                    onChanged: appState.setDaily,
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Safety Alerts'),
                    value: appState.alerts,
                    onChanged: appState.setAlerts,
                  ),
                ],
              ),
            ),

            // About
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('About',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Metrixa',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Text('Version 1.0.0',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                      'Metrixa empowers people, especially GBV Victims, with reliable safety tips and quick access to emergency help.'),
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
