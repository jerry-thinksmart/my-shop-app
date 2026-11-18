import 'package:flutter/material.dart';
import 'package:my_shop_app/provider/brand.dart';
import 'package:provider/provider.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  final title = TextEditingController();
  final description = TextEditingController();
  final imageUrl = TextEditingController();
  BrandModel brand = BrandModel(
    // id: '',
    title: '',
    description: '',
    imageUrl: '',
  );

  void dispose() {
    title.dispose();
    description.dispose();
    imageUrl.dispose();
    super.dispose();
  }

  Future<void> uploadBrand() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Brand>(context, listen: false).addBrand(brand);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      "Add a brand",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight(600),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: title,

                      onSaved: (value) {
                        brand.title = value!;
                      },
                      onChanged: null,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length <= 3) {
                          return "Please check what you entered and try again";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Brand Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: description,
                      onSaved: (value) {
                        brand.description = value!;
                      },
                      onChanged: null,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length <= 3) {
                          return "Please check what you entered and try again";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Brand Description",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: imageUrl,
                      onSaved: (value) {
                        brand.imageUrl = value!;
                      },
                      onChanged: null,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length <= 3) {
                          return "Please check what you entered and try again";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Image Url",
                        border: OutlineInputBorder(),
                      ),
                    ),

                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () => uploadBrand(),
                            child: Text("Submit Form"),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
