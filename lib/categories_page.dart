import 'package:flutter/material.dart';
import 'app_state.dart';
import 'category_detail_page.dart';
import 'data.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  int _count(String id) => tips.where((t) => t.categoryId == id).length;

  Widget _tile(BuildContext context, Category c) {
    final n = _count(c.id);
    final on = appState.isSubscribed(c.id);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CategoryDetailPage(c)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(c.icon, color: c.color, size: 42),
                    const SizedBox(height: 8),
                    Text(c.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(c.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    const SizedBox(height: 6),
                    Text('$n ${n == 1 ? 'tip' : 'tips'}',
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              onPressed: () => appState.toggleSub(c.id),
              icon: Icon(
                on ? Icons.notifications_active : Icons.notifications_none,
                color: Colors.amber.shade700,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Safety Categories',
                      style:
                      TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text('${categories.length} categories available',
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.82,
              children: [for (final c in categories) _tile(context, c)],
            ),
          ),
        ],
      ),
    );
  }
}