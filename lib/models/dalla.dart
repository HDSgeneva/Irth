class TimeSuggestion {
  const TimeSuggestion({
    required this.dayLabel,
    required this.timeRangeLabel,
    required this.reason,
  });

  final String dayLabel;
  final String timeRangeLabel;
  final String reason;
}

class PlaceSuggestion {
  const PlaceSuggestion({
    required this.name,
    required this.category,
    required this.rating,
    required this.priceLabel,
    required this.reason,
  });

  final String name;
  final String category;
  final double rating;
  final String priceLabel;
  final String reason;
}

class FlightLeg {
  const FlightLeg({
    required this.route,
    required this.dayLabel,
    required this.timeRangeLabel,
    required this.airline,
    required this.priceLabel,
  });

  final String route;
  final String dayLabel;
  final String timeRangeLabel;
  final String airline;
  final String priceLabel;
}

class LeaveSuggestion {
  const LeaveSuggestion({required this.personName, required this.note});

  final String personName;
  final String note;
}

class TripPlan {
  const TripPlan({
    required this.destination,
    required this.dateRangeLabel,
    required this.travelerCount,
    required this.totalBudgetLabel,
    required this.whyHere,
    required this.outboundFlight,
    required this.returnFlight,
    required this.hotelName,
    required this.hotelRating,
    required this.hotelNote,
    required this.hotelPriceLabel,
    required this.leaveSuggestions,
  });

  final String destination;
  final String dateRangeLabel;
  final int travelerCount;
  final String totalBudgetLabel;
  final String whyHere;
  final FlightLeg outboundFlight;
  final FlightLeg returnFlight;
  final String hotelName;
  final double hotelRating;
  final String hotelNote;
  final String hotelPriceLabel;
  final List<LeaveSuggestion> leaveSuggestions;
}
