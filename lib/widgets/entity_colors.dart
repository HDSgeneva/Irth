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
