class LangTable{
  constructor(){
    this.templateUrl = "langTable";
    this.restric = "E";
    this.bindToController = true;
    this.controllerAs = 'vm';

    this.scope = {
      languages: '='
    }
    this.controller = ['$scope', function($scope){
      var vm = this;
      vm.addLang = function(){
        vm.languages.push({language: $scope.langToAdd, level: "intermediate"})
      }
    }];
  }

  static directiveFactory(){
        LangTable.instance = new LangTable();
        return LangTable.instance;
    }
}
export {LangTable}
