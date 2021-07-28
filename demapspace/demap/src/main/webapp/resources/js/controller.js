var searchApp = angular.module('searchApp', []);

// 컨트롤러 등록 
searchApp.controller("searchCtrl", function($scope, $http) { 
	
	$scope.initKeyword = function(keyword) {
		$scope.keyword = keyword;
		$scope.searchPlace(keyword);

	};
	
	$scope.searchPlace = function(keyword) {
		
		$http.get('/api/results/places/' + keyword).then(
				function successCallback(response) {
					$scope.keyword = keyword;
					console.log(keyword);
				}, function errorCallback(response) {
					console.log(response.data);
			});
	};

	/*
	$scope.initCartId = function(cartId) {
		$scope.cartId = cartId;
		$scope.refreshCart();

	};
	*/

	/*
	$scope.refreshCart = function() {
		
		$http.get('/eStore/api/cart/' + $scope.cartId).then(
				function successCallback(response) {
					$scope.cart = response.data;
				});
	};
	*/

	/*
	$scope.clearCart = function() {
				
		$http({
			method : 'DELETE',
			url : '/eStore/api/cart/' + $scope.cartId
		}).then(function successCallback() {
			$scope.refreshCart();
		}, function errorCallback(response) {
			console.log(response.data);
		});

	};
	*/
	
	/*
	$scope.addToCart = function(productId) {
				
		$http.put('/eStore/api/cart/cartItem/' + productId).then(
				function successCallback() {
					$scope.refreshCart();
					alert("Product successfully added to the cart!");

				}, function errorCallback() {
					alert("Adding to the cart failed!")
				});
	};
	*/
	
	/*
	$scope.plusItemFromCart = function(productId) {
		
		$http.put('/eStore/api/cart/cartItem/' + productId).then(
				function successCallback() {
					$scope.refreshCart();

				}, function errorCallback() {
					alert("Adding to the cart failed!")
				});
	};
	*/
	
	/*
	$scope.minusItemFromCart = function(productId) {
		
		$http({
			method : 'PATCH',
			url : '/eStore/api/cart/cartItem/' + productId
		}).then(function successCallback() {
			$scope.refreshCart();
		}, function errorCallback(response) {
			console.log(response.data);
		});
	};
	*/
	
	/*
	$scope.removeFromCart = function(productId) {
		
		$http({
			method : 'DELETE',
			url : '/eStore/api/cart/cartItem/' + productId
		}).then(function successCallback() {
			$scope.refreshCart();
		}, function errorCallback(response) {
			console.log(response.data);
		});
	};
	*/

	/*
	$scope.calGrandTotal = function() {
		var grandTotal = 0;

		for (var i = 0; i < $scope.cart.cartItems.length; i++) {
			grandTotal += $scope.cart.cartItems[i].totalPrice;
		}

		return grandTotal;
	};
	*/
	
});