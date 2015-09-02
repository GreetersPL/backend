import {angular} from "angular";
import {searchCtrl} from "./controllers/searchCtrl";

var searchApp = angular.module('searchApp', ['ngMessages'])
	.controller( 'SearchCtrl', searchCtrl)
