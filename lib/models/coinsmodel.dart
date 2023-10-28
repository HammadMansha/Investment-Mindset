

import 'dart:convert';

List<CoinsModel> coinsModelFromJson(String str) => List<CoinsModel>.from(json.decode(str).map((x) => CoinsModel.fromJson(x)));

String coinsModelToJson(List<CoinsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoinsModel {
  CoinsModel({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.numMarketPairs,
    this.dateAdded,
    this.tags,
    this.platform,
    this.cmcRank,
    this.selfReportedCirculatingSupply,
    this.selfReportedMarketCap,
    this.tvlRatio,
    this.lastUpdated,
    this.quote,
    this.logo,
  });

  int? id;
  String? name;
  String? symbol;
  String? slug;
  int? numMarketPairs;
  DateTime? dateAdded;
  List<String>? tags;
  dynamic platform;
  int? cmcRank;
  dynamic selfReportedCirculatingSupply;
  dynamic selfReportedMarketCap;
  dynamic tvlRatio;
  DateTime? lastUpdated;
  Quote? quote;
  String? logo;

  factory CoinsModel.fromJson(Map<String, dynamic> json) => CoinsModel(
    id: json["id"],
    name: json["name"],
    symbol: json["symbol"],
    slug: json["slug"],
    numMarketPairs: json["num_market_pairs"],
    dateAdded: DateTime.parse(json["date_added"]),
    tags: List<String>.from(json["tags"].map((x) => x)),
    platform: json["platform"],
    cmcRank: json["cmc_rank"],
    selfReportedCirculatingSupply: json["self_reported_circulating_supply"],
    selfReportedMarketCap: json["self_reported_market_cap"],
    tvlRatio: json["tvl_ratio"],
    lastUpdated: DateTime.parse(json["last_updated"]),
    quote: Quote.fromJson(json["quote"]),
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "symbol": symbol,
    "slug": slug,
    "num_market_pairs": numMarketPairs,
    "date_added": dateAdded!.toIso8601String(),
    "tags": List<dynamic>.from(tags!.map((x) => x)),
    "platform": platform,
    "cmc_rank": cmcRank,
    "self_reported_circulating_supply": selfReportedCirculatingSupply,
    "self_reported_market_cap": selfReportedMarketCap,
    "tvl_ratio": tvlRatio,
    "last_updated": lastUpdated!.toIso8601String(),
    "quote": quote!.toJson(),
    "logo": logo,
  };
}

class Quote {
  Quote({
    this.usd,
  });

  Usd? usd;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    usd: Usd.fromJson(json["USD"]),
  );

  Map<String, dynamic> toJson() => {
    "USD": usd!.toJson(),
  };
}

class Usd {
  Usd({
    this.price,
    this.volume24H,
    this.volumeChange24H,
    this.percentChange1H,
    this.percentChange24H,
    this.percentChange7D,
    this.percentChange30D,
    this.percentChange60D,
    this.percentChange90D,
    this.marketCap,
    this.marketCapDominance,
    this.fullyDilutedMarketCap,
    this.tvl,
    this.lastUpdated,
  });

  double? price;
  double? volume24H;
  double? volumeChange24H;
  double? percentChange1H;
  double? percentChange24H;
  double? percentChange7D;
  double? percentChange30D;
  double? percentChange60D;
  double? percentChange90D;
  double? marketCap;
  double? marketCapDominance;
  double? fullyDilutedMarketCap;
  dynamic tvl;
  DateTime? lastUpdated;

  factory Usd.fromJson(Map<String, dynamic> json) => Usd(
    price: json["price"].toDouble(),
    volume24H: json["volume_24h"].toDouble(),
    volumeChange24H: json["volume_change_24h"].toDouble(),
    percentChange1H: json["percent_change_1h"].toDouble(),
    percentChange24H: json["percent_change_24h"].toDouble(),
    percentChange7D: json["percent_change_7d"].toDouble(),
    percentChange30D: json["percent_change_30d"].toDouble(),
    percentChange60D: json["percent_change_60d"].toDouble(),
    percentChange90D: json["percent_change_90d"].toDouble(),
    marketCap: json["market_cap"].toDouble(),
    marketCapDominance: json["market_cap_dominance"].toDouble(),
    fullyDilutedMarketCap: json["fully_diluted_market_cap"].toDouble(),
    tvl: json["tvl"],
    lastUpdated: DateTime.parse(json["last_updated"]),
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "volume_24h": volume24H,
    "volume_change_24h": volumeChange24H,
    "percent_change_1h": percentChange1H,
    "percent_change_24h": percentChange24H,
    "percent_change_7d": percentChange7D,
    "percent_change_30d": percentChange30D,
    "percent_change_60d": percentChange60D,
    "percent_change_90d": percentChange90D,
    "market_cap": marketCap,
    "market_cap_dominance": marketCapDominance,
    "fully_diluted_market_cap": fullyDilutedMarketCap,
    "tvl": tvl,
    "last_updated": lastUpdated!.toIso8601String(),
  };
}
