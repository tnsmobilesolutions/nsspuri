
import 'package:flutter/material.dart';
import 'package:sammilani_delegate/utilities/text_style.dart';
import 'color_palette.dart';

// Ovrriding the default dark theme
class AppThemeDark {
  AppThemeDark();

  static
  buildDelegateTheme() {
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      brightness: Brightness.dark,

      primaryColor: DarkPrimaryBlue,
      primaryColorLight: DarkPrimaryBlueLight,

      hintColor: DarkSecondaryGrey,

      scaffoldBackgroundColor: DarkScaffoldBackgroundBlack,

      textTheme: _buildDelegateTextTheme(base.textTheme),

      // Defining the colorScheme
      colorScheme: base.colorScheme.copyWith(
        onPrimary: DarkOnPrimaryWhite,
        onSecondary: DarkOnSecondaryBlack,
      ),

      // By default takes the primaryColor and TextTheme headline6 style
      appBarTheme: base.appBarTheme.copyWith(
        color: DarkThemeBlack, toolbarTextStyle: base.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ).bodyMedium, titleTextStyle: base.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ).titleLarge,
      ),

      // Ovrriding the default dark card theme
      cardTheme: base.cardTheme.copyWith(
        color: DarkSecondaryGrey,
        elevation: 0.0,
      ),

      // Overriding the default button theme
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: DarkPrimaryBlue,
        textTheme: ButtonTextTheme.primary,
        //Color to start filling the Buttons when pressed.
        splashColor: DarkPrimaryBlueLight,
      ),

      // Ovveriding the default Textfield style
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: DarkPrimaryBlue,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        hintStyle: TextHintStyle,

      ),

      // Overriding the default dark icon style
      iconTheme: base.iconTheme.copyWith(
        color: DarkOnSecondaryBlack,
        size: 26.0,
      ),
    );
  }

  // Method to create and return text styles for the default dark theme
  static _buildDelegateTextTheme(TextTheme base) {
    return base
        .copyWith(
      titleLarge: Headline6Style,
      headlineSmall: Headline5TextStyle,
      headlineMedium: Headline4TextStyle,
      displaySmall: Headline3TextStyle,
      bodyLarge: BodyText1Style,
      bodyMedium:  const TextStyle(
        color: DarkOnPrimaryWhite,
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: 
      ButtonTextStyle,
      bodySmall: 
      CaptionStyle,
    )
        .apply(
      // This will override and apply to all.
      fontFamily: 'poppins',
    );
  }
}

/** For using colorScheme, override the other widget objects also.**/
// final ThemeData base = ThemeData.from(
//   colorScheme: ColorScheme(
// primary: 
// DarkPrimaryBlue,
// primaryVariant: kDarkPrimaryBlueLight,
// secondary:  kDarkSecondaryGrey,
// secondaryVariant: kDarkSecondaryGreyLight,
// onPrimary: kOnPrimaryWhite,
// onSecondary: kOnSecondaryBlack,
//   ),
// );

