import 'package:flutter/material.dart';
import 'main.dart';
import 'registro.dart';
import 'pagos.dart';
import 'credito.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Zapatos de Adultos',
      'category': 'Accesorios de Calzado',
      'price': 271,
      'image': 'https://http2.mlstatic.com/D_NQ_NP_864419-MLM47625357677_092021-O.webp',
    },
    {
      'name': 'Pintura Arte Barroco',
      'category': 'Arte',
      'price': 649,
      'image': 'https://http2.mlstatic.com/D_NQ_NP_775980-MLM48804712753_012022-O.webp',
    },
    {
      'name': 'Muñeca para Infantes',
      'category': 'Juguetes',
      'price': 666,
      'image': 'https://img.huffingtonpost.es/files/image_1200_720/uploads/2022/12/10/639494ddcff52.jpeg',
    },
    {
      'name': 'Perfume DCLOE GAABNA',
      'category': 'Perfumes',
      'price': 2000,
      'image': 'https://gcdn.emol.cl/humor/files/2017/05/piratas-6.jpg',
    },
    {
      'name': 'Máscara Halloween',
      'category': 'Disfraces',
      'price': 258,
      'image': 'https://m.media-amazon.com/images/I/31R1JRi9UFL._AC_SY580_.jpg',
    },
    {
      'name': 'Playera Mangalarga',
      'category': 'Ropa',
      'price': 542,
      'image': 'https://pbs.twimg.com/media/Ff8FFsrXgCYbFOh.jpg',
    },
  ];

  List<Map<String, dynamic>> cart = [];
  double credit = 3000; // Crédito inicial

  void addToCart(Map<String, dynamic> product) {
    if (credit >= product['price']) {
      setState(() {
        cart.add(product);
        credit -= product['price'];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product['name']} añadido al carrito.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Crédito insuficiente para añadir ${product['name']}.')),
      );
    }
  }

  void showCartDialog() {
    showDialog(
      context: context,
      builder: (context) {
        double totalCost = cart.fold(0, (sum, item) => sum + item['price']);
        return AlertDialog(
          title: Text('Carrito de Compras'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...cart.map((product) => Row(
                  children: [
                    Image.network(
                      product['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10),
                    Expanded(child: Text('${product['name']} - \$${product['price']}')),
                  ],
                )),
                SizedBox(height: 10),
                Divider(),
                Text('Total: \$${totalCost.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Crédito Restante: \$${credit.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (totalCost <= credit) {
                  setState(() {
                    cart.clear();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Compra realizada exitosamente.')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Crédito insuficiente para realizar la compra.')),
                  );
                }
              },
              child: Text('Comprar'),
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
        title: Text('Tienda Virtual'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: showCartDialog,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Menú Principal'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Pagos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PagosScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Credito'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreditoScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesión'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8, // Ajusta el espacio vertical
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 5, // Más espacio para las imágenes
                    child: Image.network(
                      product['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(product['category']),
                        Text('\$${product['price']}'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () => addToCart(product),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: Text('Añadir al carrito'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
