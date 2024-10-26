class Books {
  final int? id;
  final String name;
  final String details;
  final double price;
  final DateTime publishDate;
  final String coverImgUrl;

  Books({
      required this.id,
      required this.name,
      required this.details,
      required this.price,
      required this.publishDate,
      required this.coverImgUrl
    });

  factory Books.fromJson(Map<String, dynamic> json){
    try{
    return Books(
      id: json['id'],
      name: json['name'], 
      details: json['details'], 
      price: json['price'], 
      publishDate: DateTime.parse(json['publishDate']), 
      coverImgUrl: json['coverImgUrl']
    );
    }catch (e) {
    print('Error parsing book: $e'); // Log chi tiết lỗi
    throw e; // Ném lại lỗi để xử lý ở nơi khác nếu cần
  }
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name': name,
      'details': details,
      'price': price,
      'publishDate': publishDate,
      'coverImgUrl': coverImgUrl
    };
  }  

  @override
  String toString() {
    return 'Books {id: $id, name: $name, details: $details, price: $price, publishDate: $publishDate}';
  }
}
