import 'package:flutter/material.dart';
import 'data.dart';
import 'tip_card.dart';

class CategoryDetailPage extends StatelessWidget {
  final Category category;
  const CategoryDetailPage(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    final list = tips.where((t) => t.categoryId == category.id).toList();
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: list.isEmpty
          ? const Center(child: Text('No tips here yet. Check back soon.'))
          : ListView(children: [for (final t in list) TipCard(t)]),
    );
  }
}