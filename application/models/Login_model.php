<?php
/*
    Модель работы с авторизцией/регистрацией аккаунта
    @author: Dmitriy Nyashkin
    @email: dmitriy@nyashk.in
    @link: http://nyashk.in
*/


class Login_model extends CI_Model
{

	public function __construct()
	{
		parent::__construct();

	}

	public static function logout()
	{
		App::get_ci()->session->unset_userdata('id');
	}

	public static function start_session(int $user_id)
	{
		// если перенедан пользователь
		if (empty($user_id)) {
			throw new CriticalException('No id provided!');
		}

		App::get_ci()->session->set_userdata('id', $user_id);
	}

	public static function searchUser($login, $password)
	{
		return App::get_ci()->s->from(User_model::CLASS_TABLE)
			       ->where(['personaname' => $login, 'password' => $password])
			       ->select(['id'])
			       ->one()['id'];
	}

	public static function registrationUser($login, $email, $password)
	{
		$user_id =  App::get_ci()->s->from(User_model::CLASS_TABLE)
				       ->where(['email' => $email])
				       ->select(['id'])
				       ->one()['id'];

		if (!empty($user_id)) {
			return false;
		}

		return App::get_ci()->s->from(User_model::CLASS_TABLE)
			->insert([
				'personaname'            => $login,
				'email'                  => $email,
				'password'               => $password,
				'rights'                 => 0,
				'wallet_balance'         => 0,
				'wallet_total_refilled'  => 0,
				'wallet_total_withdrawn' => 0,
				'count_likes'            => 10,
			])->execute();


    }
}
