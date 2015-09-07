
import {searchCtrl} from "./controllers/searchCtrl";
import {LangTable} from "./directives/langTable";
import {DatesTable} from "./directives/datesTable";
import {HourPicker} from "./directives/hourPicker";


var searchApp = angular.module('searchApp', ['ngMessages', 'pickadate'])
	.controller( 'SearchCtrl', searchCtrl)
	.directive('langTable', LangTable.directiveFactory)
	.directive('datesTable', DatesTable.directiveFactory)
	.directive('hourPicker', HourPicker.directiveFactory)
