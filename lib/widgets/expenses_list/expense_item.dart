import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //titleLarge é uma propriedade que criamos no tema do app
          //que pode ser acessada pelo context
          Text(expense.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Row(
            children: [
              //tostringasfixed é para limitar o número de casas decimais
              //12.3456.toStringAsFixed(2) = 12.35
              Text('R\$${expense.amount.toStringAsFixed(2)}'),
              //spacer é um widget que ocupa o espaço restante de colunas ou
              //linhas
              const Spacer(),
              Row(children: [
                Icon(categoryIcons[expense.category]),
                const SizedBox(width: 8),
                Text(expense.formattedDate),
              ]),
            ],
          )
        ]),
      ),
    );
  }
}
