// Copyright © 2024 Paul Sentongo. All rights reserved.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/security_service.dart';
import '../theme/app_theme.dart';

/// Payment screen using Flutterwave inline checkout.
/// Supports MTN Mobile Money, Airtel Money, and card payments in Uganda.
///
/// To go live:
/// 1. Create a free account at https://dashboard.flutterwave.com
/// 2. Get your PUBLIC key from Settings → API Keys
/// 3. Replace _flwPublicKey below with your real key
/// 4. Set up webhook at Settings → Webhooks to verify payments server-side

class PaymentScreen extends StatefulWidget {
  final String plan;
  final int amountUgx;

  const PaymentScreen({
    super.key,
    required this.plan,
    required this.amountUgx,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // ── Replace with your real Flutterwave public key ──────────────────────────
  static const _flwPublicKey = 'FLWPUBK_TEST-XXXXXXXXXXXXXXXXXXXXXXXX-X';
  // ──────────────────────────────────────────────────────────────────────────

  late final WebViewController _controller;
  bool _loading = true;
  bool _paymentDone = false;

  @override
  void initState() {
    super.initState();
    _setupWebView();
  }

  void _setupWebView() {
    final ref = SecurityService.generatePaymentRef('user_local', widget.plan);
    final html = _buildPaymentHtml(ref);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FlutterChannel',
        onMessageReceived: (msg) => _handlePaymentResult(msg.message),
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _loading = true),
          onPageFinished: (_) => setState(() => _loading = false),
        ),
      )
      ..loadHtmlString(html);
  }

  String _buildPaymentHtml(String ref) {
    final planLabel = widget.plan[0].toUpperCase() + widget.plan.substring(1);
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Wulira Premium Payment</title>
  <script src="https://checkout.flutterwave.com/v3.js"></script>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      background: #f5f5f0;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      padding: 24px;
    }
    .card {
      background: white;
      border-radius: 20px;
      padding: 32px 24px;
      width: 100%;
      max-width: 420px;
      box-shadow: 0 4px 24px rgba(0,0,0,0.1);
      text-align: center;
    }
    .logo { font-size: 48px; margin-bottom: 12px; }
    h2 { color: #2D7D46; font-size: 22px; margin-bottom: 4px; }
    .plan { color: #666; font-size: 14px; margin-bottom: 24px; }
    .amount { font-size: 32px; font-weight: 900; color: #1a1a1a; margin-bottom: 8px; }
    .currency { font-size: 14px; color: #999; margin-bottom: 28px; }
    .pay-btn {
      background: linear-gradient(135deg, #2D7D46, #1B5E34);
      color: white;
      border: none;
      padding: 16px 32px;
      border-radius: 14px;
      font-size: 16px;
      font-weight: 700;
      cursor: pointer;
      width: 100%;
      margin-bottom: 16px;
      transition: opacity 0.2s;
    }
    .pay-btn:hover { opacity: 0.9; }
    .methods { font-size: 12px; color: #999; }
    .secure { font-size: 11px; color: #bbb; margin-top: 16px; }
  </style>
</head>
<body>
  <div class="card">
    <div class="logo">👑</div>
    <h2>Wulira Premium</h2>
    <p class="plan">$planLabel Plan</p>
    <div class="amount">UGX ${_formatAmount(widget.amountUgx)}</div>
    <div class="currency">Ugandan Shillings</div>
    <button class="pay-btn" onclick="makePayment()">
      Pay with Mobile Money or Card
    </button>
    <div class="methods">📱 MTN MoMo · Airtel Money · Visa · Mastercard</div>
    <div class="secure">🔒 Secured by Flutterwave · Ref: $ref</div>
  </div>

  <script>
    function makePayment() {
      FlutterwaveCheckout({
        public_key: "$_flwPublicKey",
        tx_ref: "$ref",
        amount: ${widget.amountUgx},
        currency: "UGX",
        payment_options: "mobilemoneyrwanda,mobilemoneyuganda,card",
        customer: {
          email: "user@wulira.app",
          phone_number: "",
          name: "Wulira User"
        },
        customizations: {
          title: "Wulira Premium",
          description: "$planLabel subscription",
          logo: ""
        },
        callback: function(data) {
          if (data.status === "successful" || data.status === "completed") {
            FlutterChannel.postMessage(JSON.stringify({
              status: "success",
              tx_ref: data.tx_ref,
              transaction_id: data.transaction_id,
              amount: data.amount
            }));
          } else {
            FlutterChannel.postMessage(JSON.stringify({
              status: "failed",
              message: "Payment was not completed"
            }));
          }
        },
        onclose: function() {
          FlutterChannel.postMessage(JSON.stringify({ status: "cancelled" }));
        }
      });
    }
  </script>
</body>
</html>
''';
  }

  String _formatAmount(int amount) {
    final s = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buffer.write(',');
      buffer.write(s[i]);
    }
    return buffer.toString();
  }

  void _handlePaymentResult(String message) {
    if (_paymentDone) return;
    try {
      final data = jsonDecode(message) as Map<String, dynamic>;
      final status = data['status'] as String;

      switch (status) {
        case 'success':
          _paymentDone = true;
          // TODO: verify payment server-side via your backend webhook
          // SecurityService.saveToken('premium_plan', widget.plan);
          _showResult(success: true, txId: data['transaction_id']?.toString());
          break;
        case 'failed':
          _showResult(success: false, message: data['message'] as String?);
          break;
        case 'cancelled':
          Navigator.pop(context);
          break;
      }
    } catch (_) {}
  }

  void _showResult({required bool success, String? txId, String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(success ? '🎉' : '❌', style: const TextStyle(fontSize: 56)),
            const SizedBox(height: 12),
            Text(
              success ? 'Payment Successful!' : 'Payment Failed',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              success
                  ? 'Welcome to Wulira Premium!\nYour account has been upgraded.'
                  : (message ?? 'Something went wrong. Please try again.'),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.lightTextSecondary),
            ),
            if (success && txId != null) ...[
              const SizedBox(height: 12),
              Text(
                'Transaction ID: $txId',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.lightTextHint,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (success) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
            child: Text(
              success ? 'Start Learning!' : 'Try Again',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secure Payment'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_loading)
            const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
        ],
      ),
    );
  }
}
