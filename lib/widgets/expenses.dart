import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpanses = [
    Expense(
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void _appExpense(Expense expense) {
    setState(() {
      _registeredExpanses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    //indexOf retorna o indice do elemento na lista
    final expenseIndex = _registeredExpanses.indexOf(expense);

    setState(() {
      _registeredExpanses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      //snackbar é uma mensagem que aparece na parte inferior da tela
      //como um popup
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpanses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    //showModaletc adciona dinamicamente um novo elemento UI
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_appExpense),
    );
    //context(ctx, para diferenciar do context do widget) são metadados do widget,
    //como por exemplo, a posição do widget na tela
  }

  @override
  Widget build(BuildContext context) {
    //mediaquery é uma classe que contem informações sobre o dispositivo
    //nesse caso, a altura da tela
    final width = MediaQuery.of(context).size.width;

    //sempre que o celular for girado, o flutter reconstroi o widget

    Widget mainContent = const Center(
      child: Text('No expenses Found'),
    );

    if (_registeredExpanses.isNotEmpty) {
      mainContent = ExpensesList(_removeExpense, expenses: _registeredExpanses);
    }

    //o Scaffold limita a altura e largura do widget filho para o tamanho da tela
    //entao, por exemplo, uma coluna que antes ocupava o maximo de altura possivel
    //agora ocupa apenas o tamanho da tela, mesma coisa com a row e a largura
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpenseTracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpanses),
                //aqui, o expanded limita a altura da lista para o tamanho da tela
                //ja que a column nao tem tamanho limitado
                //nao precisamos usar no chart, pois o chart tem tamanho pre-definido
                Expanded(
                  child: mainContent,
                )
              ],
            )
          : Row(
              children: [
                //porem, como o chart foi pre-definido como largura infinita
                //aqui na row precisamos usar o expanded
                Expanded(child: Chart(expenses: _registeredExpanses)),
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}
