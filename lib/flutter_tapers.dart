import 'package:chest/chest.dart';
import 'package:flutter/material.dart';

extension TapersForFlutter on TapersNamespace {
  Map<int, Taper<dynamic>> get forFlutter {
    return {
      -50: taper.forColor(),
      -51: taper.forMaterialColor(),
      -52: taper.forThemeMode(),
    };
  }
}

extension TaperForColor on TaperNamespace {
  Taper<Color> forColor() => _TaperForColor();
}

class _TaperForColor extends BytesTaper<Color> {
  const _TaperForColor();

  @override
  List<int> toBytes(Color color) =>
      [color.alpha, color.red, color.green, color.blue];

  @override
  Color fromBytes(List<int> bytes) =>
      Color.fromARGB(bytes[0], bytes[1], bytes[2], bytes[3]);
}

extension TaperForMaterialColor on TaperNamespace {
  Taper<Color> forMaterialColor() => _TaperForMaterialColor();
}

class _TaperForMaterialColor extends MapTaper<MaterialColor> {
  const _TaperForMaterialColor();

  @override
  Map<Object, Object> toMap(MaterialColor color) {
    return {
      'primary': Color.fromARGB(
        color.alpha,
        color.red,
        color.green,
        color.blue,
      ),
      50: color.shade50,
      100: color.shade100,
      200: color.shade200,
      300: color.shade300,
      400: color.shade400,
      500: color.shade500,
      600: color.shade600,
      700: color.shade700,
      800: color.shade800,
      900: color.shade900,
    };
  }

  @override
  MaterialColor fromMap(Map<Object?, Object?> map) {
    return MaterialColor(
      map['primary'] as int,
      {
        for (final i in [50, 100, 200, 300, 400, 500, 600, 700, 800, 900])
          i: map[i] as Color,
      },
    );
  }
}

extension TaperForThemeMode on TaperNamespace {
  Taper<ThemeMode> forThemeMode() => _TaperForThemeMode();
}

class _TaperForThemeMode extends BytesTaper<ThemeMode> {
  const _TaperForThemeMode();

  @override
  List<int> toBytes(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return [0];
      case ThemeMode.light:
        return [1];
      case ThemeMode.dark:
        return [2];
      default:
        throw 'Unknown ThemeMode $themeMode.';
    }
  }

  @override
  ThemeMode fromBytes(List<int> bytes) {
    switch (bytes.first) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        throw 'Unknown byte ${bytes.first}';
    }
  }
}
