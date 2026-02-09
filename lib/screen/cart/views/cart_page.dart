import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizzadelivery/screen/cart/blocs/bloc/cart_bloc.dart';
import 'package:pizzadelivery/screen/cart/components/quantity.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // App Bar
        appBar: AppBar(
          
          title: Text(
            "My Cart",
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
            
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            child: GestureDetector(
          onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12), // Soft rounded corners
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.2), // Modern thin border
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 24,
              ),
            ),
        ),
          ),
        ),

        // Body
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            
            // loading state
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator()
              );
            } 
            
            // loaded state
            else if (state is CartLoaded) {
              final items = state.items;
              return Column(
                children: [
                  // total of items
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Items (${items.length})",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        // Empty cart 
                        TextButton(
                          onPressed: () {
                            context.read<CartBloc>().add(ClearCart());
                          },
                          child: Text(
                            "Empty Cart",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.25,
                            motion: const ScrollMotion(),
                            children: [
                              // Custom delete action
                             CustomSlidableAction(
                                onPressed: (context) {
                                  context.read<CartBloc>().add(
                                    RemoveFromCart(item.pizzaId),
                                  );
                                },
                                // We use transparent background for the pane so our custom container pops
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                // 
                                child: Container(
                                  width: 65,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    // Using a soft red background (Latest Flutter syntax)
                                    color: Colors.red.withValues(alpha: 0.08), 
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.red.withValues(alpha: 0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.delete_simple,
                                    color: Colors.red,
                                    size: 28,
                                  ),
                              ),
                             )
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15
                            ),
                          
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                          
                            child: Row(
                              children: [
                                // image
                                Image.network(
                                  item.image, 
                                  width: 80, 
                                  height: 80
                                ),
                                const SizedBox(width: 12),
                                          
                                // details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // name
                                      Text(
                                        item.name,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                          
                                      Row(
                                        children: [
                                          // VEG or NON-VEG
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6.0, vertical: 4.0
                                            ),
                                            decoration: BoxDecoration(
                                              color: item.isVeg ? Colors.green : Colors.red,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              item.isVeg ? "VEG" : "NON-VEG",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                          
                                          // Spicy level
                                          Container(
                                            decoration: BoxDecoration(
                                              color: item.spicyLabel == 1 ? Colors.orange :
                                                     item.spicyLabel == 2 ? Colors.redAccent :
                                                     item.spicyLabel == 3 ? Colors.red : Colors.transparent,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
                                              child: Text(
                                                item.spicyLabel == 1 ? "🌶️ NORMAL" : 
                                                item.spicyLabel == 2 ? "🌶️ MILD" : 
                                                item.spicyLabel == 3 ? "🌶️ SPICY": "",
                                              
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                          
                                      // price and quantity controller 
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '\$${item.price}',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                          
                                              // discount
                                              Text(
                                                '\$${item.discount}',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.green.shade700,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                                
                                              )
                                            ],
                                          ),
                          
                                          BlocSelector<CartBloc, CartState, int>(
                                            selector: (state) {
                                              // If state IS CartLoaded, return the item's quantity
                                              if (state is CartLoaded) {
                                                for (final cartItem in state.items) {
                                                  if (cartItem.pizzaId == item.pizzaId) {
                                                    return cartItem.quantity;
                                                  }
                                                }
                                              }
                                              // Fallback if item not found or state isn't loaded
                                              return 0;
                                            },
                                            builder: (context, qty) => QuantityController(
                                              quantity: qty,
                                              onIncrement: () {
                                                context.read<CartBloc>().add(
                                                  IncrementCartItem(itemId: item.pizzaId),
                                                );
                                              },
                                              onDecrement: () {
                                                context.read<CartBloc>().add(
                                                  DecrementCartItem(itemId: item.pizzaId),
                                                );
                                              },
                                            ),
                                          ),
                          
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                          
                                   
                                    
                                    ],
                                  ),
                                ),
                          
                              ],
                            ),
                          ),
                        );
                      
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Checkout
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE94000),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                          "Checkout",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                      )
                    ),
                  )
                ],
              );
            } 
            
            // empty cart
            else {
              return const Center(child: Text("Cart is empty"));
            }
          },
        ),
        
    );
  }
}
