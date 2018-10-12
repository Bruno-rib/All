
var app2 = angular.module('app2', []);
var n = - 14;
var m = 1 / 10;

function MyCtrl($scope) {

  $scope.randomNum1 = Math.floor((Math.random() * 1000) + 1);
  $scope.deposit = 5;
  $scope.showValue = function() {
    if ($scope.deposit == $scope.randomNum1) 
      alert("good job nipple face!");
    else if ($scope.deposit < $scope.randomNum1)
      alert("You are such a hibiscus! Try higher...");
    else
      alert("Try lower booboohead");
  };
};

app2.controller('ctrl1', function($scope, $interval) {

  $interval(function() {
    var seconds = new Date().getTime();
    $scope.time = (((seconds.toString() / 200) % 160) + 20) / 2;

    if (n < 270 && n > -15) {
      n += m;
    } else if (n > 269) {
      n = 265;
      m *= -1;
    } else {
      n = -10;
      m *= -1;
    }

    $scope.count = n + ',' + n + ',' + n;
    $scope.countM = (n + 20) / 4;

  });

});






