import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

//DateFormat eh um pacote que formata datas
final formatter = DateFormat('dd/MM/yyyy');

//uuid eh um pacote para gerar ids unicos
const uuid = Uuid();

//enum eh um tipo de dado que contem valores constantes definidos por mim!
enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.travel: Icons.flight,
  Category.leisure: Icons.beach_access,
  Category.work: Icons.work,
};

class Expense {
  //parametros nomeados, o : atribui um valor ao atributo, ja que id
  //nao eh parametro da classe
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //getters sao metodos que retornam um valor, mas que sao acessados como
  //se fossem atributos
  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
