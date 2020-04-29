
// To parse this JSON data, do
//
//     final worldPopulation = worldPopulationFromJson(jsonString);

import 'dart:convert';

class WorldPopulation {
    bool ok;
    Body body;

    WorldPopulation({
        this.ok,
        this.body,
    });

    factory WorldPopulation.fromJson(String str) => WorldPopulation.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory WorldPopulation.fromMap(Map<String, dynamic> json) => WorldPopulation(
        ok: json["ok"],
        body: Body.fromMap(json["body"]),
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "body": body.toMap(),
    };
}

class Body {
    int worldPopulation;
    int totalCountries;

    Body({
        this.worldPopulation,
        this.totalCountries,
    });

    factory Body.fromJson(String str) => Body.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Body.fromMap(Map<String, dynamic> json) => Body(
        worldPopulation: json["world_population"],
        totalCountries: json["total_countries"],
    );

    Map<String, dynamic> toMap() => {
        "world_population": worldPopulation,
        "total_countries": totalCountries,
    };
}
