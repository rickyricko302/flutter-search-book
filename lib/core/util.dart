import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
  );
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

Color primaryColor({required BuildContext context}) {
  return Theme.of(context).colorScheme.primary;
}

Color secondaryColor({required BuildContext context}) {
  return Theme.of(context).colorScheme.secondary;
}

Color tertiaryColor({required BuildContext context}) {
  return Theme.of(context).colorScheme.tertiary;
}

TextStyle displayLargeTextTheme({required BuildContext context}) {
  return Theme.of(context).textTheme.displayLarge!;
}

TextStyle displayMediumTextTheme({required BuildContext context}) {
  return Theme.of(context).textTheme.displayMedium!;
}

TextStyle displaySmallTextTheme({required BuildContext context}) {
  return Theme.of(context).textTheme.displaySmall!;
}

TextStyle titleLargeTextTheme({required BuildContext context}) {
  return Theme.of(context).textTheme.titleLarge!;
}

TextStyle titleMediumTextTheme({required BuildContext context}) {
  return Theme.of(context).textTheme.titleMedium!;
}

TextStyle titleSmallTextTheme({required BuildContext context}) {
  return Theme.of(context).textTheme.titleSmall!;
}

TextStyle bodyLargeTextTheme({required BuildContext context}) {
  return Theme.of(context).textTheme.bodyLarge!;
}

TextStyle bodyMediumTextTheme({required BuildContext context}) {
  return Theme.of(context).textTheme.bodyMedium!;
}

TextStyle bodySmallTextTheme({required BuildContext context}) {
  return Theme.of(context).textTheme.bodySmall!;
}

TextStyle labelLargeTextTheme({required BuildContext context}) {
  return Theme.of(context).textTheme.labelLarge!;
}

TextStyle labelMediumTextTheme({required BuildContext context}) {
  return Theme.of(context).textTheme.labelMedium!;
}

TextStyle labelSmallTextTheme({required BuildContext context}) {
  return Theme.of(context).textTheme.labelSmall!;
}

double getTextWidth({required String text, required TextStyle? textStyle}) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: textStyle),
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.width;
}
