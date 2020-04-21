<?php

/**
 * Created by PhpStorm.
 * User: mr.incognito
 * Date: 10.11.2018
 * Time: 21:36
 */
class Main_page extends MY_Controller
{
	const TYPE_LIKE_POST    = 1;
	const TYPE_LIKE_COMMENT = 2;

	public function __construct()
	{
		parent::__construct();

		App::get_ci()->load->model('User_model');
		App::get_ci()->load->model('Boosterpack_model');
		App::get_ci()->load->model('Login_model');
		App::get_ci()->load->model('Post_model');
		App::get_ci()->load->model('History_balance_model');

		if (is_prod()) {
			die('In production it will be hard to debug! Run as development environment!');
		}
	}

	public function index()
	{
		$user = User_model::get_user();
		App::get_ci()->load->view('main_page', ['user' => User_model::preparation($user, 'default')]);
	}

	public function get_user()
	{
		$user = User_model::get_user();
		if ($user) {
			return $this->response_success(['user' => User_model::preparation($user, 'main_page')]);
		}

		return false;
	}

	public function get_all_posts()
	{
		$posts = Post_model::preparation(Post_model::get_all(), 'main_page');
		return $this->response_success(['posts' => $posts]);
	}

	public function get_post($post_id)
	{

		$post_id = intval($post_id);

		if (empty($post_id)) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
		}

		try {
			$post = new Post_model($post_id);
		} catch (EmeraldModelNoDataException $ex) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
		}


		$posts = Post_model::preparation($post, 'full_info');
		return $this->response_success(['post' => $posts]);
	}


	public function comment($post_id, $message)
	{
		if (!User_model::is_logged()) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
		}

		$post_id = intval($post_id);

		if (empty($post_id) || empty($message)) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
		}

		try {
			$post = new Post_model($post_id);
		} catch (EmeraldModelNoDataException $ex) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
		}


		$posts = Post_model::preparation($post, 'full_info');
		return $this->response_success(['post' => $posts]);
	}

	public function registration($login, $email, $password)
	{
		if (empty($login) || empty($email) || empty($password)) {
			return $this->response_error('Login, email or password is empty');
		}

		if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
			return $this->response_error('Email incorrect');
		}

		$user_id = Login_model::registrationUser($login, $email, $password);

		if ($user_id) {
			Login_model::start_session($user_id);
			header('Location: /', TRUE);
		}

		return $this->response_error(CI_Core::RESPONSE_STATUS_ERROR);

	}

	public function login()
	{
		$params = json_decode($this->input->raw_input_stream, true);
		$login = trim($params['login']);
		$password = $params['password'];

		if (empty($login) || empty($password)) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
		}

		$user_id = Login_model::searchUser($login, $password);

		if ($user_id) {
			Login_model::start_session($user_id);

			$user = User_model::preparation((new User_model($user_id)), 'main_page');
			return $this->response_success(['user' => $user]);
		}

		return $this->response_error('You auth fail');

	}


	public function logout()
	{
		Login_model::logout();
		header('Location: /', TRUE);
	}

	public function add_money()
	{
		$params = json_decode($this->input->raw_input_stream, true);
		$sum = $params['sum'];

		if (empty($sum)) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
		}

		$result = User_model::add_money($sum);

		if ($result) {
			return $this->response_success(['message' => 'Balance up']);
		}

		return $this->response_error('Error with balance');
	}

	public function buy_boosterpack()
	{
		$params = json_decode($this->input->raw_input_stream, true);
		$id = $params['id'];

		if (empty($id)) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
		}

		$boosterpack = new Boosterpack_model($id);
		$result = $boosterpack->buy_boosterpack();

		if ($result) {
			return $this->response_success($result);
		}

		return $this->response_error('Not found money');
	}


	public function like()
	{
		if (!User_model::is_logged()) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
		}

		$params = json_decode($this->input->raw_input_stream, true);
		$post_id = $params['post_id'];
		$comment_id = $params['comment_id'];

		if (empty($post_id)) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
		}

		$user = User_model::get_user();
		if ($user->get_count_likes() <= 0) {
			return $this->response_error('Likes not found');
		}

		try {
			$post = new Post_model($post_id);
		} catch (EmeraldModelNoDataException $ex) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
		}

		if ($comment_id) {
			try {
				$comment = new Comment_model($comment_id);
				$comment->add_likes();
				$user->spend_likes($comment_id, self::TYPE_LIKE_COMMENT);
			} catch (EmeraldModelNoDataException $ex) {
				return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
			}
		} else {
			$post->add_likes();
			$user->spend_likes($post_id, self::TYPE_LIKE_POST);
		}

		$postsPrepare = Post_model::preparation($post, 'full_info');
		return $this->response_success(['post' => $postsPrepare, 'count_likes' => $user->get_count_likes()]);
	}

	public function add_comment()
	{
		if (!User_model::is_logged()) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
		}

		$params = json_decode($this->input->raw_input_stream, true);
		$post_id = $params['post_id'];
		$comment_id = $params['comment_id'];
		$comment_text = $params['comment_text'];

		if (empty($post_id) || empty($comment_text)) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
		}

		try {
			$post = new Post_model($post_id);
		} catch (EmeraldModelNoDataException $ex) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
		}

		try {
			$user = User_model::get_user();
		} catch (EmeraldModelNoDataException $ex) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
		}

		$data = [
			'parent_id' => 0,
			'user_id'   => $user->get_id(),
			'assign_id' => $post_id,
			'text'      => $comment_text,
		];

		if ($comment_id) {
			$data['parent_id'] = $comment_id;
		}

		try {
			Comment_model::create($data);
		} catch (EmeraldModelSaveException $ex) {
			return $this->response_error(CI_Core::RESPONSE_STATUS_ERROR);
		}

		$postsPrepare = Post_model::preparation($post, 'full_info');
		return $this->response_success(['post' => $postsPrepare, 'count_likes' => $user->get_count_likes()]);
	}

	public function history_data()
	{
		if (!User_model::is_logged()) {
			return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
		}

		$boosterpackHistory = Boosterpack_model::get_history();
		$balanceHistory = History_balance_model::get_history();

		return $this->response_success(
			['historyBoosterpackData' => $boosterpackHistory,
			 'historyBalanceData'     => $balanceHistory]);
	}
}
