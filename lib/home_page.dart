import 'package:flutter/material.dart';

void _say(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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

class _Tile {
  final IconData icon;
  final String label;
  final Color color;
  const _Tile(this.icon, this.label, this.color);
}

const _tiles = <_Tile>[
  _Tile(Icons.home_rounded, 'Home Safety', Colors.teal),
  _Tile(Icons.favorite_rounded, 'Dating Safety', Colors.pink),
  _Tile(Icons.directions_car_rounded, 'Transport', Colors.blue),
  _Tile(Icons.nightlife_rounded, 'Night Out', Colors.deepPurple),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to Angel Guard',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              const Text('When travelling or going out',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text(
                "Always tell someone where you're going and when you'll be back. "
                    'Share your live location with a trusted contact during commutes or nights out.',
                style: TextStyle(color: Colors.grey.shade800, height: 1.4),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () => _say(context, 'Saving comes in a later step'),
                    child: const Text('Save for Later'),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () => _say(context, 'Sharing comes in a later step'),
                    child: const Text('Share Tip'),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Category tiles
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
              for (final t in _tiles)
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => _say(context, '${t.label} opens in a later step'),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(t.icon, color: t.color, size: 32),
                        const SizedBox(height: 8),
                        Text(t.label,
                            style: const TextStyle(fontWeight: FontWeight.w600)),
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
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                    Text('10111'),
                    Text('For immediate police assistance',
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.pink),
                onPressed: () => _say(context, 'Calling comes in a later step'),
                child: const Text('Call'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}