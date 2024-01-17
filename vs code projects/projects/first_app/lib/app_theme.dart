import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData festiveTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.teal[600],
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 137, 123),
        ),
      ),
      cardTheme: CardTheme(color: Colors.grey),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
          color: Colors.teal[600],
          fontSize: 18,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: Colors.teal[600],
          fontSize: 16,
        ),
        titleLarge: GoogleFonts.poppins(
          color: Colors.teal[600],
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        // Add other text styles with appropriate Google Fonts
      ),
      iconTheme: IconThemeData(
        color: Colors.teal[600],
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white, // Set background color to white
        selectedItemColor:
            Color(0xFF33CC99), // Use Shamrock color for selected item
        unselectedItemColor: Colors.grey,
      ),
      // Further customizations for buttons, card themes, etc.
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.teal[600],
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 137, 123),
        ),
      ),
      cardTheme: CardTheme(color:Colors.grey[200]),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
          color: Colors.teal[600],
          fontSize: 18,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: Colors.teal[600],
          fontSize: 16,
        ),
        titleLarge: GoogleFonts.poppins(
          color: Colors.teal[600],
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        // Add other text styles with appropriate Google Fonts
      ),
      iconTheme: IconThemeData(
        color: Colors.teal[600],
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black, // Set background color to white
        selectedItemColor:
            Color(0xFF33CC99), // Use Shamrock color for selected item
        unselectedItemColor: Colors.grey,
      ),
      // Further customizations for buttons, card themes, etc.
    
    );
  }
}
