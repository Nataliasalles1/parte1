import 'package:flutter/material.dart';

class Product {
  final String nome;
  final double valor;
  final String categoria;

  Product({
    required this.nome,
    required this.valor,
    required this.categoria,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> produtosComDescricoes = [
    Product(
      nome: 'Produto 1',
      valor: 100.0,
      categoria: 'Categoria 1',
    ),
    // Adicione mais produtos
  ];

  List<Product> cartItems = [];

  void addToCart(Product product) {
    setState(() {
      cartItems.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Row(
            children: [
              Text('Nome da Loja Virtual'),
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Pesquisar...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Implementar ação de pesquisa
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryButton('Categoria 1'),
                  _buildCategoryButton('Categoria 2'),
                  _buildCategoryButton('Categoria 3'),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                height: 400,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: produtosComDescricoes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductCard(
                        produto: produtosComDescricoes[index],
                        addToCart: addToCart,
                        images: imagensComDescricoes[index],
                        descriptions: descricoes[index],
                      ),
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(
                      cartItems: cartItems,
                      clearCart: () {
                        setState(() {
                          cartItems.clear();
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text('Abrir Carrinho (${cartItems.length})'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String categoryName) {
    return ElevatedButton(
      onPressed: () {
        // Implementar ação para a categoria
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        textStyle: TextStyle(fontSize: 20),
      ),
      child: Text(categoryName),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product produto;
  final Function(Product) addToCart;
  final List<String> images;
  final List<String> descriptions;

  const ProductCard({
    required this.produto,
    required this.addToCart,
    required this.images,
    required this.descriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: images.map((image) {
        return SizedBox(
          width: 300,
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 8), // Ajuste a margem aqui
            color: Colors.white,
            shadowColor: Colors.blueGrey,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 150,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(descriptions.length, (index) {
                    return Text(
                      descriptions[index],
                      style: TextStyle(fontSize: 14),
                    );
                  }),
                ),
                SizedBox(height: 6),
                ElevatedButton(
                  onPressed: () {
                    addToCart(produto);
                  },
                  child: const Text('Adicionar ao Carrinho'),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class Cart extends StatelessWidget {
  final List<Product> cartItems;
  final VoidCallback clearCart;

  const Cart({
    Key? key,
    required this.cartItems,
    required this.clearCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    imagensComDescricoes[index]
                        [0], // Use a primeira imagem do produto
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(cartItems[index].nome),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                clearCart();
                Navigator.pop(context);
              },
              child: Text('Limpar Carrinho'),
            ),
          ),
        ],
      ),
    );
  }
}

List<List<String>> imagensComDescricoes = [
  [
    'assets/imagens/mikrotik.jpeg',
    'assets/imagens/mikrotik01.jpeg',
    'assets/imagens/mikrotik02.jpeg'
  ],
  // Resto das listas de imagens...
];

List<List<String>> descricoes = [
  [
    'Roteador Mikrotik Hex Router Board com Case RB750GR3 R\$439,00',
    'Mikrotik Rb450g Routerboard R\$696,00',
    'Access Point - Mikrotik RB941-2n R\$209,21'
  ],
  // Resto das listas de descrições...
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja Virtual',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
