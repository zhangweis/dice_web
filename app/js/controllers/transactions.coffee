angular.module("app").controller "TransactionsController", ($scope, $location, $state, Shared, Wallet) ->
  $scope.transactions = []

  Wallet.get_transactions(Shared.trxFor).then (trs) ->
    $scope.transactions = trs

  $scope.rescan = ->
    $scope.load_transactions()

