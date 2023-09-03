import 'package:flutter/material.dart';
import 'Product_screen.dart';
import 'constants.dart';
import 'data_provider/remote_data/dio_helper.dart';
import 'models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    getData();
    print(products);
  }

  Future<void> getData() async {
    List productsList = await DioHelper().getProducts(
        path: ApiConstants.baseUrl);
        print(productsList);
    products = Product.convertToProducts(productsList);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Color.fromARGB(255, 5, 32, 54),
       appBar: AppBar(
        title: const Row(
          children:[
            Text(
              "E",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Need",
              style: TextStyle(color: Colors.blueGrey),
            ),
             SizedBox(width: 265),
             Icon(Icons.search), 
              SizedBox(width: 5),
             Icon(Icons.shopping_cart),
          ],
        ),
        backgroundColor: Colors.grey,
      ),
      body: products.length == 0
          ? const Center( 
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index){
           
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                     MaterialPageRoute(builder: (context)=> ProductScreen(item: products[index],)));
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.only(bottom: 8),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                         Image.network(
                          products[index].thumbnail,
                          fit: BoxFit.fitWidth,
                        ),
                        Text(
                          products[index].title,
                          overflow: TextOverflow.ellipsis,
                          //maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Text(
                          products[index].description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                        
                      ],
                    ),
                  ),
                );
            
              }),
            bottomNavigationBar: BottomNavigationBar( backgroundColor: Colors.grey,
    selectedItemColor: Colors.white, items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
        BottomNavigationBarItem(
         icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
      ]),
    );
  }
}
