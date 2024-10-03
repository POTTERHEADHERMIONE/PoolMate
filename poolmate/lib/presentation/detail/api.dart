import 'dart:convert';
import 'package:http/http.dart' as http;

class Source {
  final String id;
  final String address;

  Source({required this.id, required this.address});
}

class Destination {
  final String id;
  final String address;

  Destination({required this.id, required this.address});
}

class EstimatedTime {
  final String id;
  final String time;

  EstimatedTime({required this.id, required this.time});
}

class StartTime {
  final String id;
  final String time;

  StartTime({required this.id, required this.time});
}

class Card {
  final String id;
  final Source source;
  final Destination destination;
  final EstimatedTime estimatedTime;
  final StartTime startTime;

  Card({
    required this.id,
    required this.source,
    required this.destination,
    required this.estimatedTime,
    required this.startTime,
  });
}

class Api {
  static const baseUrl = "http://10.0.55.220:2000/api/";

  // Method to add a new source
  static Future<void> addSource(String address) async {
    var url = Uri.parse("${baseUrl}source");

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"address": address}),
      );

      if (res.statusCode == 201) {
        var data = jsonDecode(res.body.toString());
        print("Source added successfully: ${data['source']}");
      } else {
        print("Failed Response: Unsuccessful, Status Code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Method to get all sources
  static Future<List<Source>> getSources() async {
    List<Source> sources = [];
    var url = Uri.parse("${baseUrl}source");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        for (var value in data) {
          sources.add(Source(id: value['_id'], address: value['address']));
        }
        return sources;
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  // Method to add a new destination
  static Future<void> addDestination(String address) async {
    var url = Uri.parse("${baseUrl}destination");

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"address": address}),
      );

      if (res.statusCode == 201) {
        var data = jsonDecode(res.body.toString());
        print("Destination added successfully: ${data['destination']}");
      } else {
        print("Failed Response: Unsuccessful, Status Code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Method to get all destinations
  static Future<List<Destination>> getDestinations() async {
    List<Destination> destinations = [];
    var url = Uri.parse("${baseUrl}destination");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        for (var value in data) {
          destinations.add(Destination(id: value['_id'], address: value['address']));
        }
        return destinations;
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  // Method to add estimated time
  static Future<void> addEstimatedTime(String time) async {
    var url = Uri.parse("${baseUrl}estimatedTime");

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"time": time}),
      );

      if (res.statusCode == 201) {
        var data = jsonDecode(res.body.toString());
        print("Estimated time added successfully: ${data['estimatedTime']}");
      } else {
        print("Failed Response: Unsuccessful, Status Code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Method to get all estimated times
  static Future<List<EstimatedTime>> getEstimatedTimes() async {
    List<EstimatedTime> estimatedTimes = [];
    var url = Uri.parse("${baseUrl}estimatedTime");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        for (var value in data) {
          estimatedTimes.add(EstimatedTime(id: value['_id'], time: value['time']));
        }
        return estimatedTimes;
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  // Method to add start time
  static Future<void> addStartTime(String time) async {
    var url = Uri.parse("${baseUrl}startTime");

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"time": time}),
      );

      if (res.statusCode == 201) {
        var data = jsonDecode(res.body.toString());
        print("Start time added successfully: ${data['startTime']}");
      } else {
        print("Failed Response: Unsuccessful, Status Code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Method to get all start times
  static Future<List<StartTime>> getStartTimes() async {
    List<StartTime> startTimes = [];
    var url = Uri.parse("${baseUrl}startTime");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        for (var value in data) {
          startTimes.add(StartTime(id: value['_id'], time: value['time']));
        }
        return startTimes;
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  // Method to create a new card
  static Future<void> createCard(String sourceId, String destinationId, String estimatedTimeId, String startTimeId) async {
    var url = Uri.parse("${baseUrl}card");

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "sourceId": sourceId,
          "destinationId": destinationId,
          "estimatedTimeId": estimatedTimeId,
          "startTimeId": startTimeId
        }),
      );

      if (res.statusCode == 201) {
        var data = jsonDecode(res.body.toString());
        print("Card created successfully: ${data['card']}");
      } else {
        print("Failed Response: Unsuccessful, Status Code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Method to get all cards
  static Future<List<Card>> getCards() async {
    List<Card> cards = [];
    var url = Uri.parse("${baseUrl}card");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        for (var value in data) {
          cards.add(Card(
            id: value['_id'],
            source: Source(id: value.source['_id'], address: value.source['address']),
            destination: Destination(id: value.destination['_id'], address: value.destination['address']),
            estimatedTime: EstimatedTime(id: value.estimatedTime['_id'], time: value.estimatedTime['time']),
            startTime: StartTime(id: value.startTime['_id'], time: value.startTime['time']),
          ));
        }
        return cards;
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  // Method to get a card by ID
  static Future<Card?> getCardById(String id) async {
    var url = Uri.parse("${baseUrl}card/$id");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        return Card(
          id: data['_id'],
          source: Source(id: data.source['_id'], address: data.source['address']),
          destination: Destination(id: data.destination['_id'], address: data.destination['address']),
          estimatedTime: EstimatedTime(id: data.estimatedTime['_id'], time: data.estimatedTime['time']),
          startTime: StartTime(id: data.startTime['_id'], time: data.startTime['time']),
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // Method to update a card
  static Future<void> updateCard(String id, String sourceId, String destinationId, String estimatedTimeId, String startTimeId) async {
    var url = Uri.parse("${baseUrl}card/$id");

    try {
      final res = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "sourceId": sourceId,
          "destinationId": destinationId,
          "estimatedTimeId": estimatedTimeId,
          "startTimeId": startTimeId,
        }),
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print("Card updated successfully: ${data['card']}");
      } else {
        print("Failed Response: Unsuccessful, Status Code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Method to delete a card
  static Future<void> deleteCard(String id) async {
    var url = Uri.parse("${baseUrl}card/$id");

    try {
      final res = await http.delete(url);
      if (res.statusCode == 200) {
        print("Card deleted successfully");
      } else {
        print("Failed Response: Unsuccessful, Status Code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
