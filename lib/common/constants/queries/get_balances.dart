const String qGetBalances = """
  query getBalances {
  totalBalance: transaction_aggregate {
    aggregate {
      sum {
        value
      }
    }
  }
  totalIncome: transaction_aggregate(where: {value: {_gt: "0"}}) {
    aggregate {
      sum {
        value
      }
    }
  }
  totalOutcome: transaction_aggregate(where: {value: {_lt: "0"}}) {
    aggregate {
      sum {
        value
      }
    }
  }
}
""";
