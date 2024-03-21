import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Item {
  String name;
  double value;
  double quantity;

  Item({required this.name, required this.value, required this.quantity});
}

class NewBudgetPage extends StatefulWidget {
  const NewBudgetPage({super.key});

  @override
  State<NewBudgetPage> createState() => _NewBudgetPageState();
}

class _NewBudgetPageState extends State<NewBudgetPage> {
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _clientPhoneController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();

  var totalValue = 0.0;

  List<Item> items = [
    Item(name: "Item 1", value: 10.0, quantity: 10.0),
    Item(name: "Item 2", value: 20.0, quantity: 20.0),
    Item(name: "Item 3", value: 30.0, quantity: 30.0),
    Item(name: "Item 4", value: 40.0, quantity: 40.0),
    Item(name: "Item 5", value: 50.0, quantity: 50.0),
    Item(name: "Item 6", value: 60.0, quantity: 60.0),
    Item(name: "Item 7", value: 70.0, quantity: 70.0),
    Item(name: "Item 8", value: 80.0, quantity: 80.0),
    Item(name: "Item 9", value: 90.0, quantity: 90.0),
    Item(name: "Item 10", value: 100.0, quantity: 100.0),
  ];
  var numb = NumberFormat("###,##0.00", "pt_BR");

  String getTotal() {
    totalValue = 0;
    for (var element in items) {
      totalValue += element.value * element.quantity;
    }
    return numb.format(totalValue);
  }

  String getItemTotal(Item item) {
    return numb.format(item.value * item.quantity);
  }

  void showForm(BuildContext context, int? itemKey) {
    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (_) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 15,
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Dados do item",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nome do item",
                  prefixIcon: Icon(
                    Icons.insert_emoticon,
                  ),
                  alignLabelWithHint: true),
              controller: _productNameController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Quantidade do item",
                  prefixIcon: Icon(
                    Icons.insert_emoticon,
                  ),
                  alignLabelWithHint: true),
              controller: _productQuantityController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Valor unitário do item",
                  prefixIcon: Icon(
                    Icons.insert_emoticon,
                  ),
                  alignLabelWithHint: true),
              controller: _productPriceController,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                var newItem = Item(
                  name: _productNameController.text,
                  value: double.parse(_productPriceController.text
                      .replaceAll(",", ".")
                      .toString()),
                  quantity: double.parse(_productQuantityController.text
                      .replaceAll(",", ".")
                      .toString()),
                );
                _productNameController.text = "";
                _productPriceController.text = "";
                _productQuantityController.text = "";
                items.add(newItem);
                setState(() {});
                Navigator.pop(context);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.black),
                child: const Text('Adicionar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.save,
              color: Colors.blueAccent,
            ),
          ),
        ],
        title: const Text('Novo orçamento'),
      ),
      body: Container(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nome do cliente",
                prefixIcon: Icon(
                  Icons.person,
                ),
                alignLabelWithHint: true),
            controller: _clientNameController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Whatsapp do cliente",
                prefixIcon: Icon(
                  Icons.phone,
                ),
                alignLabelWithHint: true),
            controller: _clientPhoneController,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              showForm(context, null);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                Text('Adicionar item'),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                var item = items[index];

                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                      '${item.quantity} X R\$${numb.format(item.value)} = R\$${getItemTotal(item)}'),
                  dense: true,
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          items = items
                              .where((it) => it.name != item.name)
                              .toList();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: items.length,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.black,
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            child: Text(
              "Total: R\$${getTotal()}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
