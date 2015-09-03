
import {searchCtrl} from "./controllers/searchCtrl";
import {LangTable} from "./directives/langTable";


var searchApp = angular.module('searchApp', ['ngMessages'])
	.controller( 'SearchCtrl', searchCtrl)
	.directive('langTable', LangTable.directiveFactory)
