/*@app.directive('hourPicker', ($filter)->
  {
    require:'^ngModel'
    restrict: 'AE'
    scope: {
      ngModel: '='
    }
    link: (scope)->
      hourFormat = "HH:mm"
      hoursToAdd = scope.ngModel.split(':')[0]
      scope.choosenHour = new Date()
      scope.choosenHour.setHours(hoursToAdd, 0, 0, 0)
      scope.$watch('choosenHour', (newVal)->
        scope.ngModel = $filter('date')(newVal, hourFormat)
      )
    template: '<input type="time" placeholder="HH:mm" ng-model="choosenHour">'

  }
)*/
class HourPicker{
  constructor($filter) {
    this.require ='^ngModel'
    this.restrict = 'AE'
    this.scope = {
      ngModel: '='
    }
        console.log($filter)
    this.template = '<input type="time" placeholder="HH:mm" ng-model="choosenHour">'
    this.$filter = $filter
  }
  static directiveFactory() {
    HourPicker.instance = new HourPicker();
    return HourPicker.instance;
  }

  link(scope){
    var hourFormat = "HH:mm"
    var hoursToAdd = scope.ngModel.split(':')[0]
    scope.choosenHour = new Date()
    scope.choosenHour.setHours(hoursToAdd, 0, 0, 0)
    scope.$watch('choosenHour', (newVal) =>{
      scope.ngModel = this.$filter('date')(newVal, hourFormat)
    })
  }

}
HourPicker.$inject = ['$filter'];
export {HourPicker}
