import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference reviewsCollection = firestore.collection('review');

void addReview(
    String movieTitle, String name, String comment, String evaluation) {
  reviewsCollection.add({
    'movie_title': movieTitle,
    'name': name,
    'comment': comment,
    'evaluation': evaluation,
    'registration_date': DateTime.now(),
  }).then((value) => print('review added'));
}

Stream<QuerySnapshot> getReviews(String moiveTitle) {
  return reviewsCollection
      .where('movie_title', isEqualTo: moiveTitle)
      .snapshots();
}
