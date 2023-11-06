import 'package:crud/Screen/ProductCreate.dart';
import 'package:crud/Screen/ProductUpdate.dart';
import 'package:crud/Style/Style.dart';
import 'package:flutter/material.dart';

import '../RestApi/RestClient.dart';

class ProductGridView extends StatefulWidget {
  const ProductGridView({super.key});

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  List productList = [];
  bool loading = true;

  @override
  void initState(){
    getProduct();
    super.initState();
  }
  getProduct() async {
    loading = true;
    var data = await getProductGridView();
    print(data);
    setState(() {
      productList = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: loading? const Center(child: CircularProgressIndicator()) :
      RefreshIndicator(onRefresh: () async {
        await getProduct();
      },
      child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 250,
        mainAxisSpacing: 2,
      ), itemBuilder: (context, index) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Image.network(productList[index]['product_img']?? 'default_image_url',fit: BoxFit.cover,)),
              Container(
                padding: const EdgeInsets.fromLTRB(5,5,5,8),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productList[index]['product_name']??'empty'),
                    const SizedBox(height: 8,),
                    Text('Price: ${productList[index]['unit_price'] ?? 'N/A'} BDT'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductUpdate(productList: productList[index],),));
                        }, child: const Icon(Icons.edit,color: colorGreen,)),
                        const SizedBox(width: 4,),
                        OutlinedButton(onPressed: () {
                          deleteItem(productList[index]['id']);
                        }, child: const Icon(Icons.delete ,color: colorRed,)),
                      ],
                    )
                  ],
                ),
              )

            ],
          ),
        );
      },itemCount: productList.length),),
      floatingActionButton: FloatingActionButton(onPressed: () {  },
      child: IconButton(icon: const Icon(Icons.add),onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCreate(),));
      }, ),),
    );
  }

  void deleteItem(id) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Are you sure?'),
        actions: [
          TextButton(onPressed: () async {
            Navigator.pop(context);
            await deleteProduct(id);
            setState(() {
              loading = true;
            });
            getProduct();

          }, child: Text('Ok')),
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('Cancel')),
        ],
      );
    },);
  }
}

