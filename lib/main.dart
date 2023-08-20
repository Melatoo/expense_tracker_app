import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

//normalmente, em projetos flutter, variaveis globais começam com k
ColorScheme kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
  //fromSeed gera uma paleta de cores a partir de uma cor,
  //para que nao seja necessario definir cada propriedade da paleta manualmente
);

ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  //systemchrome.setpreferredOrientations define as orientações do app
  //pode ser utilizado para definir que o app só pode ser utilizado em modo retrato
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      //se nao usar o copyWith, o flutter acredita que voce mudara todas
      //as propriedades do tema do app
      //o copyWith cria uma copia do tema atual e muda apenas a propriedade
      //que voce deseja
      theme: ThemeData().copyWith(
        //material3 ainda nao eh o padrao na criação desse app
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                //apenas textos que nao possuem cor definida são modificadas
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      //themeMode define o tema do app, no caso, o tema do sistema do usuario
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}
