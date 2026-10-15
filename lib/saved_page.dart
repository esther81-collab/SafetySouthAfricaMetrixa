import 'package:flutter/material.dart';
import 'app_state.dart';
import 'data.dart';
import 'tip_card.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final list = tips
            .where((t) => appState.isSaved(t.id))
            .where((t) => '${t.title} ${t.body}'
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList();

        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Saved Tips',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w600)),
                    SizedBox(height: 2),
                    Text('Your personal safety collection',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (v) => setState(() => query = v),
                decoration: InputDecoration(
                  hintText: 'Search your saved tips...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: list.isEmpty
                  ? Center(
                child: Text(
                  appState.saved.isEmpty
                      ? 'Nothing saved yet.\nTap "Save for Later" on a tip.'
                      : 'No saved tips match your search.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              )
                  : ListView(
                children: [
                  for (final t in list) TipCard(t, savedMode: true),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}