// Copyright © 2024 Paul Sentongo. All rights reserved.

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'payment_screen.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.wColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Go Premium'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFCC00), Color(0xFFFF9900)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Text('👑', style: TextStyle(fontSize: 56)),
                  SizedBox(height: 12),
                  Text(
                    'Wulira Premium',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Master Luganda faster',
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Features list
            Text(
              'What you get',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            ..._features.map((f) => _FeatureRow(emoji: f[0], text: f[1])),
            const SizedBox(height: 28),

            // Pricing cards
            Text(
              'Choose your plan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _PlanCard(
              title: 'Monthly',
              price: 'UGX 15,000',
              subtitle: 'per month',
              tag: null,
              onTap: () => _startPayment(context, 'monthly', 15000),
            ),
            const SizedBox(height: 12),
            _PlanCard(
              title: 'Yearly',
              price: 'UGX 120,000',
              subtitle: 'per year · save 33%',
              tag: 'BEST VALUE',
              onTap: () => _startPayment(context, 'yearly', 120000),
            ),
            const SizedBox(height: 12),
            _PlanCard(
              title: 'Lifetime',
              price: 'UGX 350,000',
              subtitle: 'one-time payment',
              tag: null,
              onTap: () => _startPayment(context, 'lifetime', 350000),
            ),
            const SizedBox(height: 24),

            // Payment methods
            Text(
              'Accepted payment methods',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _PaymentBadge('📱 MTN Mobile Money'),
                _PaymentBadge('📱 Airtel Money'),
                _PaymentBadge('💳 Visa / Mastercard'),
              ],
            ),
            const SizedBox(height: 32),

            // Copyright & disclaimer
            Center(
              child: Text(
                '© 2024 Paul Sentongo · Wulira\nSecure payments via Flutterwave',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: colors.textHint,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startPayment(BuildContext context, String plan, int amountUgx) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(plan: plan, amountUgx: amountUgx),
      ),
    );
  }
}

const _features = [
  ['♾️', 'Unlimited lessons — all levels'],
  ['🤖', 'AI conversation practice'],
  ['📴', 'Offline mode — learn anywhere'],
  ['📊', 'Detailed progress analytics'],
  ['🎓', 'Culture & proverbs (Emigano)'],
  ['🚫', 'No ads — distraction-free'],
];

class _FeatureRow extends StatelessWidget {
  final String emoji;
  final String text;
  const _FeatureRow({required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) {
    final colors = context.wColors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: colors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String subtitle;
  final String? tag;
  final VoidCallback onTap;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.subtitle,
    required this.tag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.wColors;
    final isBest = tag != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isBest ? AppColors.primary : colors.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: isBest
              ? null
              : Border.all(color: colors.textHint.withValues(alpha: 0.3)),
          boxShadow: isBest
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (tag != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tag!,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isBest ? Colors.white : colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isBest ? Colors.white70 : colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: isBest ? Colors.white : AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isBest
                        ? Colors.white.withValues(alpha: 0.2)
                        : AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Subscribe',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isBest ? Colors.white : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentBadge extends StatelessWidget {
  final String label;
  const _PaymentBadge(this.label);

  @override
  Widget build(BuildContext context) {
    final colors = context.wColors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.textHint.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
      ),
    );
  }
}
