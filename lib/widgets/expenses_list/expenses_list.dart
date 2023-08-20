import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.onRemoveExpense, {super.key, required this.expenses});

  final List<Expense> expenses;

  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    //quando temos uma lista de elementos que ficarão como colunas, porém
    //podem crescer infinitamente, o Column não é recomendado, pois ele
    //iria renderizar todos os elementos, mesmo os que não estão na tela
    //por isso usamos o ListView.builder, que renderiza apenas os elementos que
    //estão na tela
    return ListView.builder(
      itemBuilder: (ctx, index) =>
          //key é uma chave unica para cada elemento da lista
          Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
      //itemCount é a quantidade de elementos que a lista terá
      itemCount: expenses.length,
    );
  }
}
