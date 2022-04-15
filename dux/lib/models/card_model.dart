class CardClass {
  String className;
  //Map schedule;
  String startTime;
  String endTime;
  String room;
  int cardBackground;
  int secondColor;

  CardClass(this.className, this.startTime, this.endTime, this.room,
      this.cardBackground, this.secondColor);
}

var cardData = [
  {
    "className": "Biology",
    "start": "10",
    "end": "12",
    "room": "4.1.2",
    "cardBackground": 0xFFFF7648,
    "cardSecondColor": 0xFFFFC278,
  },
  {
    "className": "Maths",
    "start": "13:30",
    "end": "15:30",
    "room": "4.1.2",
    "cardBackground": 0xFF8F98FF,
    "cardSecondColor": 0xFF182A88,
  },
];

List<CardClass> cards = cardData
    .map(
      (item) => CardClass(
          item['className'].toString(),
          item['start'].toString(),
          item['end'].toString(),
          item['room'].toString(),
          int.parse(item['cardBackground'].toString()),
          int.parse(item['cardSecondColor'].toString())),
    )
    .toList();


// List<CardModel> cards = cardData.map((item) => CardModel(item['']));

// var cardData = [
//   {"class": "Biology", "day": "monday", "start": 10, "duration": 2}
// ];
