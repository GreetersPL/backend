class DatesTable {
  constructor($filter) {
    this.templateUrl = "datesTable";
    this.restric = "E";
    this.bindToController = true;
    this.controllerAs = 'vm';

    this.scope = {
      dates: '='
    }
    this.controller = ['$scope','$filter', function($scope, $filter) {
      var vm = this;
      $scope.todayDate = ($filter('date')(new Date(), "yyyy-MM-dd")).toString();
      $scope.deleteDate= function(date){
        for(var i in vm.date){
          if(vm.dates[i].date === date){
            vm.dates =  vm.dates.slice(i);
            return
          }
        }
      }
      $scope.pushNewDate = function(dateToAdd){
        var dateObject = {
          date: dateToAdd,
          from: "8:00",
          to: "20:00"
        }
        vm.dates.push(dateObject)
      }
      $scope.$watchCollection(function(){return $scope.choosenDates}, function(newVal, oldVal){
        if(oldVal === undefined){return}
        else if(oldVal.length === 0){
          $scope.pushNewDate(newVal[0])
        }
        else if(oldVal.length < newVal.length){
          $scope.pushNewDate(newVal[newVal.length - 1])
        } else if(oldVal.length > newVal.length) {
          for(var i of oldVal){
            if(newVal.indexOf(i) < 0){
              return $scope.deleteDate(i);
            }
          }
        }
      })
    }]
  }
  static directiveFactory() {
    DatesTable.instance = new DatesTable();
    return DatesTable.instance;
  }
}
DatesTable.$inject = ['$filter'];
export {DatesTable}
