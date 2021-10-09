import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:FirebaseEcommerce/services/Firebase/firebase.dart';

final firebaseProvider = Provider((ref) => FirebaseServices());

// final initializingAppProvider = FutureProvider<FirebaseApp>((ref) {
//   return ref.watch(firebaseProvider).initializingApp();
// });

final productsFutureProvider = FutureProvider.autoDispose((ref) {
  ref.maintainState = true;
  return ref.watch(firebaseProvider).getProducts;
});

final productProvider = FutureProvider.family(
    (ref, id) => ref.watch(firebaseProvider).getProduct(id));

final userIdProvider =
    Provider<String>((ref) => ref.watch(firebaseProvider).getUserId);

final addToCartProvider = FutureProvider.family((ref, productID) async {
  return await ref.watch(firebaseProvider).addToCart(productID);
});

final cartItemsListProvider = StreamProvider.autoDispose((ref) {
  ref.maintainState = true;
  final firebase = ref.watch(firebaseProvider);
  final items = firebase.getCartItems();
  return items;
});
