import 'package:flutter/material.dart';

import '../../data/fake_family_data.dart';
import '../../theme/app_theme.dart';

class FamilyTreeScreen extends StatelessWidget {
  const FamilyTreeScreen({super.key, required this.storyGenerated});

  final bool storyGenerated;

  @override
  Widget build(BuildContext context) {
    if (!storyGenerated) return const _EmptyTreeState();

    final theme = Theme.of(context);
    final tree = fakeFamilyTree;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Family tree', style: theme.textTheme.headlineSmall),
                const SizedBox(height: 2),
                Text(
                  '${tree.peopleCount} people · ${tree.generationCount} generations',
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: _TreeCanvas(tree: tree),
            ),
          ),
        ],
      ),
    );
  }
}

class _TreeCanvas extends StatelessWidget {
  const _TreeCanvas({required this.tree});

  final FamilyTreeData tree;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      decoration: BoxDecoration(color: colors.band, borderRadius: AppRadii.cardBorderRadius),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.xl * 2),
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: tree.canvasWidth,
                  height: tree.canvasHeight,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomPaint(
                        size: Size(tree.canvasWidth, tree.canvasHeight),
                        painter: _TreeConnectorPainter(
                          lineColor: Theme.of(context).colorScheme.outlineVariant,
                          gapColor: colors.dana,
                        ),
                      ),
                      for (final member in tree.members) _MemberNode(member: member),
                      _GapNode(gap: tree.gap, color: colors.dana),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: AppSpacing.sm,
            right: AppSpacing.sm,
            bottom: AppSpacing.sm,
            child: _GapCard(gap: tree.gap),
          ),
        ],
      ),
    );
  }
}

class _TreeConnectorPainter extends CustomPainter {
  const _TreeConnectorPainter({required this.lineColor, required this.gapColor});

  final Color lineColor;
  final Color gapColor;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = lineColor.withValues(alpha: 0.7)
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;

    void drawLine(Offset a, Offset b) => canvas.drawLine(a, b, linePaint);

    // grandparents' bracket and the trunk down to the parents' row
    drawLine(const Offset(110, 83), const Offset(110, 105));
    drawLine(const Offset(230, 83), const Offset(230, 105));
    drawLine(const Offset(110, 105), const Offset(230, 105));
    drawLine(const Offset(170, 105), const Offset(170, 153));

    // parents' row bracket
    drawLine(const Offset(60, 128), const Offset(280, 128));
    drawLine(const Offset(60, 128), const Offset(60, 153));
    drawLine(const Offset(280, 128), const Offset(280, 153));

    // Maryam -> Sara
    drawLine(const Offset(170, 191), const Offset(170, 225));
    drawLine(const Offset(170, 225), const Offset(105, 225));
    drawLine(const Offset(105, 225), const Offset(105, 264));

    // Noura -> Ahmed
    drawLine(const Offset(280, 191), const Offset(280, 225));
    drawLine(const Offset(280, 225), const Offset(235, 225));
    drawLine(const Offset(235, 225), const Offset(235, 264));

    final gapPaint = Paint()
      ..color = gapColor
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;
    _drawDashedLine(canvas, const Offset(110, 41), const Offset(110, 20), gapPaint);
  }

  void _drawDashedLine(Canvas canvas, Offset a, Offset b, Paint paint) {
    const dashLength = 4.0;
    const gapLength = 4.0;
    final total = (b - a).distance;
    if (total == 0) return;
    final direction = (b - a) / total;
    var drawn = 0.0;
    while (drawn < total) {
      final segmentEnd = (drawn + dashLength).clamp(0.0, total);
      canvas.drawLine(a + direction * drawn, a + direction * segmentEnd, paint);
      drawn += dashLength + gapLength;
    }
  }

  @override
  bool shouldRepaint(covariant _TreeConnectorPainter oldDelegate) => false;
}

class _MemberNode extends StatelessWidget {
  const _MemberNode({required this.member});

  final FamilyTreeMember member;

  @override
  Widget build(BuildContext context) {
    const labelWidth = 96.0;
    return Positioned(
      left: member.x - labelWidth / 2,
      top: member.y - member.radius,
      width: labelWidth,
      child: Column(
        children: [
          Container(
            width: member.radius * 2,
            height: member.radius * 2,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: member.color, shape: BoxShape.circle),
            child: Text(
              member.initial,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: member.radius * 0.7),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            member.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11, height: 1.15, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _GapNode extends StatelessWidget {
  const _GapNode({required this.gap, required this.color});

  final FamilyTreeGap gap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    const labelWidth = 60.0;
    return Positioned(
      left: gap.x - labelWidth / 2,
      top: gap.y - gap.radius,
      width: labelWidth,
      child: Column(
        children: [
          CustomPaint(
            size: Size(gap.radius * 2, gap.radius * 2),
            painter: _DashedCirclePainter(color: color),
            child: SizedBox(
              width: gap.radius * 2,
              height: gap.radius * 2,
              child: Center(
                child: Text('?', style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 14)),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(gap.name, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 10.5)),
        ],
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  const _DashedCirclePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final radius = size.width / 2 - 1;
    final center = Offset(size.width / 2, size.height / 2);
    const dashDegrees = 24.0;
    const gapDegrees = 18.0;
    var angle = 0.0;
    while (angle < 360) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, _deg2rad(angle), _deg2rad(dashDegrees), false, paint);
      angle += dashDegrees + gapDegrees;
    }
  }

  double _deg2rad(double deg) => deg * 3.1415926535 / 180;

  @override
  bool shouldRepaint(covariant _DashedCirclePainter oldDelegate) => false;
}

class _GapCard extends StatelessWidget {
  const _GapCard({required this.gap});

  final FamilyTreeGap gap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            CustomPaint(
              size: const Size(26, 26),
              painter: _DashedCirclePainter(color: colors.dana),
              child: SizedBox(
                width: 26,
                height: 26,
                child: Center(
                  child: Text('?', style: TextStyle(color: colors.dana, fontWeight: FontWeight.w700, fontSize: 13)),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(gap.missingDetail, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  Text(
                    gap.askPrompt,
                    style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.dana,
                foregroundColor: const Color(0xFF231A05),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added "${gap.name}\'s birth year" to next week\'s questions')),
                );
              },
              child: const Text('Ask'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyTreeState extends StatelessWidget {
  const _EmptyTreeState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.account_tree_outlined, size: 40, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(height: AppSpacing.sm),
              Text('No tree yet', style: theme.textTheme.headlineSmall, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Record your first story and the people in it will start filling in the tree.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
