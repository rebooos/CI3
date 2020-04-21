<?php

class History_balance_model extends CI_Emerald_Model
{
	const CLASS_TABLE = 'history_balance';


	/** @var int */
	protected $id;
	/** @var int */
	protected $user_id;
	/** @var float */
	protected $old_balance;
	/** @var float */
	protected $new_balance;
	/** @var string */
	protected $time_created;

	public static function get_history()
	{
		$user = User_model::get_user();
		$historyData = App::get_ci()->s->from('history_balance')
			->select(['time_created', 'old_balance', 'new_balance'])
			->where('user_id', $user->get_id())
			->many();

		foreach ($historyData as $data) {
			$raw[] = [
				'Date' => $data['time_created'],
				'past' => $data['old_balance'],
				'now' => $data['new_balance'],
			];
		}

		return $raw;
	}
}