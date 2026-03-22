// Copyright © 2024 Paul Sentongo. All rights reserved.
//
// Security service: handles secure storage, input sanitization,
// session management, and integrity checks.

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,  // Uses AES-256 on Android
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // ── Secure token storage ───────────────────────────────────────────────────

  static Future<void> saveToken(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getToken(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> deleteToken(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // ── Input sanitization ─────────────────────────────────────────────────────

  /// Strips HTML tags and dangerous characters from user input
  static String sanitize(String input) {
    return input
        .replaceAll(RegExp(r'<[^>]*>'), '')         // strip HTML tags
        .replaceAll(RegExp('[<>"%\';()&+]'), '')      // strip special chars
        .trim();
  }

  /// Validates an email address format
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$').hasMatch(email.trim());
  }

  /// Validates a phone number (Uganda format: +256XXXXXXXXX or 07XXXXXXXX)
  static bool isValidUgandaPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\s|-'), '');
    return RegExp(r'^(\+256|0)(7[0-9])\d{7}$').hasMatch(cleaned);
  }

  /// Normalize Uganda phone to +256 format
  static String normalizePhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\s|-'), '');
    if (cleaned.startsWith('0')) {
      return '+256${cleaned.substring(1)}';
    }
    return cleaned;
  }

  // ── Hashing ────────────────────────────────────────────────────────────────

  /// SHA-256 hash — use for non-reversible data (e.g., device fingerprint)
  static String hash(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }

  // ── Session management ─────────────────────────────────────────────────────

  static const _sessionKey = 'wulira_session';
  static const _sessionExpiry = Duration(days: 30);

  static Future<void> createSession(String userId) async {
    final expiry = DateTime.now().add(_sessionExpiry).toIso8601String();
    final session = jsonEncode({'userId': userId, 'expiry': expiry});
    await saveToken(_sessionKey, session);
  }

  static Future<bool> isSessionValid() async {
    final raw = await getToken(_sessionKey);
    if (raw == null) return false;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final expiry = DateTime.parse(map['expiry'] as String);
      return DateTime.now().isBefore(expiry);
    } catch (_) {
      return false;
    }
  }

  static Future<void> clearSession() async {
    await deleteToken(_sessionKey);
  }

  // ── Payment reference generation ───────────────────────────────────────────

  /// Generates a unique, tamper-evident payment reference
  static String generatePaymentRef(String userId, String plan) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final raw = '$userId-$plan-$timestamp';
    final hashed = hash(raw).substring(0, 8).toUpperCase();
    return 'WUL-$hashed';
  }
}
