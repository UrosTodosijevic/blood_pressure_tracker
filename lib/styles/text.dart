/*Creating classes with the sole purpose of providing utility or otherwise
 methods is discouraged. Dart allows functions to exist outside of
classes for this very reason.*/

// Effective Dart
// https://dart.dev/guides/language/effective-dart/design#avoid-defining-a-class-that-contains-only--members
// https://dart-lang.github.io/linter/lints/avoid_classes_with_only_static_members.html

import 'package:flutter/material.dart';

TextStyle get homeScreenTextStyle => const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black54,
    );

TextStyle get parameterNameBigTextStyle => const TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
      color: Colors.black54,
    );

TextStyle get parameterNameSmallTextStyle => entryCardTextStyle;

TextStyle get parameterValueTextStyle => const TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.w600,
      color: Colors.black54,
    );

TextStyle get entryCardTextStyle => const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black38,
    );

TextStyle get dropdownButtonTextStyle => const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black54,
    );
