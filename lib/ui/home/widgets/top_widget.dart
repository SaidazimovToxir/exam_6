import 'package:exam_6/data/models/income_model.dart';
import 'package:flutter/material.dart';

class TopWidget extends StatelessWidget {
  final List<IncomeModel> incomeModel;
  const TopWidget({super.key, required this.incomeModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: incomeModel.length,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          final income = incomeModel[index];
          return Container(
            width: 150,
            margin: const EdgeInsets.only(top: 40, bottom: 50),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 20,
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.wallet),
                    const SizedBox(height: 16),
                    Text(income.description),
                  ],
                ),
                Text(income.amount.toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}
