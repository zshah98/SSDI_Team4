<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resource/js/css/Index.css">

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-route.min.js"></script>
<script type="text/javascript" src="resource/js/controller/PaymentDetails.js"></script>
<script type="text/javascript">
var app = angular.module('myApp', ['ngRoute']);

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
      when('/roomPage/:hotel_name/:room_type', {
          templateUrl: 'resource/js/views/RoomPage.jsp',
          controller:'roomController'
          
        }).
        when('/PaymentDetails', {
    		templateUrl: 'resource/js/views/PaymentDetails.jsp',
    		controller: 'payment_controller'
    		}).
    		when('/Invoice', {
        		templateUrl: 'resource/js/views/Invoice.jsp',
        		controller: 'invoice_controller'
        		}).
        		when('/BillingDetails', {
            		templateUrl: 'resource/js/views/BillingDetails.jsp',
            		controller: 'billing_controller'
            		}).
            		when('/KingsBed', {
                		templateUrl: 'resource/js/views/RoomPage1.jsp',
                		controller: 'roomController'
                		}).
                		when('/Deluxe', {
                    		templateUrl: 'resource/js/views/RoomPage2.jsp',
                    		controller: 'roomController'
                    		}).
      otherwise({
redirectTo: '/homepage'
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
		 		var onSuccess = function (data, status, headers, config) {
	            alert('Registered successfully.');
	        };
	        var onError = function (data, status, headers, config) {
	            alert('Error occured.');
		 
	 }
	  
	       $http.post('http://localhost:8080/BnG/rest/BookAndGo/AddRegisterDetails', 
	       	JSON.stringify($scope.registerData)).then(function (response) {
	       	if(response.data=="Details Added"){
	       alert('Registration Details saved successfully.');
	       $location.path('\login');
				}else{
					alert('Error occured.');

	        		}
	       	});
	 }	
	
});
//Rommpage Controller
app.controller("roomController",['$scope','$routeParams', '$location',function($scope, $location,$routeParams) {
	$scope.show_images=true;
	$scope.Selected_hotel_name=localStorage.getItem("Selected_hotel_name");
	$scope.Selected_hotel_address=localStorage.getItem("Selected_hotel_address");
	if($location.room_type!=null){
		if($location.room_type=="Kings Bed,Double Bed"){
			$routeParams.path('\KingsBed');
		}else{
			$routeParams.path('\Deluxe');
		}
	}
	//On book button trigger event we need to get kind of page
     $scope.doBook=function(element)
	 {
    	 	 localStorage.setItem('Selected_room_type',element)
    	 $routeParams.path('\Invoice');
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
		$http.get("http://localhost:8080/BnG/rest/BookAndGo/Login/"+userId+"/"+password).then(
			      function successCallback(response) {
			    	$scope.response = response;
			    	alert($scope.response.data);
			    	
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
        
		$scope.items = [
			{
				
				hotel_name: 'Marriot Hotel',
				image:'resource/js/images/marriot.png',
				hotel_address:'2832 Charlotte,NC',
				event_name:'Ladies night',
				event_times:'10 am to 12 pm MWF',
				room_type:'Kings Bed'
			},
			{
				
				hotel_name:'Hilton',
				image:'resource/js/images/marriot.png',
				hotel_address:'2832 Charlotte,NC',
				event_name:'Ladies night',
				event_times:'10 am to 12 pm MWF',
					room_type:'Deluxe'
			},
			{
				
				hotel_name:'West in',
				image:'resource/js/images/marriot.png',
				hotel_address:'2832 Charlotte,NC',
				event_name:'Ladies night',
				event_times:'10 am to 12 pm MWF',
					room_type:'Suite for two'
			}
		];
		$scope.roomData= function(data, data1){
			
			localStorage.setItem("Selected_hotel_name",data);
			localStorage.setItem("Selected_hotel_address",data1);
			
		}
		$scope.onSearch= function(){
			//Search by name
			var searchBy=$scope.searchString;
			$http.get("http://localhost:8080/BnG/rest/BookAndGo/Search/"+searchBy).then(
					function successCallback(response){
					
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
app.controller("payment_controller",function($location,$scope,$http, $locale){
		$scope.paymentForm=true;	
		$scope.message={
				  user_name:'',
				  card_no:'',
				  ccv:'',
				  month:'',
				  year:''
				
		  };
		
	 var year = new Date().getFullYear();
		var range = [];
    range.push(year);
    for (var i = 1; i < 7; i++) {
        range.push(year + i);
    }
    $scope.years = range;
	      $scope.currentMonth = new Date().getMonth() + 1
	      $scope.months = $locale.DATETIME_FORMATS.MONTH
	      $scope.ccinfo = {type:undefined}
		  $scope.postData = function(){
				 
				
				
				var onSuccess = function (data, status, headers, config) {
		          alert('Payment successfull.');
		      };
		      var onError = function (data, status, headers, config) {
		          alert('Error occured.');
			 
		}
			
		      $http.post('http://localhost:8080/BnG/rest/BookAndGo/PaymentDetails', 
		  	       	JSON.stringify($scope.paymentData)).then(function (response) {
		  	       	if(response.data=="Payment Details Added"){
		  	       alert('Payment Details saved successfully.');
		  	       $location.path('\BillingDetails');
		  				}else{
		  					alert('Error occured.');

		  	        		}
		  	       	});
			  }

	
	angular.module('app',[]).directive
	  ( 'creditCardType'
	  , function(){
	      var directive =
	        { require: 'ngModel'
	        , link: function(scope, elm, attrs, ctrl){
	            ctrl.$parsers.unshift(function(value){
	              scope.paymentData.type =
	                (/^5[1-5]/.test(value)) ? "mastercard"
	                : (/^4/.test(value)) ? "visa"
	                : (/^3[47]/.test(value)) ? 'amex'
	                : (/^6011|65|64[4-9]|622(1(2[6-9]|[3-9]\d)|[2-8]\d{2}|9([01]\d|2[0-5]))/.test(value)) ? 'discover'
	                : undefined
	              ctrl.$setValidity('invalid',!!scope.ccinfo.type)
	              return value
	            })
	          }
	        }
	      return directive
	      }
	    );
	    
	    
	    angular.module('app', []).directive
  ( 'cardExpiration'
  , function(){
      var directive =
        { require: 'ngModel'
        , link: function(scope, elm, attrs, ctrl){
            scope.$watch('[paymentData.month,paymentData.year]',function(value){
              ctrl.$setValidity('invalid',true)
              if ( scope.paymentData.year == scope.currentYear
                   && scope.paymentData.month <= scope.currentMonth
                 ) {
                ctrl.$setValidity('invalid',false)
              }
              return value
            },true)
          }
        }
      return directive
      }
    );
	    
	    
	     app.controller('payment_controller', function($scope){
	    	 var monthFormat =  buildLocaleProvider("MMM-YYYY");
	    	 var ymdFormat =  buildLocaleProvider( "YYYY-MM-DD");
	    	 function buildLocaleProvider(formatString) {
	    	        return {
	    	            formatDate: function (date) {
	    	                if (date) return moment(date).format(formatString);
	    	                else return null;
	    	            },
	    	            parseDate: function (dateString) {
	    	                if (dateString) {
	    	                    var m = moment(dateString, formatString, true);
	    	                    return m.isValid() ? m.toDate() : new Date(NaN);
	    	                }
	    	                else return null;
	    	            }
	    	        };
	    	    }
	    	 $scope.dateFields = [
	    		 {
	                    type: 'date',
	                    required: false,
	                    binding: 'applicant.expectedGraduation',
	                    startView: 'month',
	                    label: 'Credit Card Expiry - Year/Month picker',
	                    mode: 'month',
	                    locale: monthFormat
	                }
	    		 ];

	    }) 
	  	
		});
	
	app.controller("billing_controller",function($location,$scope,$http, $locale){
		$scope.billingForm=true;	
		$scope.message={
				   add_line1:'',
				  add_line2:'',
				  city:'',
				  pincode:'',
				  state:'' 
		  };
		
		 $scope.postData = function(){
			 
				
				
				var onSuccess = function (data, status, headers, config) {
		          alert('Details saved successfull.');
		      };
		      var onError = function (data, status, headers, config) {
		          alert('Error occured.');
			 
		}
			
		      $http.post('http://localhost:8080/BnG/rest/BookAndGo/BillingDetails', 
		  	       	JSON.stringify($scope.billingData)).then(function (response) {
		  	       	if(response.data=="Billing Details Added"){
		  	       alert('Billing Details saved successfully.');
		  	       $location.path('\PaymentDetails');
		  				}else{
		  					alert('Error occured.');

		  	        		}
		  	       	});
		  }
	});
	
	
	app.controller('invoice_controller', function($scope,$location,$http, $locale) {
		
		 var room_type=localStorage.getItem("Selected_room_type");
		 var hotel_name=localStorage.getItem("Selected_hotel_name");
		 var hotel_address=localStorage.getItem("Selected_hotel_address"); 
		 $scope.hotel_address=hotel_address;
		 $scope.hotel_name=hotel_name;
		  $scope.data = [
		    {
		      'room_type' :'23',
		      'roomPrice' : '33',
		      'room_floor':1,
		      'room_id':0
		    }
		  ]
		  $http.get("http://localhost:8080/BnG/rest/BookAndGo/roomDetails/"+hotel_name+"/"+room_type+"/"+hotel_address).then(
					function successCallback(response){
						
						$scope.response = response;
						$scope.data =$scope.response.data;
						if($scope.response.data.length==0){
							$scope.data=[
								{
									hotel_name:"Server error.Unable to retrieve details"
								}
						];
						          
						}
						
					},function errorCallback(response){
						
						$scope.response = response;
						
						
						
					}	
			
			
			
			);	
		  
		  
		  
		  
		  
		  
		  
		  /*  $http.post('http://localhost:8080/BnG/rest/BookAndGo/Invoice', 
		  	       	JSON.stringify($scope.invoiceData)).then(function (response) {
		  	       	if(response.data=="Payment Details Added"){
		  	       alert('Payment Details saved successfully.');
		  	       $location.path('\homepage');
		  				}else{
		  					alert('Error occured.');

		  	        		}
		  	       	}); */
		 /*  $scope.invoice = {};
		  var total = 0;
		  var discount = 0;
		  for (var i=0; i < $scope.data.length; i++) {
		     total = total + $scope.data[i].sale_prize*$scope.data[i].quantity;
		     discount = discount+$scope.data[i].discount;
		  }
		  $scope.invoice['total'] = total;
		  $scope.invoice['tax'] = (total*2)/100;
		  $scope.invoice['discount'] = (total*discount)/100;

		  
		  $scope.showinvoice = function () {
		    $('#invoice').fadeIn() */
		  //}
		});
	
	
</script>
</head>
<body ng-app="myApp" >
<body>

<div class="header">
  <a href="#default" class="logo">Book And Go</a>
  <div class="header-right">
    <a class="active" href="#home">Home</a>
    <a href="#/login" ng-model="LoginButton" ng-click="onLogin(Login)">Login</a>
    <a href="#/Register" ng-model="RegisterButton" ng-click="onRegister(Register)">Register</a>
    <a href="">Cancel Booking</a>
  </div>
</div>

<div style="padding-left:20px">
 </div>
<div>
<div ng-view></div>
</div>
</body>
</html>
