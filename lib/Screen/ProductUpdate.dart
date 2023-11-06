import 'package:crud/Screen/ProductGridView.dart';
import 'package:crud/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../RestApi/RestClient.dart';

class ProductUpdate extends StatefulWidget {
  final Map productList;
  const ProductUpdate({super.key, required this.productList});
  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {

  final _form = GlobalKey<FormState>();
  final _Name = TextEditingController();
  final _id = TextEditingController();
  final _Code = TextEditingController();
  final _Image = TextEditingController();
  final _total_price = TextEditingController();
  final _unit_price = TextEditingController();

  @override
  void initState(){
    setState(() {
      _id.text =  widget.productList['id'].toString();
      myForm.update('product_name', (value) => widget.productList['product_name']);
      myForm.update('product_code', (value) => widget.productList['product_code']);
      myForm.update('product_img', (value) => widget.productList['product_img']);
      myForm.update('unit_price', (value) => widget.productList['unit_price']);
      myForm.update('total_price', (value) => widget.productList['total_price']);
      _Name.text =  widget.productList['product_name'];
      _Code.text =  widget.productList['product_code'];
      _Image.text =  widget.productList['product_img'];
      _unit_price.text =  widget.productList['unit_price'];
      _total_price.text =  widget.productList['total_price'];
      myForm['product_quantity'] = widget.productList['product_quantity'];
    });
    super.initState();
  }
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
        title: const Text('Product Update'),
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
                      bool sk = await productUpdate(myForm,_id.text);
                      print(sk);
                      if(sk){
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => ProductGridView(),), (route) => false);
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
