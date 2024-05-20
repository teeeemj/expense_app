import 'dart:ui';

import 'package:expense/blocs/bloc/expense_tracker_bloc.dart';
import 'package:expense/repositories/expense_model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    List icons = [];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          color: Colors.white.withOpacity(0.6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Today at Thu Mar 07 2024'),
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 10),
                Icon(
                  Icons.keyboard_double_arrow_down,
                  size: 35,
                  color: Colors.grey[700],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              border: Border.all(
                                  color: Colors.grey[800]!, width: 2),
                            ),
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  const Text('E X P E N S E S'),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0,
                                      ),
                                      itemCount:
                                          icons.length + 1, // +1 для кнопки
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          // Вставляем кнопку на первое место
                                          return InkWell(
                                            onTap: () {
                                              icons.add(
                                                  const Icon(Icons.remove));
                                              setState(() {});
                                              print(icons.length);
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white54,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .vertical(
                                                        top:
                                                            Radius.circular(20),
                                                      ),
                                                      border: Border.all(
                                                        color:
                                                            Colors.grey[800]!,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                            Icons.arrow_back,
                                                            size: 20,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        const Divider(),
                                                        const Center(
                                                            child: Text(
                                                                'New Tag')),
                                                        const SizedBox(
                                                            height: 10),
                                                        NewTagTextField(),
                                                        const SizedBox(
                                                            height: 10),
                                                        const TextField(),
                                                        const SizedBox(
                                                            height: 10),
                                                        ElevatedButton(
                                                          onPressed: () {},
                                                          child: const Text(
                                                              'Confirm'),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: const Icon(Icons.add),
                                          );
                                        } else {
                                          // Отображаем иконки в сетке
                                          // final icon = icons[
                                          //     index - 1]; // -1 из-за кнопки
                                          // return Icon(icon);
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.shopify_sharp),
                      const Text('clothes'),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.refresh_sharp),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<ExpenseTrackerBloc>(context).add(
                          AddExpense(
                            expense: ExpenseModel(
                              amount: double.parse(amountController.text),
                              icon: Icons.shopify_sharp,
                              category: 'clothes',
                            ),
                          ),
                        );
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text('Add'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewTagTextField extends StatelessWidget {
  const NewTagTextField({
    super.key,
    required this.hintText,
  });

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 100,
      ),
      child: TextField(
        controller: TextEditingController(),
        decoration: InputDecoration(
          hintText: hintText,
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
