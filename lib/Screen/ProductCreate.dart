import 'package:crud/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../RestApi/RestClient.dart';
import 'ProductGridView.dart';

class ProductCreate extends StatefulWidget {
  const ProductCreate({super.key});
  @override
  State<ProductCreate> createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {

  final _form = GlobalKey<FormState>();
  final _Name = TextEditingController();
  final _Code = TextEditingController();
  final _Image = TextEditingController();
  final _total_price = TextEditingController();
  final _unit_price = TextEditingController();

  Map<String,String> myForm = {
    'product_name':'',
    'product_code':'',
    'product_img':'',
    'product_quantity':'',
    'total_price':'',
    'unit_price':''
  };
  formOnChange(key, inputValue){
    setState(() {
      myForm.update(key, (value) => inputValue);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Create'),
      ),
      body: Stack(
        children: [
          // bgScreen(context),
          Form(
            key: _form,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: _Name,
                    onChanged: (value) {
                      formOnChange('product_name', value);
                    },
                    decoration: myInputDecoration('Product Name'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Product Name Field Is Required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _Code,onChanged: (value) {
                    formOnChange('product_code', value);
                  },decoration: myInputDecoration('Product Code'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Product Code Field Is Required';
                      }
                      return null;
                    },),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _Image,
                    onChanged: (value) {
                    formOnChange('product_img', value);
                  },decoration: myInputDecoration('Product Image'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Product Image Field Is Required';
                      }
                      return null;
                    },),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _unit_price,
                    onChanged: (value) {
                    formOnChange('unit_price', value);
                  },decoration: myInputDecoration('Unit Price'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Unit Price Field Is Required';
                      }
                      return null;
                    },),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _total_price,
                    onChanged: (value) {
                    formOnChange('total_price', value);
                  },decoration: myInputDecoration('Total Price'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Total Price Field Is Required';
                      }
                      return null;
                    },),
                  const SizedBox(height: 20,),
                  myDropDownStyle(
                      DropdownButton(value: myForm['product_quantity'],
                          items: const [
                        DropdownMenuItem(value: '',child: Text('Select Quantity'),),
                        DropdownMenuItem(value: '1 Pcs',child: Text('1 Pcs'),),
                        DropdownMenuItem(value: '2 Pcs',child: Text('2 Pcs'),),
                        DropdownMenuItem(value: '3 Pcs',child: Text('3 Pcs'),),
                        DropdownMenuItem(value: '4 Pcs',child: Text('4 Pcs'),),
                        DropdownMenuItem(value: '5 Pcs',child: Text('5 Pcs'),),
                      ], onChanged: (value) {
                          formOnChange('product_quantity', value);
                      },isExpanded: true, underline: Container(),)
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(style: myButtonStyle(),
                    onPressed: () async {
                      if(_form.currentState!.validate()){
                      bool sk = await productCreate(myForm);
                      print(sk);
                      if(sk){
                        _Name.clear();
                        _Code.clear();
                        _Image.clear();
                        _total_price.clear();
                        _unit_price.clear();
                        setState(() {
                          myForm['product_quantity'] = '';
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => ProductGridView(),), (route) => false);
                        });
                      }
                    }
                    // print(myForm);
                    },
                      child: mySuccessButtonChild('SAVE'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
