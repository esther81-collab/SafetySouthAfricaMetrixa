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
  // ── Home Safety ──
  Tip('h1', 'home', 'Home Security Essentials',
      "Ensure all doors and windows have working locks and use them consistently. Install security lights with motion sensors around your property. Don't advertise expensive purchases or vacations on social media."),
  Tip('h2', 'home', 'Know Your Neighbours',
      'Exchange numbers with trusted neighbours and join a community watch group. People who know each other notice when something is wrong.'),
  Tip('h3', 'home', 'Control Your Keys',
      "Never hide spare keys under a mat or flowerpot. Give a spare to a trusted neighbour or friend instead. Keep gates and burglar bars locked, even when you're at home."),
  Tip('h4', 'home', 'Before You Open the Door',
      "Check who is there through a peephole, window or camera first. Don't open the door for unexpected visitors, and ask delivery or service people for identification."),

  // ── Dating Safety ──
  Tip('d1', 'dating', 'Meeting Someone New',
      'Meet in a public place the first few times, arrange your own transport, and tell a friend who you are meeting and when you expect to be home.'),
  Tip('d2', 'dating', 'Share Your Plans',
      "Send a friend your date's name, a screenshot of their profile and the venue. Share your live location with them for the evening and agree on a time to check in."),
  Tip('d3', 'dating', 'Watch Your Drink',
      'Never leave your drink unattended and buy your own. If you suddenly feel dizzy, very drowsy or unwell, tell someone you trust and get away from the situation right away.'),
  Tip('d4', 'dating', 'Take Your Time Online',
      "Have a video call before meeting in person. Don't share your home address, workplace or financial details early on, and treat any request for money as a red flag."),

  // ── Transport ──
  Tip('t1', 'transport', 'Check Your Ride',
      'With e-hailing apps, confirm that the driver, car and number plate match the app before you get in. Share your trip details with someone you trust.'),
  Tip('t2', 'transport', 'Car Safety',
      'Have your keys ready before you walk to your car and look in the back seat before getting in. Lock the doors as soon as you are inside and keep valuables out of sight.'),
  Tip('t3', 'transport', 'Walking Safely',
      'Stick to well-lit, busy routes and avoid shortcuts. Keep your phone out of sight, stay aware of who is around you, and tell someone when you set off.'),

  // ── Night Out ──
  Tip('n1', 'night', 'Go and Return Together',
      'Decide with your friends how everyone will get home before you go out. Agree on a time to check in, and never leave anyone behind on their own.'),
  Tip('n2', 'night', 'Keep Essentials Safe',
      'Charge your phone before you leave and carry only the cash and cards you need. Keep your bag zipped and in front of you in crowded places.'),
  Tip('n3', 'night', 'Know Your Limits',
      "Pace yourself and eat before you drink. Don't accept drinks from strangers, and tell a friend before you leave with someone you have just met."),

  // ── Personal Safety ──
  Tip('p1', 'personal', 'Stay Aware',
      'Keep your phone out of sight when walking, avoid wearing both earphones, and trust your instincts. If a place or person feels wrong, leave.'),
  Tip('p2', 'personal', 'Trust Your Instincts',
      'If something feels off, move towards people, a shop or a well-lit place and call someone. You never owe anyone an explanation for protecting yourself.'),
  Tip('p3', 'personal', 'Make Noise',
      'If you feel threatened, shout and draw attention. A personal alarm is cheap, light and easy to carry on your keys or bag.'),

  // ── Emergency Preparedness ──
  Tip('e1', 'emergency', 'Emergency Preparedness',
      'Save emergency numbers on your phone and tell a trusted person where you keep important documents. Keep a small emergency bag ready.'),
  Tip('e2', 'emergency', 'Know Your Numbers',
      'Police is 10111, ambulance is 10177, and 112 works from any cellphone. For gender-based violence, the 24/7 GBV Command Centre is 0800 428 428.'),
  Tip('e3', 'emergency', 'Make a Family Plan',
      'Agree on a meeting place and who to call if you get separated. Keep a printed list of key phone numbers in case your phone is lost or dies.'),

  // ── Online Safety ──
  Tip('o1', 'online', 'Protect Your Accounts',
      'Use a different strong password for each account, turn on two-step verification, and never share OTPs or PINs with anyone, including people claiming to be your bank.'),
  Tip('o2', 'online', 'Think Before You Post',
      "Don't post your live location, travel plans, or photos that show where you live, work or study. Check your privacy settings and who can see your posts."),
  Tip('o3', 'online', 'Spot the Scams',
      "Banks never ask for your PIN, OTP or password. Don't click links in unexpected SMS messages or emails, and be careful with any offer that sounds too good to be true."),
];