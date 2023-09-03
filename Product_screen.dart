import 'package:flutter/material.dart';
import 'models/product.dart';
import 'favoritesData.dart';
import 'package:sqflite/sqflite.dart';

class ProductScreen extends StatefulWidget {

  Product item;
  ProductScreen({required this.item});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  SqlDb myDb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.item.thumbnail),
            SizedBox(
              height: 10,
            ),
            Row (
              children: [
                Icon(Icons.title ),
                SizedBox(
                  width: 10,
                ),

                      Text(
            widget.item.title,
              style: TextStyle(fontSize: 20),
            
            ),


              ],
            ),


              SizedBox(
              height: 16,
            ),
            
            Row(children: [

               Icon(Icons.price_change, size: 30,),
                  SizedBox(
                      width: 10,
                    ),
 
              Text(
                "${widget.item.price} \$",
              style: TextStyle(fontSize: 20),
           ),
            
            ],),
            SizedBox(
              height: 16,
            ),
            Row(
             
              children: [
                
                    Icon(
                      Icons.category,
                      color: Color.fromARGB(255, 17, 138, 67),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.item.category,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  
                
              ],
            ),
            SizedBox(
              height: 16,
            ),
Row(
             
              children: [
                
                    Icon(
                      Icons.branding_watermark,
                      color: Color.fromARGB(255, 54, 34, 200),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.item.brand,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  
                
              ],
            ),
            SizedBox(
              height: 16,
            ),

            SizedBox(
              width: double.infinity,
              child: Text(
                "Details : ",
                style: TextStyle(fontSize: 20 , fontWeight:FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Text(
              widget.item.description,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
                ElevatedButton.icon(
                    onPressed: () async{
                      List<Map> responce = await myDb.readData("SELECT * FROM 'favorites'");
                      print("$responce");
                    },
                    icon: Icon(Icons.shopping_cart),
                    label: Text("Add to cart")),
                SizedBox(
                  height: 10,
                ),
            ElevatedButton.icon(
              onPressed: () async{
                       String thumbnail = widget.item.thumbnail;
                       String description = widget.item.description;
                       String title = widget.item.title;
                       int price = widget.item.price;
                       String brand = widget.item.brand;
                       String category = widget.item.category;
                       print(
                           "$thumbnail \n $description \n $title \n $price \n $brand \n $category \n"
                       );
                       var responce = await myDb.insertData("INSERT INTO 'favorites' ('thumbnail' , 'description' , 'title' , 'price' , 'brand' , 'category' ) VALUES ('$thumbnail' , '$description' , '$title' , '$price' , '$brand' , '$category' )");
              },
              icon: Icon(Icons.favorite),
              label: Text("Favorite"),
            ),
            
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 116, 158, 192),
      appBar: AppBar(
        title: const Row(
          children: [ 
            SizedBox(width: 90),
            Text(
              "E",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Need",
style: TextStyle(color: Colors.blueGrey),
            ),
            SizedBox(width: 120),
            Icon(Icons.search),
            SizedBox(width: 5),
            Icon(Icons.shopping_cart),
          ],
        ),
        backgroundColor: Colors.grey,
      ),
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