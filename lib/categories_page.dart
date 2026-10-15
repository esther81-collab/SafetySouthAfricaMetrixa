import 'package:flutter/material.dart';
import 'data.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final Set<String> subscribed = {};

  int _count(String id) => tips.where((t) => t.categoryId == id).length;

  Widget _tile(Category c) {
    final n = _count(c.id);
    final on = subscribed.contains(c.id);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${c.name} tips open in the next step')),
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () => setState(() {
                  on ? subscribed.remove(c.id) : subscribed.add(c.id);
                }),
                child: Icon(
                  on ? Icons.notifications_active : Icons.notifications_none,
                  color: Colors.amber.shade700,
                  size: 22,
                ),
              ),
            ),
            Center(
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Safety Categories',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
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
            childAspectRatio: 0.95,
            children: [for (final c in categories) _tile(c)],
          ),
        ),
      ],
    );
  }
}