import 'package:exam_6/data/models/income_model.dart';
import 'package:exam_6/data/models/incoming_category.dart';
import 'package:exam_6/ui/home/widgets/top_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/income_bloc/income_bloc.dart';
import '../../../logic/income_bloc/income_event.dart';
import '../../../logic/income_bloc/income_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _description = TextEditingController();
  final TextEditingController _amout = TextEditingController();
  final TextEditingController _date = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Overview"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(),
          ),
        ],
      ),
      body: BlocConsumer<IncomeCrudBloc, IncomeCrudState>(
        listener: (context, state) {
          if (state is IncomeCrudError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          print(state);
          if (state is IncomeCrudInitial) {
            context.read<IncomeCrudBloc>().add(LoadIncomes());
          }
          if (state is IncomeCrudLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is IncomeCrudLoaded) {
            return Column(
              children: [
                TopWidget(
                  incomeModel: state.incomes,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 0),
                          spreadRadius: 8,
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                          child: ListView.separated(
                            itemCount: 6,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 20.0),
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.only(top: 40, bottom: 50),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 16,
                                    ),
                                  ],
                                ),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add),
                                      Text("Saving"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Latest Entires"),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: const Icon(
                                  Icons.more_horiz,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        ),

                        //? Last entires
                        Expanded(
                          child: ListView.separated(
                            itemCount: state.incomes.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final income = state.incomes[index];
                              return ListTile(
                                title: Text(income.description),
                                subtitle: Text(income.date.toString()),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(income.amount.toString()),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<IncomeCrudBloc>()
                                            .add(DeleteIncome(income.id));
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        addUpdate(true);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.teal,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff0E33F3),
        onPressed: () {
          addUpdate(false);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  void addUpdate(bool isEdit) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? "Edit the Income" : "Add the Income"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _amout,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Amount"),
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: _description,
                decoration: const InputDecoration(
                  label: Text("Description"),
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: _date,
                readOnly: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text("DateTime"),
                  suffixIcon: InkWell(
                    onTap: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2030),
                      );

                      _date.text = selectedDate.toString();
                    },
                    child: const Icon(
                      Icons.date_range,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final income = IncomeModel(
                  id: "5",
                  description: _description.text,
                  amount: double.parse(_amout.text),
                  date: selectedDate ?? DateTime.now(),
                  incomingCategory: "Test category",
                );

                if (isEdit) {
                  context.read<IncomeCrudBloc>().add(UpdateIncome(income));
                  _amout.clear();
                  _date.clear();
                  _description.clear();
                } else {
                  context.read<IncomeCrudBloc>().add(AddIncome(income));
                  _amout.clear();
                  _date.clear();
                  _description.clear();
                }
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
