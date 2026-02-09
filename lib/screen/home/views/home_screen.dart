import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzadelivery/screen/auth/blocs/sign_in_bloc/bloc/sign_in_bloc.dart';
import 'package:pizzadelivery/screen/cart/blocs/bloc/cart_bloc.dart';
import 'package:pizzadelivery/screen/cart/views/cart_page.dart';
import 'package:pizzadelivery/screen/home/blocs/get_pizza/get_pizza_bloc.dart';
import 'package:pizzadelivery/screen/home/views/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          // logo and title
          title: Row(
            children: [
              // logo
              Image.asset(
                "assets/8.png",
                scale: 14,
              ),
              const SizedBox(
                width: 10,
              ),

              // title
              const Text(
                'Pizza Delivery',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),

          // cart and logout
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => CartBloc(
                          FirebaseCartRepo()
                        ),
                        child: const CartPage(),
                      ),
                    ));
              },
              icon: const Icon(
                CupertinoIcons.cart,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: const Icon(Icons.logout),
            ),
          ],

          // border at the bottom of appbar
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.shade300,
              height: 0.6,
            ),
          ),
        ),
        body: BlocBuilder<GetPizzaBloc, GetPizzaState>(
          builder: (context, state) {
            // success state
            if (state is GetPizzaSuccess) {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 5.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 14, // Spacing between columns
                    mainAxisSpacing: 16, // Spacing between rows
                    childAspectRatio: 0.43, // width / height
                  ),
                  itemCount: state.pizzas.length,
                  itemBuilder: (context, index) {
                    return Material(
                      elevation: 2, // shadow effect
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: InkWell(
                        onTap: () {
                          // Navigate to detais screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  pizza: state.pizzas[index],
                                ),
                              ));
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image
                              Image.network(
                                state.pizzas[index].picture,
                              ),

                              // Product details
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 11.0),
                                child: Row(
                                  children: [
                                    // Veg/Non-Veg Indicator
                                    Container(
                                      decoration: BoxDecoration(
                                        color: state.pizzas[index].isVeg
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        child: Text(
                                          state.pizzas[index].isVeg
                                              ? "VEG"
                                              : "NON-VEG",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),

                                    // SPICY LABEL
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        child: Text(
                                          state.pizzas[index].spicy == 1
                                              ? "🌶️ NORMAL"
                                              : state.pizzas[index].spicy == 2
                                                  ? "🌶️ MILD"
                                                  : state.pizzas[index].spicy ==
                                                          3
                                                      ? "🌶️ SPICY"
                                                      : "",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),

                              // Product Name
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 11.0),
                                child: Text(
                                  "${state.pizzas[index].name} ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),

                              // Product Description
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "${state.pizzas[index].description} ",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),

                              // Product Price
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      // discounted price
                                      Text(
                                        "\$${state.pizzas[index].price - (state.pizzas[index].price * (state.pizzas[index].discount / 100))}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),

                                      //  original price
                                      Text(
                                        "\$${state.pizzas[index].discount}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ]),
                                    IconButton(
                                        onPressed: () {
                                          // add to cart 
                                          context.read<CartBloc>().add(
                                              AddToCart(
                                                item: CartItem(
                                                  pizzaId: state.pizzas[index].pizzaId,
                                                  name: state.pizzas[index].name,
                                                  price: state.pizzas[index].price,
                                                  image: state.pizzas[index].picture,
                                                  spicyLabel: state.pizzas[index].spicy,
                                                  isVeg: state.pizzas[index].isVeg, 
                                                  discount: state.pizzas[index].discount,
                                                  quantity: 1,
                                              ))
                                          );
                                        },
                                        icon: const Icon(
                                            CupertinoIcons.add_circled_solid)),
                                  ],
                                ),
                              )
                            ]),
                      ),
                    );
                  },
                ),
              );
            }

            // empty pizza state
            else if (state is GetPizzaFailure) {
              return const Center(
                child: Text("Failed to load pizzas"),
              );
            }

            // loading state
            else {
              return const Center(
                child: Text("Failed to load pizzas"),
              );
            }
          },
        ));
  }
}
