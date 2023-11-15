import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_bloc.dart';
import 'produk.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: BlocListener<AuthenticationBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => ProdukListPage()),
              );
            }
          },
          child: LoginForm(authBloc: authBloc),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final AuthenticationBloc authBloc;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginForm({required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Silakan masukkan username', 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Silakan masukkan password', 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              authBloc.add(
                LoginEvent(
                  username: usernameController.text,
                  password: passwordController.text,
                ),
              );
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}



class ProdukListPage extends StatelessWidget {
  final List<Produk> produks = [
    Produk(id: 1, name: 'oreo', price: 8000),
    Produk(id: 2, name: 'potabee', price: 6000),
    Produk(id: 3, name: 'julie sandwich', price: 6000),
    Produk(id: 4, name: 'chupa chups', price: 1500),
    Produk(id: 5, name: 'mintz', price: 4000),
    Produk(id: 6, name: 'pringles', price: 15000),
    Produk(id: 7, name: 'twistko', price: 3000),
    Produk(id: 8, name: 'serena sandwich', price: 5000),
    Produk(id: 9, name: 'cadbury', price: 6900),
    Produk(id: 10, name: 'piattos', price: 4000),
    Produk(id: 11, name: 'doritos', price: 10000),
    Produk(id: 12, name: 'roma sari gandum', price: 6000),
    Produk(id: 13, name: 'regal', price: 8900),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Harga Produk')),
      body: ListView.builder(
        itemCount: produks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(produks[index].name),
            subtitle: Text('RP: ${produks[index].price.toString()}'),
          );
        },
      ),
    );
  }
}
