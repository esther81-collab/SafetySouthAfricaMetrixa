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
        final t = appState.t;
        final list = tips
            .where((x) => appState.isSaved(x.id))
            .where((x) => '${x.title} ${x.body}'
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList();

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t('savedTitle'),
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(t('savedSub'),
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (v) => setState(() => query = v),
                decoration: InputDecoration(
                  hintText: t('search'),
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
                  appState.saved.isEmpty ? t('nothingSaved') : t('noMatch'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              )
                  : ListView(
                children: [
                  for (final x in list) TipCard(x, savedMode: true),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}