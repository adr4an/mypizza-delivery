import 'package:flutter/material.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:pizzadelivery/components/macro.dart';

class DetailsScreen extends StatelessWidget {
  final Pizza pizza; 

  const DetailsScreen({
    super.key,
    required this.pizza,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: [

            // Product Image
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - (40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(3, 2),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(
                    pizza.picture
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),
        
            // Product Title + Price
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    // Title + Price
                    Row(
                      children: [
                        Expanded(
                          flex: 2, 
                          child: Text(
                            pizza.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            
                          ),
                          
                        ),
                
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: [
                                // Discounted Price
                                Text(
                                  // "\$199",
                                  "\$${pizza.price - (pizza.price * (pizza.discount / 100))}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                            
                                // Original Price
                                Text(
                                  // "\$249",
                                  "\$${pizza.discount}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 12,
                                  ),
                                ),
                            
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Macros Details
                    Row(children: [
                      // Calories
                      MyMacroWidget(
                        title: "Calories",
                        macro: "${pizza.macros.calories} kcal",
                        icon: Icons.local_fire_department,
                      ),
                      const SizedBox(width: 10),

                      // Protein
                      MyMacroWidget(
                        title: "Protein",
                        macro: "${pizza.macros.protein} g",
                        icon: Icons.fitness_center,
                      ),
                      const SizedBox(width: 10),

                      // Carbs
                      MyMacroWidget(
                        title: "Carbs",
                        macro: "${pizza.macros.carbs} g",
                        icon: Icons.breakfast_dining,
                      ),
                      const SizedBox(width: 10),

                      // Fats
                      MyMacroWidget(
                        title: "Fats",
                        macro: "${pizza.macros.fat} g",
                        icon: Icons.opacity,
                      ),

                      
                    ],),
                    const SizedBox(height: 30),

                    // Buy Now Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          // Handle Buy Now action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}