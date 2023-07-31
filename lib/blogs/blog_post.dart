class BlogPost {
  String image;
  String description;
  String date;
  String time;

  BlogPost(
      {required this.image,
      required this.description,
      required this.date,
      required this.time});

  factory BlogPost.fromSnapshot(Map<dynamic, dynamic> snapshot) {
    return BlogPost(
      image: snapshot['image'],
      description: snapshot['description'],
      date: snapshot['date'],
      time: snapshot['time'],
    );
  }

  @override
  String toString() {
    return 'BlogPost{image: $image, description: $description, date: $date, time: $time}';
  }
}
