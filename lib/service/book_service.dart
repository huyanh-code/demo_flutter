import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:namer_app/common/constants.dart';
import 'package:namer_app/widgets/book_api.dart';

class BookService {
  final Logger logger = Logger((BookService).toString());

  Future<List<Books>> getBooks() async {
    try {
      logger.fine('Bat dau fetch data');
      final response =
          await http.get(Uri.parse(ApiConstants.bookApi), headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        logger.fine('Got book list $jsonResponse');

        final result =
            jsonResponse.map((books) => Books.fromJson(books)).toList();
        logger.fine('Parsed data $result');

        return result;
      } else {
        throw Exception('Faild to load books');
      }
    } on Exception catch (e) {
      if (e is http.ClientException) {
        logger.warning('ClientException ${e.message}');
      }

      logger.warning('Co loi gi do da xay ra $e');

      rethrow;
    }
  }

  Future<List<Books>> searchBooks(String name) async {
    try {
      logger.fine('Tìm kiếm sách với truy vấn: $name');
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.bookApi}/search?name=$name'), // Điều chỉnh endpoint nếu cần
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        logger.fine('Nhận kết quả tìm kiếm: $jsonResponse');

        final result =
            jsonResponse.map((books) => Books.fromJson(books)).toList();
        logger.fine('Kết quả tìm kiếm đã phân tích: $result');

        return result;
      } else {
        throw Exception('Không thể tìm kiếm sách');
      }
    } on Exception catch (e) {
      if (e is http.ClientException) {
        logger.warning('Lỗi ClientException ${e.message}');
      }

      logger.warning('Có lỗi xảy ra: $e');
      rethrow;
    }
  }

  Future<Books> createBooks(Books books) async {
    final response = await http.post(
      Uri.parse(ApiConstants.bookApi),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(books.toJson()),
    );
    if (response.statusCode == 200) {
      return Books.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to create books");
    }
  }

  Future<Books> updateBooks(Books books) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.bookApi}/${books.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(books.toJson()),
    );
    if (response.statusCode == 200) {
      return Books.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update books');
    }
  }

  Future<void> deleteBooks(int id) async {
    final response =
        await http.delete(Uri.parse('${ApiConstants.bookApi}/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete books');
    }
  }
}
