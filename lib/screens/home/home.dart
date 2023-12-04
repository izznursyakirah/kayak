import 'package:flutter/material.dart';
import 'package:kayak/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:kayak/models/category_model/category_model.dart';
import 'package:kayak/models/product_model/product_model.dart';
import 'package:kayak/widgets/top_titles/top_titles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  Future<void> getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    try {
      categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
      productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
    } catch (error) {
      print("Error fetching categories: $error");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopTitles(subtitle: "", title: "Kayak Booking"),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Search........."),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        const Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                  ? Center(
                    child: Text("Categories is Empty"),
                  )
                  : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categoriesList
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Card(
                                color: Colors.white,
                                elevation: 6.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(e.image),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0, left: 12.0),
                    child: Text(
                      "List of Kayak",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  productModelList.isEmpty
                  ? const Center(
                    child: Text("List of Kayak is Empty"),
                  )
                  : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: productModelList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                childAspectRatio: 0.9,
                                crossAxisCount: 2),
                        itemBuilder: (ctx, index) {
                          ProductModel singleProduct = productModelList[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: [
                                Image.network(
                                  singleProduct.image,
                                  height: 60,
                                  width: 60,
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  singleProduct.name,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("Price: RM${singleProduct.price}"),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                SizedBox(
                                  height: 45,
                                  width: 140,
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "BOOK",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}

