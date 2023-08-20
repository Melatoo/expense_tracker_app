import 'dart:io';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('dd/MM/yyyy');

class NewExpense extends StatefulWidget {
  const NewExpense(this.onAddExpense, {super.key});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //textEditingController é um controlador de texto
  //pasmem, ele controla o texto de um textfield
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  //definindo um metodo assincrono
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    //o codigo abaixo soh eh executado quando o usuario seleciona uma data
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    //tryParse tenta converter o texto em double, se nao conseguir retorna null
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    //trim remove os espacos em branco do texto
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    //widget é uma propriedade de stateful widgets que retorna o widget
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Invalid Data'),
                content: const Text('Please enter valid data'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Ok'),
                  )
                ],
              ));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Data'),
          content: const Text('Please enter valid data'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    }
  }

  @override
  //dispose é chamado quando o widget é removido da árvore de widgets
  //esse tipo de metodo so eh utilizavel em stateful widgets
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    //no layoutbuild, temos acesso às propriedades do constraints
    return LayoutBuilder(builder: (ctx, constraints) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: 'R\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      //vertical
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //horizontal
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //o ! no final da variavel define que ela nao pode ser nula
                        Text(_selectedDate == null
                            ? 'Select a Date'
                            : formatter.format(_selectedDate!)),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_today),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _selectedCategory = value);
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      //pop remove o widget da árvore de widgets
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Add'),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
