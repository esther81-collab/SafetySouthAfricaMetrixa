import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'app_state.dart';
import 'data.dart';

class TipCard extends StatelessWidget {
  final Tip tip;
  final bool savedMode;
  const TipCard(this.tip, {super.key, this.savedMode = false});

  @override
  Widget build(BuildContext context) {
    final cat = categories.firstWhere((c) => c.id == tip.categoryId);
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final t = appState.t;
        final saved = appState.isSaved(tip.id);

        final shareButton = FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: savedMode ? Colors.green : Colors.blue,
          ),
          onPressed: () => Share.share('${tip.title}\n\n${tip.body}'),
          child: Text(savedMode ? t('share') : t('shareTip')),
        );

        final saveOrRemoveButton = FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: savedMode
                ? Colors.red
                : (saved ? Colors.grey : Colors.green),
          ),
          onPressed: () => appState.toggleSaved(tip.id),
          child: Text(savedMode
              ? t('remove')
              : (saved ? t('savedCheck') : t('saveLater'))),
        );

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
                  backgroundColor: cat.color.withValues(alpha: 0.1),
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
                    Expanded(child: savedMode ? shareButton : saveOrRemoveButton),
                    const SizedBox(width: 12),
                    Expanded(child: savedMode ? saveOrRemoveButton : shareButton),
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