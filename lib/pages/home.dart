import 'package:parcial/exports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Widget view = Container();
  int _currentIndex = 0;

  /* ==================Functions================= */

  @override
  void initState() {
    super.initState();
    setProducts();
  }

  Future<void> setProducts() async {
    await getProducts().then((value) {
      setState(() {
        productss.addAll(value);
        view = ListProducts(products: productss);
      });
    });
  }

  List<Product> productss = <Product>[];
  Future<List<Product>> getProducts() async {
    var register = await APIService.getProducts();
    return register;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
      setState(() {
          view = ListProducts(products: productss);
        });
        break;
      case 1:
        setState(() {
          view = GridProducts(products: productss);
        });
        break;
      case 2:
        setState(() {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Favorites()));
        });
        break;
      case 3:
        Functions.logout(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de productos'),
        backgroundColor: Colors.deepOrange,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: view,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.deepOrange),
            label: 'Lista',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.grid_4x4, color: Colors.deepOrange),
            label: 'Grilla',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.deepOrange),
            label: 'Favoritos',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: Colors.deepOrange),
            label: 'Salir',
          ),
        ],
        selectedLabelStyle: const TextStyle(color: Colors.red),
      ),
    );
  }
}
