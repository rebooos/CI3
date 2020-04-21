Vue.component("table-history", {
	template: `<table class="table">
				<thead class="thead-dark">
				  <tr>
					<th v-for="key in columns"
					  @click="sortBy(key)"
					  :class="{ active: sortKey == key }"
					   scope="col">
					  {{ key | capitalize }}
					  <span class="arrow" :class="sortOrders[key] > 0 ? 'asc' : 'dsc'">
					  </span>
					</th>
				  </tr>
				</thead>
				<tbody>
				  <tr v-for="entry in filteredHistory">
					<td v-for="key in columns">
					  {{ entry[key] }}
					</td>
				  </tr>
				</tbody>
				</table>`,
	props: {
		history: Array,
		columns: Array,
	},
	data: function() {
		var sortOrders = {};
		this.columns.forEach(function(key) {
			sortOrders[key] = 1;
		});
		return {
			sortKey: "",
			sortOrders: sortOrders
		};
	},
	computed: {
		filteredHistory: function() {
			var sortKey = this.sortKey;
			var filterKey = this.filterKey && this.filterKey.toLowerCase();
			var order = this.sortOrders[sortKey] || 1;
			var history = this.history;
			if (filterKey) {
				history = history.filter(function(row) {
					return Object.keys(row).some(function(key) {
						return (
							String(row[key])
								.toLowerCase()
								.indexOf(filterKey) > -1
						);
					});
				});
			}
			if (sortKey) {
				history = history.slice().sort(function(a, b) {
					a = a[sortKey];
					b = b[sortKey];
					return (a === b ? 0 : a > b ? 1 : -1) * order;
				});
			}
			return history;
		}
	},
	filters: {
		capitalize: function(str) {
			return str.charAt(0).toUpperCase() + str.slice(1);
		}
	},
	methods: {
		sortBy: function(key) {
			this.sortKey = key;
			this.sortOrders[key] = this.sortOrders[key] * -1;
		}
	}
});

let app = new Vue({
	el: '#app',
	data: {
		login: '',
		pass: '',
		post: false,
		invalidLogin: false,
		invalidPass: false,
		invalidSum: false,
		commentReplay: [],
		posts: [],
		likes: 0,
		addSum: 0,
		amount: 0,
		Message: 0,
		commentText: '',
		packs: [
			{
				id: 1,
				price: 5
			},
			{
				id: 2,
				price: 20
			},
			{
				id: 3,
				price: 50
			},
		],
		user: false,
		historyBalanceColumns: ["Date", "past", "now"],
		historyBalanceData: [],
		historyBoosterpackColumns: ["Date", "NBP", "Price", "CountLike"],
		historyBoosterpackData: [],
	},
	computed: {
		test: function () {
			let data = [];
			return data;
		}
	},
	created(){
		var self = this
		axios
			.get('/main_page/get_all_posts')
			.then(function (response) {
				self.posts = response.data.posts;
			})
		axios.get('/main_page/get_user')
			.then(function (response) {
				self.user = response.data.user
			})
	},
	methods: {
		logIn: function () {
			var self= this;
			if(self.login === ''){
				self.invalidLogin = true
			}
			else if(self.pass === '') {
				self.invalidLogin = false
				self.invalidPass = true
			}
			else{
				self.invalidLogin = false
				self.invalidPass = false
				axios.post('/main_page/login', {
					login: self.login,
					password: self.pass
				})
					.then(function (response) {

						if (response.data.status === 'error') {
							console.log(response.data.status.error_message);
						}

						if (typeof response.data.user !== "undefined") {
							self.user = response.data.user;
						}
						setTimeout(function () {
							$('#loginModal').modal('hide');
						}, 500);
					})
			}
		},
		fiilIn: function () {
			var self= this;
			if(self.addSum === 0){
				self.invalidSum = true
			}
			else{
				self.invalidSum = false
				axios.post('/main_page/add_money', {
					sum: self.addSum,
				})
					.then(function (response) {

						if (response.data.status == "success") {
							self.user.wallet_balance += parseFloat(self.addSum);
							self.user.wallet_total_refilled += parseFloat(self.addSum);
						}

						setTimeout(function () {
							$('#addModal').modal('hide');
						}, 500);
					})
			}
		},
		openPost: function (id) {
			var self= this;
			axios
				.get('/main_page/get_post/' + id)
				.then(function (response) {
					self.post = response.data.post;
					if(self.post) {
						setTimeout(function () {
							$('#postModal').modal('show');
						}, 500);
					}
				})
		},
		addLike: function (post_id, comment_id = null) {
			var self= this;
			axios
				.post('/main_page/like', {
					post_id: post_id,
					comment_id: comment_id
				})
				.then(function (response) {
					self.user.count_likes = response.data.count_likes;
					self.post = response.data.post;
				})

		},
		buyPack: function (id) {
			var self= this;
			axios
				.post('/main_page/buy_boosterpack', {
				id: id,
			})
				.then(function (response) {
					let data = response.data;
					self.amount = data.amount
					if (data.status === "success") {
						self.user.wallet_balance = data.wallet_balance;
						self.user.count_likes += data.count_likes;
						self.Message = "You get: " + data.count_likes + ", lucky you!";
					} else {
						self.Message = data.error_message;
					}
					if(self.amount !== 0) {
						setTimeout(function () {
							$('#amountModal').modal('show');
						}, 500);
					}
				})
		},
		addComment: function(comment_id = 0) {
			let self = this;

			if(self.commentText === '') {
				return
			}

			axios
				.post('/main_page/add_comment', {
					post_id: self.post.id,
					comment_text: self.commentText,
					comment_id: comment_id
				})
				.then(function(response) {
					if (typeof response.data.post !== "undefined") {
						self.post = response.data.post;
						self.commentText = '';
					}
				});
		},
		openModal: function() {
			let self = this;
			axios
				.get('/main_page/history_data')
				.then(function(response) {
					self.historyBoosterpackData = response.data.historyBoosterpackData;
					self.historyBalanceData = response.data.historyBalanceData;
				});
		}
	}
});

