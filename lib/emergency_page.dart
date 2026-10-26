import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_state.dart';
import 'location_share.dart';

class _Service {
  final String name, number, note;
  final bool sms;
  const _Service(this.name, this.number, this.note, {this.sms = false});
}

const _national = <_Service>[
  _Service('Police Emergency', '10111', 'For immediate police assistance'),
  _Service('Ambulance', '10177', 'Medical emergencies'),
  _Service('Emergency from a cellphone', '112', 'Works on any network'),
  _Service('GBV Command Centre', '0800428428',
      '24/7 hotline for gender-based violence',
      sms: true),
  _Service('Childline', '0800055555', 'Free child protection line'),
  _Service('Lifeline', '0861322322', 'Counselling and emotional support'),
];

Future<void> _call(BuildContext context, String number) async {
  final messenger = ScaffoldMessenger.of(context);
  final ok = await launchUrl(Uri(scheme: 'tel', path: number.replaceAll(' ', '')));
  if (!ok) {
    messenger.showSnackBar(
        const SnackBar(content: Text('Could not open the phone dialer')));
  }
}

Future<void> _sms(String number) =>
    launchUrl(Uri(scheme: 'sms', path: number.replaceAll(' ', '')));

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  Future<void> _confirmSos(BuildContext context) async {
    final go = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Call emergency services?'),
        content: const Text('This will dial 112.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Call now')),
        ],
      ),
    );
    if (go == true && context.mounted) _call(context, '112');
  }

  Future<void> _addContact(BuildContext context) async {
    final name = TextEditingController();
    final number = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add emergency contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Name')),
            TextField(
                controller: number,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone number')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Save')),
        ],
      ),
    );
    if (ok == true &&
        name.text.trim().isNotEmpty &&
        number.text.trim().isNotEmpty) {
      appState.addContact(MyContact(name.text.trim(), number.text.trim()));
    }
  }

  Widget _row(BuildContext context,
      {required String name,
        required String number,
        required String note,
        bool sms = false,
        VoidCallback? onDelete}) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            const Icon(Icons.local_police, color: Colors.red),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(number),
                  Text(note,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),
            ),
            if (onDelete != null)
              IconButton(
                  icon: const Icon(Icons.delete_outline), onPressed: onDelete),
            if (sms)
              IconButton.filled(
                style: IconButton.styleFrom(backgroundColor: Colors.purple),
                icon: const Icon(Icons.chat_bubble, size: 18),
                onPressed: () => _sms(number),
              ),
            IconButton.filled(
              style: IconButton.styleFrom(backgroundColor: Colors.pink),
              icon: const Icon(Icons.call, size: 18),
              onPressed: () => _call(context, number),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        onPressed: () => _addContact(context),
        child: const Icon(Icons.add),
      ),
      body: ListenableBuilder(
        listenable: appState,
        builder: (context, _) => ListView(
          padding: const EdgeInsets.only(bottom: 90),
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Emergency Contacts',
                      style:
                      TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                  SizedBox(height: 2),
                  Text('Tap to call or message for immediate assistance',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _confirmSos(context),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE91E63),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12,
                              offset: Offset(0, 4)),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text('SOS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Emergency Actions',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ActionChip(
                              label: const Text('Share'),
                              avatar: const Icon(Icons.share, size: 16),
                              onPressed: () => shareWithLocation(context, 
                                  'I need help. Please check on me.'),
                            ),
                            ActionChip(
                              label: const Text("I'm Safe"),
                              avatar: const Icon(Icons.check_circle,
                                  size: 16, color: Colors.green),
                              onPressed: () => shareWithLocation(context, 
                                  "I'm safe. Thanks for checking in."),
                            ),
                            ActionChip(
                              label: const Text('Need Help'),
                              avatar: const Icon(Icons.warning_amber,
                                  size: 16, color: Colors.orange),
                              onPressed: () => shareWithLocation(context, 
                                  'I need help right now. Please call me.'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Text('🇿🇦 National Emergency Services',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
            for (final s in _national)
              _row(context,
                  name: s.name, number: s.number, note: s.note, sms: s.sms),
            if (appState.contacts.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 4),
                child: Text('My Contacts',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              ),
              for (final c in appState.contacts)
                _row(context,
                    name: c.name,
                    number: c.number,
                    note: 'Added by you',
                    onDelete: () => appState.removeContact(c)),
            ],
          ],
        ),
      ),
    );
  }
}