import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  List items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Transactions"),
        ),
      body: ListView.builder(itemCount: items.length  , itemBuilder: (context, index){
        final item = items[index];
        return ListTile(
          leading : CircleAvatar(child: Text(item['id'].toString()),),
          title : Text(item['nom']),
          subtitle : Text(item['description']),
          // subtitle : Text(item['ministere']),
        );
      },),
    );
  }

  Future<void> fetchTransactions() async {
    const url = 'http://192.168.9.58:8081/fin/transaction';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    
    // print(response);
    if(response.statusCode == 200){
      final json= jsonDecode(response.body);
      final result = json as List;
      setState(() {
        items = result;
      });
      print(items);
      // print(json);
      // print(result);
    }else{
      print("error fetching data");
    }

  }
}
