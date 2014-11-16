angular.module("app").controller "NewContactController", ($scope, $location, $stateParams, Wallet) ->
    $scope.account_name = $stateParams.name
    $scope.address = $stateParams.key

    $scope.createContact = ->
        form = @newcontact
        form.account_name.$invalid = false
        form.account_name.error_message = null
        form.address.$invalid = false
        form.address.error_message = null
        Wallet.wallet_add_contact_account($scope.account_name, $scope.address).then (response) ->
            Wallet.refresh_accounts()
            $location.path "accounts/#{$scope.account_name}"
        , (response) ->
            if response.data.error.code == 10 and response.data.error.message
                message = response.data.error.message.replace(/(\r\n|\n|\r)/gm,'')
                regex_match = message.match(/Assert\sException.+\:\s?(.+)/i)
                if regex_match and regex_match.length > 1
                    message = regex_match[1].trim()
                    if message
                        if message.match(/Account/)
                            form.account_name.error_message = message
                        else
                            form.address.error_message = message
                    else
                        form.address.error_message = "Not valid pulic key"
                else
                    form.address.error_message = message
