class AfricaData {
  Properties properties;

  AfricaData({this.properties});

  AfricaData.fromJson(Map<String, dynamic> json) {
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.properties != null) {
      data['properties'] = this.properties.toJson();
    }
    return data;
  }
}

class Properties {
  String name;
  int popEst;
  int gdpMdEst;
  String economy;
  String incomeGrp;
  String isoA2;
  String isoA3;
  String continent;
  String latitude;
  String longitude;
  int confirmed;
  int deaths;
  int active;
  int recovered;

  Properties(
      {this.name,
      this.popEst,
      this.gdpMdEst,
      this.economy,
      this.incomeGrp,
      this.isoA2,
      this.isoA3,
      this.continent,
      this.latitude,
      this.longitude,
      this.confirmed,
      this.deaths,
      this.active,
      this.recovered});

  Properties.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    popEst = json['pop_est'];
    gdpMdEst = json['gdp_md_est'];
    economy = json['economy'];
    incomeGrp = json['income_grp'];
    isoA2 = json['iso_a2'];
    isoA3 = json['iso_a3'];
    continent = json['continent'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    active = json['active'];
    recovered = json['recovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['pop_est'] = this.popEst;
    data['gdp_md_est'] = this.gdpMdEst;
    data['economy'] = this.economy;
    data['income_grp'] = this.incomeGrp;
    data['iso_a2'] = this.isoA2;
    data['iso_a3'] = this.isoA3;
    data['continent'] = this.continent;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    data['active'] = this.active;
    data['recovered'] = this.recovered;
    return data;
  }
}
