import 'package:flutter/material.dart';
import 'travel_plan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planejador de Viagens',
      theme: ThemeData(
        primaryColor: Colors.white, // Cor primária
        scaffoldBackgroundColor: Colors.teal[50], // Fundo azul claro
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal[200],
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.teal[200],// Cor para botões secundários
          primary: Colors.black
        ),
      ),
      home: TravelPlan(),
    );
  }
}