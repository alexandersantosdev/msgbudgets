import 'package:flutter/material.dart';
import 'package:msgbudgets/pages/new_budget_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orçamentos'),
      ),
      body: Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return const Text('teste');
          },
          itemCount: 1,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewBudgetPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
