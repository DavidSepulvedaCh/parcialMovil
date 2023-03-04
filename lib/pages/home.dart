import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:parcial/exports.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /* ==================Functions================= */

  void logout() async {
    SharedService.prefs.clear();
    Navigator.pushNamed(context, '/login');
  }

  List<Product> productss = <Product>[];
  Future<List<Product>> getProducts() async {
    var url = 'https://api.npoint.io/9c5fef5b63af7f36fb2d';
    var rta =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 90));
    var datos = jsonDecode(rta.body);
    var register = <Product>[];
    for (datos in datos) {
      register.add(Product.fromJson(datos));
    }

    return register;
  }

  @override
  void initState() {
    super.initState();
    getProducts().then((value) {
      setState(() {
        productss.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de productos'),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: const Icon(Icons.menu_sharp),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Text(
                'Menu de opciones',
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.grid_4x4_rounded),
              title: const Text('Productos en cuadricula'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Productos en lista'),
              onTap: () {},
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: logout
            ),
          ],
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: productss.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Image.network(productss[index].image!,
                                  height: 120, width: 150, fit: BoxFit.cover),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productss[index].name!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Raleway'),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  productss[index].userName!,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Raleway'),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  productss[index].calification!,
                                  style: const TextStyle(fontFamily: 'Raleway'),
                                ),
                                const SizedBox(height: 8),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.star),
                                  color: Colors.blueGrey,
                                  padding: const EdgeInsets.only(left: 0),
                                  alignment: Alignment.centerLeft,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
