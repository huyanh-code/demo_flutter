import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookCard extends StatelessWidget {
  final String bookName;
  final String author;
  final String price;
  final String rating;
  final String details;
  final String imageUrl;

  const BookCard({
    super.key,
    required this.bookName,
    required this.author,
    required this.price,
    required this.rating,
    required this.details,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            // Hình ảnh bên trái
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                height: 100,
                width: 70, 
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15), 

            // Nội dung bên phải
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    author,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    details,
                    maxLines: 2, // Số dòng tối đa hiển thị
                    overflow: TextOverflow.ellipsis, // Hiển thị dấu ba chấm
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const SizedBox(height: 5),
                      // RatingBarIndicator(
                      //   rating: double.parse(rating),
                      //   itemBuilder: (context, index) => const Icon(
                      //     Icons.star,
                      //     color: Colors.amber,
                      //   ),
                      //   itemCount: 5,
                      //   itemSize: 18.0,
                      //   direction: Axis.horizontal,
                      // ),
                      // const SizedBox(width: 5),
                      // Text(
                      //   rating,
                      //   style: const TextStyle(fontSize: 12),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 12,
                            ),
                            const SizedBox(width: 5), // Khoảng cách giữa ngôi sao và số điểm
                            Text(
                              rating,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 100,),
                      Text(
                        price,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:  Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
