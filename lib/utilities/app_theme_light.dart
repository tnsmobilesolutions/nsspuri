import 'package:flutter/material.dart';
import 'package:sammilani_delegate/utilities/text_style.dart';
import 'color_palette.dart';

// Theme override for the light theme
class AppTheme {
  AppTheme();

  static ThemeData buildDelegateTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      brightness: Brightness.light,

      primaryColor: AccentColor,

      scaffoldBackgroundColor: ScaffoldBackgroundColor,

      textTheme: _buildDelegateTextTheme(base.textTheme),

      // By default takes the primaryColor and TextTheme headline6 style
      appBarTheme: base.appBarTheme.copyWith(
        color: AppBarColor,
        toolbarTextStyle: base.textTheme
            .copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            )
            .bodyMedium,
        titleTextStyle: base.textTheme
            .copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            )
            .titleLarge,
      ),

      //Override for the default Card theme
      cardTheme: base.cardTheme.copyWith(
        color: CardColor,
        elevation: 1.0,
      ),

      // Override for the default light button theme
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: ButtonColor,
        textTheme: ButtonTextTheme.primary,
        //Color to start filling the Buttons when pressed.
      ),

      // Override for the default Textfield style
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(30),
        ),
        hintStyle: TextHintStyle,
      ),

      // Overiding the icon theme
    );
  }

  // Method to create and return the text styles
  static _buildDelegateTextTheme(TextTheme base) {
    return base
        .copyWith(
          titleLarge: Headline6Style,
          headlineSmall: Headline5TextStyle,
          headlineMedium: Headline4TextStyle,
          displaySmall: Headline3TextStyle,
          bodyLarge: BodyText1Style,
          bodyMedium: const TextStyle(
            color: TextThemeColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
          labelLarge: ButtonTextStyle,
          bodySmall: CaptionStyle,
        )
        .apply(
          // This will override and apply to all.
          fontFamily: 'OpenSans',
        );
  }
}

/** For using colorScheme, override the other widget objects also.**/
// final ThemeData base = ThemeData.from(
//   colorScheme: ColorScheme(
//     primary: kPrimaryBlueGrey,
//     primaryVariant: kPrimaryBlueGreyDark,
//     secondary: kSecondaryAmber,
//     secondaryVariant: kSecondaryAmberDark,
//     onPrimary: kOnPrimaryWhite,
//     onSecondary: kOnSecondaryBlack,
//     background: kBackgroundColor,
//     onBackground: kOnSecondaryBlack,
//     surface: kSurfaceColor,
//   ),
// );
