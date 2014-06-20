angular.module("app").controller "CreateWalletController", ($scope, $modal, $log, RpcService, Wallet) ->
  $scope.wallet_name = "default"
  $scope.descriptionCollapsed = true
  $scope.submitForm = (isValid) ->
    if isValid
      Wallet.create($scope.wallet_name, $scope.spending_password).then ->
        window.location.href = "/"
        return
    else
      alert "Please properly fill up the form below"
      return

