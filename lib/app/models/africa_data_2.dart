// To parse this JSON data, do
//
//     final claimStatusModel = claimStatusModelFromJson(jsonString);

import 'dart:convert';

class SecondAfricaModel {
    String type;
    List<Feature> features;

    SecondAfricaModel({
        this.type,
        this.features,
    });

    factory SecondAfricaModel.fromJson(String str) => SecondAfricaModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SecondAfricaModel.fromMap(Map<String, dynamic> json) => SecondAfricaModel(
        type: json["type"],
        features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
    };
}

class Feature {
    FeatureType type;
    Properties properties;
    Geometry geometry;

    Feature({
        this.type,
        this.properties,
        this.geometry,
    });

    factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        type: featureTypeValues.map[json["type"]],
        properties: Properties.fromMap(json["properties"]),
        geometry: Geometry.fromMap(json["geometry"]),
    );

    Map<String, dynamic> toMap() => {
        "type": featureTypeValues.reverse[type],
        "properties": properties.toMap(),
        "geometry": geometry.toMap(),
    };
}

class Geometry {
    GeometryType type;
    List<List<List<dynamic>>> coordinates;

    Geometry({
        this.type,
        this.coordinates,
    });

    factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: geometryTypeValues.map[json["type"]],
        coordinates: List<List<List<dynamic>>>.from(json["coordinates"].map((x) => List<List<dynamic>>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
    );

    Map<String, dynamic> toMap() => {
        "type": geometryTypeValues.reverse[type],
        "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
    };
}

enum GeometryType { POLYGON, MULTI_POLYGON }

final geometryTypeValues = EnumValues({
    "MultiPolygon": GeometryType.MULTI_POLYGON,
    "Polygon": GeometryType.POLYGON
});

class Properties {
    
    dynamic popEst;
    
    
    dynamic confirmed;
    dynamic deaths;
    dynamic active;
    dynamic recovered;

    Properties({
        
        this.popEst,
        
        this.confirmed,
        this.deaths,
        this.active,
        this.recovered,
    });

    factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Properties.fromMap(Map<String, dynamic> json) => Properties(
       
        popEst: json["pop_est"],
        
        confirmed: json["confirmed"],
        deaths: json["deaths"],
        active: json["active"],
        recovered: json["recovered"],
    );

    Map<String, dynamic> toMap() => {
       
        "pop_est": popEst,
       
        "confirmed": confirmed,
        "deaths": deaths,
        "active": active,
        "recovered": recovered,
    };
}

enum Continent { AFRICA }

final continentValues = EnumValues({
    "Africa": Continent.AFRICA
});

enum Economy { THE_6_DEVELOPING_REGION, THE_7_LEAST_DEVELOPED_REGION, THE_5_EMERGING_REGION_G20 }

final economyValues = EnumValues({
    "5. Emerging region: G20": Economy.THE_5_EMERGING_REGION_G20,
    "6. Developing region": Economy.THE_6_DEVELOPING_REGION,
    "7. Least developed region": Economy.THE_7_LEAST_DEVELOPED_REGION
});

enum IncomeGrp { THE_4_LOWER_MIDDLE_INCOME, THE_3_UPPER_MIDDLE_INCOME, THE_5_LOW_INCOME, THE_2_HIGH_INCOME_NON_OECD }

final incomeGrpValues = EnumValues({
    "2. High income: nonOECD": IncomeGrp.THE_2_HIGH_INCOME_NON_OECD,
    "3. Upper middle income": IncomeGrp.THE_3_UPPER_MIDDLE_INCOME,
    "4. Lower middle income": IncomeGrp.THE_4_LOWER_MIDDLE_INCOME,
    "5. Low income": IncomeGrp.THE_5_LOW_INCOME
});

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({
    "Feature": FeatureType.FEATURE
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
