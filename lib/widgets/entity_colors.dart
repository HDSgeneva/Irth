import 'package:flutter/material.dart';

import '../models/story.dart';
import '../theme/app_theme.dart';

Color entityColor(AppSemanticColors colors, EntityType type) {
  return switch (type) {
    EntityType.name => colors.dana,
    EntityType.place => colors.khor,
    EntityType.date => colors.success,
  };
}

String entityLabel(EntityType type) {
  return switch (type) {
    EntityType.name => 'Name',
    EntityType.place => 'Place',
    EntityType.date => 'Date',
  };
}

// Finds every occurrence of an extracted name/place/date in [text] and wraps
// it in a colored span. Longer terms are matched first so e.g. "Al Ain"
// wins over a shorter term that happens to be a substring of it.
List<InlineSpan> highlightedSpans(String text, StoryDetails details, AppSemanticColors colors) {
  final entityByTerm = <String, EntityType>{
    for (final name in details.names) name.toLowerCase(): EntityType.name,
    for (final place in details.places) place.toLowerCase(): EntityType.place,
    for (final date in details.dates) date.toLowerCase(): EntityType.date,
  };
  if (entityByTerm.isEmpty) return [TextSpan(text: text)];

  final terms = entityByTerm.keys.toList()..sort((a, b) => b.length.compareTo(a.length));
  final pattern = RegExp(terms.map(RegExp.escape).join('|'), caseSensitive: false);

  final spans = <InlineSpan>[];
  var cursor = 0;
  for (final match in pattern.allMatches(text)) {
    if (match.start > cursor) {
      spans.add(TextSpan(text: text.substring(cursor, match.start)));
    }
    final matchedText = match.group(0)!;
    final type = entityByTerm[matchedText.toLowerCase()]!;
    spans.add(TextSpan(
      text: matchedText,
      style: TextStyle(
        backgroundColor: entityColor(colors, type).withValues(alpha: 0.25),
        fontWeight: FontWeight.w600,
      ),
    ));
    cursor = match.end;
  }
  if (cursor < text.length) {
    spans.add(TextSpan(text: text.substring(cursor)));
  }
  return spans;
}
