import 'package:flutter/material.dart';

class Category {
  final String id, name, description;
  final IconData icon;
  final Color color;
  const Category(this.id, this.name, this.description, this.icon, this.color);
}

class Tip {
  final String id, categoryId, title, body;
  const Tip(this.id, this.categoryId, this.title, this.body);
}

const categories = <Category>[
  Category('home', 'Home Safety', 'Essential tips to keep your home secure and safe',
      Icons.home_rounded, Colors.teal),
  Category('dating', 'Dating Safety', 'Stay safe while dating and meeting people',
      Icons.favorite_rounded, Colors.pink),
  Category('transport', 'Transport', 'Safe travel and transportation tips',
      Icons.directions_car_rounded, Colors.blue),
  Category('night', 'Night Out', 'Tips for staying safe during nighttime activities',
      Icons.nightlife_rounded, Colors.deepPurple),
  Category('personal', 'Personal Safety', 'General personal safety awareness',
      Icons.shield_rounded, Colors.indigo),
  Category('emergency', 'Emergency Preparedness', 'Be prepared for emergency situations',
      Icons.medical_services_rounded, Colors.red),
  Category('online', 'Online Safety', 'Protect yourself and your information online',
      Icons.lock_rounded, Colors.orange),
];

const tips = <Tip>[
  Tip('h1', 'home', 'Home Security Essentials',
      "Ensure all doors and windows have working locks and use them consistently. Install security lights with motion sensors around your property. Don't advertise expensive purchases or vacations on social media."),
  Tip('h2', 'home', 'Know Your Neighbours',
      'Exchange numbers with trusted neighbours and join a community watch group. People who know each other notice when something is wrong.'),
  Tip('d1', 'dating', 'Meeting Someone New',
      'Meet in a public place the first few times, arrange your own transport, and tell a friend who you are meeting and when you expect to be home.'),
  Tip('p1', 'personal', 'Stay Aware',
      'Keep your phone out of sight when walking, avoid wearing both earphones, and trust your instincts. If a place or person feels wrong, leave.'),
  Tip('e1', 'emergency', 'Emergency Preparedness',
      'Save emergency numbers on your phone and tell a trusted person where you keep important documents. Keep a small emergency bag ready.'),
  Tip('o1', 'online', 'Protect Your Accounts',
      'Use a different strong password for each account, turn on two-step verification, and never share OTPs or PINs with anyone, including people claiming to be your bank.'),
];