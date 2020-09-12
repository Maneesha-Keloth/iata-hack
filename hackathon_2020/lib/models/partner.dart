enum PARTNERTYPE { PREMIUM, STANDARD }

class Partner {
  Partner(this.partnerName, this.time, this.agent, this.premium,
      this.partnertype, this.rate, this.transitInhours);
  final String partnerName;
  final String time;
  final String agent;
  final bool premium;
  final String partnertype;
  final double rate;
  final int transitInhours;
}
