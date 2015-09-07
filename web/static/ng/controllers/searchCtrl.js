class searchCtrl {
	constructor($scope, $http){
		$scope.walk ={
			languages: [],
			dates: []
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
					for(var k in res.data){
						var input = this.walkForm['search['+k+']']
						for(var i of res.data[k]){
								switch(i){
									case "can't be blank":
										input.$setValidity('required', false);
										break;
									default:
										input.$setValidity('other', false);
										break;
								}
						}
					}
				})
			}
	}
}
searchCtrl.$inject = ['$scope', '$http'];
export default {searchCtrl}
