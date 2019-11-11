<!DOCTYPE html>
<html>
<head>


<title>AngularJS Routing with Multiple Views Example</title>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-route.min.js"></script>


<script type="text/javascript">
var app = angular.module("myApp", ['ngRoute']);
app.config(['$routeProvider',
function ($routeProvider) {
$routeProvider.when('/login', {
templateUrl: 'resource/js/views/Login.jsp',
controller: 'login_register_controller'
}).
when('/AddMyhotel', {
templateUrl: 'resource/js/views/AddMyhotel.html',
controller: 'hotelController'
}).
when('/Register', {
	templateUrl: 'resource/js/views/Register.jsp',
	controller: 'registerController'
	}).
	when('/homepage', {
        templateUrl: 'resource/js/views/UserDashboard.jsp',
        controller:'SearchController'
        
      }).
      when('/roomPage', {
          templateUrl: 'resource/js/views/RoomPage.jsp',
          controller:'roomController'
          
        }).
        when('/PaymentDetails', {
    		templateUrl: 'resource/js/views/PaymentDetails.jsp',
    		controller: 'payment_controller'
    		}).
      otherwise({
redirectTo: '/login'
});
}
]);
//Registration controller
app.controller("registerController",function($location,$scope,$http){
	$scope.register_form=true;
	$scope.message={
			
	
			users_id: '',
			users_nameFirst:'',
			users_nameLast:'',
			users_password:'',
			users_email:''

			
	};
	 $scope.registerData = angular.copy($scope.message);
	 $scope.registerEntry = function(){
		 
			debugger
			
			var onSuccess = function (data, status, headers, config) {
	            alert('Registered successfully.');
	        };
	        var onError = function (data, status, headers, config) {
	            alert('Error occured.');
		 
	 }
	  
	       $http.post('http://localhost:8080/AngularJsSqlEx/rest/BookAndGo/AddRegisterDetails', 
	       	JSON.stringify($scope.registerData)).then(function (response) {
	       	if(response.data=="Added"){
	       alert('Hotel Details saved successfully.');
				}else{
					alert('Error occured.');

	        		}
	       	});
	 }	
	
});
app.controller("roomController",['$scope', '$location',function($scope, $location) {
	$scope.message='Testing if room controller works';
	$scope.show_images=true;
     $scope.doBook=function()
	 {
		 debugger
			$location.path('\PaymentDetails');
		 $scope.show_room_details = true;
		  $scope.login_form = false;
		  $scope.register_form = false;
		  $scope.alertMsg = false;
	 };
	}]);
app.controller("hotelController", function($location,$scope, $http) {
	
	$scope.hotel_form=true;
	$scope.message={
			hotel_name:'',
			hotel_address:'',
			hotel_contact:'',
			hotel_emailid:''
			
	};
	 $scope.hotelData = angular.copy($scope.message);
	$scope.submitHotel= function(){
		var onSuccess = function (data, status, headers, config) {
            alert('Hotel Details saved successfully.');
        };

        var onError = function (data, status, headers, config) {
            alert('Error occured.');
        }
           
	}
	
	});
app.controller('login_register_controller', function($location,$scope, $http){
	
	 $scope.closeMsg = function(){
	  $scope.alertMsg = false;
	 };

	 $scope.login_form = true;

	 $scope.showRegister = function(){
	  $scope.login_form = false;
	  $scope.register_form = true;
	  $location.path('\Register');
	 };
	 

	 $scope.showLogin = function(){
	  $scope.register_form = false;
	  $scope.login_form = true;
	  $scope.alertMsg = false;
	   };
	 
	 $scope.showLogin= function(){
		 
	      
	 };
	 $scope.submitLogin= function(){
		 
		var userId=$scope.loginData.email;
		var password=$scope.loginData.password;
		$http.get("http://localhost:8080/AngularJsSqlEx/rest/BookAndGo/Login/"+userId+"/"+password).then(
			      function successCallback(response) {
			    	$scope.response = response;
			    	alert($scope.response.data);
			    	$location.path('\AddMyhotel');
			      },
			      function errorCallback(response) {
			    	 
			    	  $scope.response = response;
			    	  alert($scope.response.data);
			        console.log("Unable to perform get request");
			      }
			    );
	 };
	});
	//Search Controller
	app.controller('SearchController', function($location,$scope, $http){
		$scope.roomavailable="Room Types available";
		//Loading initial data
		// The data model. These items would normally be requested via AJAX,
			// but are hardcoded here for simplicity. See the next example for
			// tips on using AJAX.
        debugger
		$scope.items = [
			{
				url: 'http://tutorialzine.com/2013/07/50-must-have-plugins-for-extending-twitter-bootstrap/',
				hotel_name: 'Marriot Hotel',
				image:'resource/js/images/marriot.png',
				hotel_address:'2832 Charlotte,NC',
				event_name:'Ladies night',
				event_times:'10 am to 12 pm MWF',
				room_type:'Kings Bed'
			},
			{
				url: 'http://tutorialzine.com/2013/08/simple-registration-system-php-mysql/',
				hotel_name:'Hilton',
				image:'resource/js/images/marriot.png',
				hotel_address:'2832 Charlotte,NC',
				event_name:'Ladies night',
				event_times:'10 am to 12 pm MWF',
					room_type:'Deluxe'
			},
			{
				url: 'http://tutorialzine.com/2013/08/simple-registration-system-php-mysql/',
				hotel_name:'West in',
				image:'resource/js/images/marriot.png',
				hotel_address:'2832 Charlotte,NC',
				event_name:'Ladies night',
				event_times:'10 am to 12 pm MWF',
					room_type:'Suite for two'
			}
		];
		
		$scope.onSearch= function(){
			//Search by name
			var searchBy=$scope.searchString;
			$http.get("http://localhost:8080/AngularJsSqlEx/rest/BookAndGo/Search/"+searchBy).then(
					function successCallback(response){
						debugger
						$scope.response = response;
						$scope.items =$scope.response.data;
						if($scope.response.data.length==0){
							$scope.items=[
								{
									hotel_name:"Check your spelling .No details are available."
								}
						];
							$scope.roomavailable='';                  
						}
						
					},function errorCallback(response){
						$scope.response = response;
						$scope.roomavailable='';
						
						
					}	
			
			
			
			);		
			
			
		}
			});
	//Payment Controller
	app.controller("payment_controller",function($location,$scope,$http){
	$scope.submitLogin= function(){
		  $scope.register_form = false;
		  $scope.login_form = false;
		  $scope.alertMsg = true;
		  $scope.paymentForm=true;
		 // $location.path('\PaymentDetails');
	 };
});
	
</script>
</head>
<body ng-app="myApp" >
<h2 style=" color:cornflowerblue; font-family:arial; font-size:260%">Book And Go</h2>
<div>
<ul>
<li>
<a href="#/login" style="text-decoration:none; color:black; border:3px solid; left:1000px">Login</a>
</li>
</ul>
<div ng-view></div>
</div>
</body>
</html>
