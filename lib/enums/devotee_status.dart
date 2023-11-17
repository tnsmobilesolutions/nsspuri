enum DevoteeStatus {
  dataSubmitted,
  paid,
  approved,
  rejected,
  reissued,
}

extension DevoteeStatusExtension on DevoteeStatus {
  String get name {
    switch (this) {
      case DevoteeStatus.dataSubmitted:
        return 'dataSubmitted';
      case DevoteeStatus.paid:
        return 'paid';
      case DevoteeStatus.approved:
        return 'approved';
      case DevoteeStatus.rejected:
        return 'rejected';
      case DevoteeStatus.reissued:
        return 'reissued';
    }
  }
}
