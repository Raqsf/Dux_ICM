class CardClass {
  String title;
  //Map schedule;
  String startTime;
  String endTime;
  String place;

  CardClass(this.title, this.startTime, this.endTime, this.place);
}

var cardData = [
  {
    "title": "Biology",
    "start": "10",
    "end": "11",
    "place": "4.1.2",
  },
  {
    "title": "Maths",
    "start": "13",
    "end": "14",
    "place": "4.1.2",
  },
];

var eventData = [
  {
    "title": "Meeting",
    "start": "9",
    "end": "10",
    "place": "Building",
  },
  {
    "title": "Workout",
    "start": "16",
    "end": "17",
    "place": "Gym",
  },
];

List<CardClass> cards = cardData
    .map(
      (item) => CardClass(
        item['title'].toString(),
        item['start'].toString(),
        item['end'].toString(),
        item['place'].toString(),
      ),
    )
    .toList();

List<CardClass> cardsEvent = eventData
    .map(
      (item) => CardClass(
        item['title'].toString(),
        item['start'].toString(),
        item['end'].toString(),
        item['place'].toString(),
      ),
    )
    .toList();
