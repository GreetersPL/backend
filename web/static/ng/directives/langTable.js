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
      vm.removeLang = function(lang){
        for(var i in vm.language){
          if(lang.languages == vm.languages[i].language){
            vm.languages = vm.languages.slice(i);
            return
          }
        }
      }
    }];
  }

  static directiveFactory(){
        LangTable.instance = new LangTable();
        return LangTable.instance;
    }
}
export {LangTable}
