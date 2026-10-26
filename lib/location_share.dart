import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share_plus/share_plus.dart';

/// Shares [message] plus a Google Maps link to the current position.
/// Falls back to the message alone if location is off or denied.
Future<void> shareWithLocation(BuildContext context, String message) async {
  final messenger = ScaffoldMessenger.of(context);
  try {
    if (!await Geolocator.isLocationServiceEnabled()) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Location is off. Sharing message only.')),
      );
      Share.share(message);
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      messenger.showSnackBar(
        const SnackBar(
            content: Text('Location permission denied. Sharing message only.')),
      );
      Share.share(message);
      return;
    }

    messenger.showSnackBar(
      const SnackBar(content: Text('Getting your location...')),
    );
    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      ),
    );
    messenger.hideCurrentSnackBar();
    Share.share(
      '$message\nMy location: https://maps.google.com/?q=${pos.latitude},${pos.longitude}',
    );
  } catch (_) {
    messenger.hideCurrentSnackBar();
    Share.share(message);
  }
}