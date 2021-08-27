import 'package:bloc_test/bloc_test.dart';
import 'package:buutti_ravintola/blocs/cart/cart.dart';
import 'package:buutti_ravintola/models/menu_item.dart';
// import 'package:test/test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MenuItem menuitemBurger =
      MenuItem(name: 'burger', type: 'main', image: 'imagefromfirebase');
  const MenuItem menuitemTaco =
      MenuItem(name: 'taco', type: 'main', image: 'imagefromfirebase');

  group('YOUR GROUP OF TESTS', () {
    blocTest<CartBloc, CartState>('emits [] when nothing is added',
        build: () => CartBloc(), expect: () => []);
    blocTest<CartBloc, CartState>('when AddMenuItem is called ',
        build: () => CartBloc(),
        act: (bloc) => bloc.add(const AddMenuItem(menuitemBurger)),
        expect: () => const <CartState>[
              CartState(menuItems: [menuitemBurger])
            ]);
    blocTest<CartBloc, CartState>('when DeleteMenuItem is called ',
        build: () => CartBloc(),
        act: (bloc) {
          bloc.add(const AddMenuItem(menuitemBurger));
          bloc.add(const DeleteMenuItem(menuitemTaco));
        },
        expect: () => const <CartState>[
              CartState(menuItems: [menuitemBurger])
            ]);
    blocTest<CartBloc, CartState>('when DeleteAllMenuItem is called ',
        build: () => CartBloc(),
        act: (bloc) {
          bloc.add(const AddMenuItem(menuitemBurger));
          bloc.add(const AddMenuItem(menuitemTaco));
          bloc.add(const DeleteAllMenuItem());
        },
        skip: 2,
        expect: () => [const CartState(menuItems: [])]);
  });
}
