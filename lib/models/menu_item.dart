import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String name;
  final String type;
  final String image;
  final int rating;

  const MenuItem({
    required this.name,
    required this.type,
    required this.image,
    this.rating = 5,
  });

  @override
  List<Object?> get props => [name, type, image, rating];

  MenuItem copyWith(
      {required String name,
      required String type,
      required String image,
      int? rating}) {
    return MenuItem(
      name: name,
      type: type,
      image: image,
    );
  }
}
