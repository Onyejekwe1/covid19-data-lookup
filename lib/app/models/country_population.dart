// To parse this JSON data, do
//
//     final countryPopulation = countryPopulationFromJson(jsonString);

import 'dart:convert';

class CountryPopulation {
    bool ok;
    Body body;

    CountryPopulation({
        this.ok,
        this.body,
    });

    factory CountryPopulation.fromJson(String str) => CountryPopulation.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CountryPopulation.fromMap(Map<String, dynamic> json) => CountryPopulation(
        ok: json["ok"],
        body: Body.fromMap(json["body"]),
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "body": body.toMap(),
    };
}

class Body {
    String countryName;
    int population;
    int ranking;
    double worldShare;

    Body({
        this.countryName,
        this.population,
        this.ranking,
        this.worldShare,
    });

    factory Body.fromJson(String str) => Body.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Body.fromMap(Map<String, dynamic> json) => Body(
        countryName: json["country_name"],
        population: json["population"],
        ranking: json["ranking"],
        worldShare: json["world_share"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "country_name": countryName,
        "population": population,
        "ranking": ranking,
        "world_share": worldShare,
    };
}
