import 'package:flutter/material.dart';

class CreditoScreen extends StatefulWidget {
  @override
  _CreditoScreenState createState() => _CreditoScreenState();
}

class _CreditoScreenState extends State<CreditoScreen> {
  double credit = 3000; // Crédito inicial
  bool idUploaded = false;
  bool addressUploaded = false;

  void showIncreaseCreditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Aumentar Crédito'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            idUploaded = true;
                          });
                        },
                        child: Text('Subir Identificación'),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        idUploaded ? Icons.check_circle : Icons.circle_outlined,
                        color: idUploaded ? Colors.green : Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            addressUploaded = true;
                          });
                        },
                        child: Text('Subir Comprobante Domicilio'),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        addressUploaded ? Icons.check_circle : Icons.circle_outlined,
                        color: addressUploaded ? Colors.green : Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: idUploaded && addressUploaded
                      ? () {
                    setState(() {
                      credit = 5000;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Crédito aumentado a \$5000')),
                    );
                  }
                      : null, // Deshabilitado si no se han subido los documentos
                  child: Text('Continuar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Crédito'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Tarjeta simulada
            Card(
              color: Colors.deepPurple,
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mi Tarjeta Virtual',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      '•••• •••• •••• 1234',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Valida hasta: 12/25',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Crédito disponible
            Text(
              'Crédito Disponible:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${credit.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            // Botón para aumentar crédito
            ElevatedButton(
              onPressed: () => showIncreaseCreditDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text('Aumentar Crédito'),
            ),
          ],
        ),
      ),
    );
  }
}
