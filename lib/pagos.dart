import 'package:flutter/material.dart';

class PagosScreen extends StatefulWidget {
  @override
  _PagosScreenState createState() => _PagosScreenState();
}

class _PagosScreenState extends State<PagosScreen> {
  final List<Map<String, dynamic>> pagos = [
    {
      'name': 'Amazon Echo Pop',
      'price': 999,
      'vencido': false,
    },
    {
      'name': 'Amazon Kindle',
      'price': 1899,
      'vencido': true,
    },
    {
      'name': 'PlayStation DualSense® Wireless Controller',
      'price': 1199,
      'vencido': false,
    },
    {
      'name': 'Skechers Go Walk Flex',
      'price': 1116,
      'vencido': true,
    },
    {
      'name': 'Kingston SSD KC600',
      'price': 695,
      'vencido': false,
    },
    {
      'name': 'RACK & PACK Taladro Inalambrico Atornillador Rotomartillo Electrico',
      'price': 564,
      'vencido': true,
    },
  ];

  void showPaymentDialog(BuildContext context, Map<String, dynamic> producto) {
    final TextEditingController cardNumberController = TextEditingController();
    final TextEditingController cardNameController = TextEditingController();
    final TextEditingController cardExpiryController = TextEditingController();
    final TextEditingController cardCVVController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ingresar datos de pago'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Número de tarjeta'),
                  maxLength: 16,
                ),
                TextField(
                  controller: cardNameController,
                  decoration: InputDecoration(labelText: 'Nombre en la tarjeta'),
                ),
                TextField(
                  controller: cardExpiryController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(labelText: 'Fecha de expiración (MM/AA)'),
                ),
                TextField(
                  controller: cardCVVController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'CVV'),
                  maxLength: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Validar datos de la tarjeta
                if (cardNumberController.text.length == 16 &&
                    cardCVVController.text.length == 3 &&
                    cardExpiryController.text.isNotEmpty &&
                    cardNameController.text.isNotEmpty) {
                  Navigator.pop(context);
                  Future.delayed(Duration.zero, () => showTotalDialog(context, producto));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, complete los datos correctamente.')),
                  );
                }
              },
              child: Text('Pagar'),
            ),
          ],
        );
      },
    );
  }

  void showTotalDialog(BuildContext context, Map<String, dynamic> producto) {
    final double precioBase = producto['price'];
    final double precioFinal = producto['vencido'] ? precioBase * 1.2 : precioBase;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar Pago'),
          content: Text(
            'Total a pagar: \$${precioFinal.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  pagos.remove(producto);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pago realizado con éxito.')),
                );
              },
              child: Text('Confirmar Pago'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagos Pendientes'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: pagos.length,
        itemBuilder: (context, index) {
          final producto = pagos[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(producto['name']),
              subtitle: Text(
                producto['vencido']
                    ? 'Estado: Vencido (+20% intereses)'
                    : 'Estado: Próximo',
                style: TextStyle(
                  color: producto['vencido'] ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                '\$${producto['price']}',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => showPaymentDialog(context, producto),
            ),
          );
        },
      ),
    );
  }
}
