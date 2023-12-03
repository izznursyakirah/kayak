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

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoading?Center(child: Container(
        height:100,
        width: 100,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
        ),
        ) 
        :SingleChildScrollView(
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
                    decoration:
                        const InputDecoration(hintText: "Search........."),
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
            SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: bestProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.9,
                      crossAxisCount: 2),
                  itemBuilder: (ctx, index) {
                    ProductModel singleProduct = bestProducts[index];
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


List<ProductModel> bestProducts = [
  ProductModel(
    image:
        "https://static.vecteezy.com/system/resources/previews/023/337/469/original/ai-generative-blue-sport-kayak-isolated-on-transparent-background-free-png.png",
    id: "1",
    name: "Recretional Kayak",
    price: "10",
    description: "1 PAX ONLY",
    status: "pending",
    isFavourite: false,
  ),
  ProductModel(
    image:
        "https://zegulkayaks.com/media/catalog/product/cache/6dff74de1816e082be83f14edf7b50c7/k/a/kailua.png",
    id: "2",
    name: "Touring Kayak",
    price: "15",
    description: "2 PAX ONLY",
    status: "pending",
    isFavourite: false,
  ),
  ProductModel(
    image: "https://www.pngmart.com/files/23/Kayak-PNG-Isolated-Photo.png",
    id: "3",
    name: "Tandem Kayak",
    price: "20",
    description: "2 PAX ONLY",
    status: "pending",
    isFavourite: false,
  ),
  ProductModel(
    image:
        "https://wheelfunrentals.com/wp-content/uploads/2021/04/AG-Small-Swan-Pedal-Boat-1024x819.png",
    id: "50",
    name: " Open Paddle Boat",
    price: "4",
    description: "5 PAX ONLY",
    status: "pending",
    isFavourite: false,
  ),
  ProductModel(
    image:
        "https://i.pinimg.com/originals/7d/dc/ca/7ddcca02c4732ea8fe14ab6217b8a444.png",
    id: "25",
    name: "Canopy Paddle Boat",
    price: "5",
    description: "2 PAX ONLY",
    status: "pending",
    isFavourite: false,
  ),
  ProductModel(
    image:
        "https://shop.prokayaks.com.au/cdn/shop/products/Contour-Boat-Cadet-3-simple_1_grande.png?v=1615437179",
    id: "6",
    name: "Swan Paddle Boat",
    price: "40",
    description: "2 PAX ONLY",
    status: "pending",
    isFavourite: false,
  ),
];
