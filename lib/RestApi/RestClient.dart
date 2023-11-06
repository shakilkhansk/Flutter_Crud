
import 'dart:convert';
import 'package:crud/Style/Style.dart';
import 'package:http/http.dart' as http;

Future<bool> deleteProduct(id) async {
  var url = Uri.parse('https://nspay.a1flexi.com/api/product/'+id.toString());
  var header = {'Content-Type':'application/json'};
  var response = await http.delete(url,headers: header);
  var responseBody = jsonDecode(response.body);
  if(response.statusCode==200){
    if(responseBody['status']){
      toastSuccess(responseBody['msg']);
      return true;
    }else{
      return false;
    }
  }else{
    toastError('Request failed plz try again');
    return false;
  }
}
Future<List> getProductGridView() async {
  var url = Uri.parse('https://nspay.a1flexi.com/api/product');
  var header = {'Content-Type':'application/json'};
  var response = await http.get(url,headers: header);
  var responseBody = jsonDecode(response.body);
  if(response.statusCode==200){
    if(responseBody['status']){
      return responseBody['products'];
    }else{
      return [];
    }
  }else{
    toastError('Request failed plz try again');
    return [];
  }
}

Future<bool> productCreate(myForm) async{
  var url = Uri.parse('https://nspay.a1flexi.com/api/product');
  var header = {'Content-Type':'application/json'};
  var body = jsonEncode(myForm);

  var response = await http.post(url,headers: header,body: body);
  var responseBody = jsonDecode(response.body);
  if(response.statusCode==200){
    if(responseBody['status']){
      toastSuccess(responseBody['msg']);
      return true;
    }else{
      toastError(responseBody['msg']);
      return false;
    }
  }else{
    toastError('Request failed plz try again');
    return false;
  }
}
Future<bool> productUpdate(myForm,id) async{
  var url = Uri.parse('https://nspay.a1flexi.com/api/product/'+id);
  var header = {'Content-Type':'application/json'};
  var body = jsonEncode(myForm);
  var response = await http.put(url,headers: header,body: body);
  var responseBody = jsonDecode(response.body);
  if(response.statusCode==200){
    if(responseBody['status']){
      toastSuccess(responseBody['msg']);
      return true;
    }else{
      toastError(responseBody['msg']);
      return false;
    }
  }else{
    toastError('Request failed plz try again');
    return false;
  }
}