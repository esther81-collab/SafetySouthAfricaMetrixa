import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'app_state.dart';
import 'data.dart';

class TipCard extends StatelessWidget {
  final Tip tip;
  const TipCard(this.tip, {super.key});

  @override
  Widget build(BuildContext context) {
    final cat = categories.firstWhere((c) => c.id == tip.categoryId);
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final saved = appState.isSaved(tip.id);
        return Card(
          elevation: 0,
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  label: Text(cat.name,
                      style: TextStyle(color: cat.color, fontSize: 12)),
                  backgroundColor: cat.color.withOpacity(0.1),
                  side: BorderSide.none,
                  visualDensity: VisualDensity.compact,
                ),
                Text(tip.title,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(tip.body,
                    style: TextStyle(color: Colors.grey.shade800, height: 1.4)),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: saved ? Colors.grey : Colors.green,
                        ),
                        onPressed: () => appState.toggleSaved(tip.id),
                        child: Text(saved ? 'Saved ✓' : 'Save for Later'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () =>
                            Share.share('${tip.title}\n\n${tip.body}'),
                        child: const Text('Share Tip'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}