import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const ghaf900 = Color(0xFF173A2F);
  static const ghaf700 = Color(0xFF2E5E4E);
  static const ghaf500 = Color(0xFF4A806C);
  static const ghaf100 = Color(0xFFDCE8E2);

  static const sand50 = Color(0xFFF7F2E9);
  static const sand100 = Color(0xFFEFE7D9);
  static const surface = Color(0xFFFFFFFF);

  static const ink900 = Color(0xFF171A18);
  static const ink600 = Color(0xFF5C635E);
  static const ink300 = Color(0xFFA8AEA9);

  static const dana500 = Color(0xFFC8A24A);
  static const amber500 = Color(0xFFE0913A);
  static const khor500 = Color(0xFF2F6F8F);
  static const nida500 = Color(0xFFC0463C);
  static const success = Color(0xFF3F8F5F);

  static const line = Color(0xFFE4DACA);
}

class AppColorsDark {
  AppColorsDark._();

  static const background = Color(0xFF12100D);
  static const surface = Color(0xFF1C1A16);
  static const band = Color(0xFF232019);
  static const brand = Color(0xFF4A806C);
  static const ink900 = Color(0xFFF2EFE8);
  static const ink600 = Color(0xFFA9A399);
  static const ink300 = Color(0xFF6E6860);
  static const line = Color(0xFF2E2A22);
  static const dana500 = Color(0xFFD4B160);

  static const amber500 = AppColors.amber500;
  static const khor500 = AppColors.khor500;
  static const nida500 = AppColors.nida500;
  static const success = AppColors.success;
  static const ghaf100 = Color(0xFF24352E);
}

class AppAvatarColors {
  AppAvatarColors._();

  static const all = <Color>[
    Color(0xFF4A806C),
    Color(0xFFB07C4A),
    Color(0xFF2F6F8F),
    Color(0xFF8A5A7A),
    Color(0xFF6B7A3A),
    Color(0xFFA6603E),
  ];

  static Color forIndex(int index) => all[index % all.length];
}

class AppSpacing {
  AppSpacing._();

  static const unit = 4.0;
  static const xs = unit * 2;
  static const sm = unit * 3;
  static const md = unit * 4;
  static const lg = unit * 6;
  static const xl = unit * 8;

  static const screenGutter = md;
  static const cardPadding = sm;
}

class AppRadii {
  AppRadii._();

  static const card = 20.0;
  static const sheetTop = 28.0;
  static const input = 12.0;
  static const button = 14.0;

  static const cardBorderRadius = BorderRadius.all(Radius.circular(card));
  static const buttonBorderRadius = BorderRadius.all(Radius.circular(button));
}

class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.dana,
    required this.amber,
    required this.khor,
    required this.nida,
    required this.success,
    required this.band,
  });

  final Color dana;
  final Color amber;
  final Color khor;
  final Color nida;
  final Color success;
  final Color band;

  static const light = AppSemanticColors(
    dana: AppColors.dana500,
    amber: AppColors.amber500,
    khor: AppColors.khor500,
    nida: AppColors.nida500,
    success: AppColors.success,
    band: AppColors.sand100,
  );

  static const dark = AppSemanticColors(
    dana: AppColorsDark.dana500,
    amber: AppColorsDark.amber500,
    khor: AppColorsDark.khor500,
    nida: AppColorsDark.nida500,
    success: AppColorsDark.success,
    band: AppColorsDark.band,
  );

  @override
  AppSemanticColors copyWith({
    Color? dana,
    Color? amber,
    Color? khor,
    Color? nida,
    Color? success,
    Color? band,
  }) {
    return AppSemanticColors(
      dana: dana ?? this.dana,
      amber: amber ?? this.amber,
      khor: khor ?? this.khor,
      nida: nida ?? this.nida,
      success: success ?? this.success,
      band: band ?? this.band,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return t < 0.5 ? this : other;
  }
}

extension AppThemeContext on BuildContext {
  AppSemanticColors get appColors =>
      Theme.of(this).extension<AppSemanticColors>()!;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      primary: AppColors.ghaf700,
      onPrimary: Color(0xFFF4F8F6),
      secondary: AppColors.dana500,
      onSecondary: Color(0xFF231A05),
      tertiary: AppColors.khor500,
      onTertiary: Colors.white,
      error: AppColors.nida500,
      onError: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.ink900,
      onSurfaceVariant: AppColors.ink600,
      outline: AppColors.line,
      outlineVariant: AppColors.ink300,
      surfaceContainerHighest: AppColors.sand100,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      scaffoldBackground: AppColors.sand50,
      cardColor: AppColors.surface,
      extension: AppSemanticColors.light,
    );
  }

  static ThemeData get dark {
    const colorScheme = ColorScheme.dark(
      primary: AppColorsDark.brand,
      onPrimary: Color(0xFFF4F8F6),
      secondary: AppColorsDark.dana500,
      onSecondary: Color(0xFF231A05),
      tertiary: AppColorsDark.khor500,
      onTertiary: Colors.white,
      error: AppColorsDark.nida500,
      onError: Colors.white,
      surface: AppColorsDark.surface,
      onSurface: AppColorsDark.ink900,
      onSurfaceVariant: AppColorsDark.ink600,
      outline: AppColorsDark.line,
      outlineVariant: AppColorsDark.ink300,
      surfaceContainerHighest: AppColorsDark.band,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      scaffoldBackground: AppColorsDark.background,
      cardColor: AppColorsDark.surface,
      extension: AppSemanticColors.dark,
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Color scaffoldBackground,
    required Color cardColor,
    required AppSemanticColors extension,
  }) {
    final textTheme = TextTheme(
      headlineLarge: const TextStyle(
        fontSize: 32,
        height: 40 / 32,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: const TextStyle(
        fontSize: 24,
        height: 32 / 24,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: const TextStyle(
        fontSize: 20,
        height: 28 / 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: const TextStyle(
        fontSize: 17,
        height: 26 / 17,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: const TextStyle(
        fontSize: 15,
        height: 22 / 15,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: const TextStyle(
        fontSize: 13,
        height: 18 / 13,
        fontWeight: FontWeight.w500,
      ),
    ).apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      textTheme: textTheme,
      extensions: [extension],
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackground,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.cardBorderRadius,
          side: BorderSide(color: colorScheme.outline),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadii.buttonBorderRadius,
          ),
          textStyle: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadii.buttonBorderRadius,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardColor,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.12),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelMedium?.copyWith(
            color: selected ? colorScheme.primary : colorScheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? colorScheme.primary : colorScheme.onSurfaceVariant,
          );
        }),
      ),
      dividerTheme: DividerThemeData(color: colorScheme.outline, thickness: 1),
    );
  }
}
