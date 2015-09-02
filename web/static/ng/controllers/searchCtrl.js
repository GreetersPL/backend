class searchCtrl {
	constructor($scope, $http){
		$scope.walk ={
			languages: {},
			dates: {}
		}
		$scope.form = this.walkForm
		$scope.submit = function(){
				var req = {
					_format: 'json',
					_csrf_token: this.csrf,
					walk: this.walk
				}
				$http.post('', req).then(function(res){
					console.log(res)
				}).catch((res)=>{
					console.log(this)
					this.walkForm['search[name]'].$setValidity('required', false)
				})
			}
	}
}
searchCtrl.$inject = ['$scope', '$http'];
export default {searchCtrl}
