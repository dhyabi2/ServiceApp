class GetProviderProposal {
  String? proposalID;
  String? providerID;
  String? requestID;

  GetProviderProposal({this.proposalID, this.providerID, this.requestID});

  GetProviderProposal.fromJson(Map<String, dynamic> json) {
    proposalID = json['proposalID'];
    providerID = json['providerID'];
    requestID = json['requestID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['proposalID'] = proposalID;
    data['providerID'] = providerID;
    data['requestID'] = requestID;
    return data;
  }
}
