<?php

/**
 * Created by PhpStorm.
 * User: mr.incognito
 * Date: 27.01.2020
 * Time: 10:10
 */
class Boosterpack_model extends CI_Emerald_Model
{
    const CLASS_TABLE = 'boosterpack';


    /** @var float Цена бустерпака */
    protected $price;
    /** @var float Банк, который наполняется  */
    protected $bank;

    /** @var string */
    protected $time_created;
    /** @var string */
    protected $time_updated;

    /**
     * @return float
     */
    public function get_price(): float
    {
        return $this->price;
    }

    /**
     * @param float $price
     *
     * @return bool
     */
    public function set_price(float $price)
    {
        $this->price = $price;
        return $this->save('price', $price);
    }

    /**
     * @return float
     */
    public function get_bank(): float
    {
        return $this->bank;
    }

    /**
     * @param float $bank
     *
     * @return bool
     */
    public function set_bank(float $bank)
    {
        $this->bank = $bank;
        return $this->save('bank', $bank);
    }

    /**
     * @return string
     */
    public function get_time_created(): string
    {
        return $this->time_created;
    }

    /**
     * @param string $time_created
     *
     * @return bool
     */
    public function set_time_created(string $time_created)
    {
        $this->time_created = $time_created;
        return $this->save('time_created', $time_created);
    }

    /**
     * @return string
     */
    public function get_time_updated(): string
    {
        return $this->time_updated;
    }

    /**
     * @param string $time_updated
     *
     * @return bool
     */
    public function set_time_updated(string $time_updated)
    {
        $this->time_updated = $time_updated;
        return $this->save('time_updated', $time_updated);
    }

    function __construct($id = NULL)
    {
        parent::__construct();

        $this->set_id($id);
    }

    public function reload(bool $for_update = FALSE)
    {
        parent::reload($for_update);

        return $this;
    }

    public static function create(array $data)
    {
        App::get_ci()->s->from(self::CLASS_TABLE)->insert($data)->execute();
        return new static(App::get_ci()->s->get_insert_id());
    }

    public function delete()
    {
        $this->is_loaded(TRUE);
        App::get_ci()->s->from(self::CLASS_TABLE)->where(['id' => $this->get_id()])->delete()->execute();
        return (App::get_ci()->s->get_affected_rows() > 0);
    }

	/**
	 * Покупка бустерпака
	 *
	 * @return bool|array
	 * @throws Exception
	 */
    public function buy_boosterpack()
    {
		$user = User_model::get_user();

		if (empty($user)) {
			return false;
		}

        if ($this->price > $user->get_wallet_balance()) {
            return false;
	    }

        $chance = (float)$this->price + (float)$this->bank;
        $countLikes = random_int(1, $chance);
		$bank = (float)$this->price - $countLikes;
		if ($bank <= 0) {
			$bank = 1;
		}
	    $this->set_bank($bank);
		$likes = $countLikes + $user->get_count_likes();
		$user->set_count_likes($likes);
		$user->spend_money($this->price);

	    App::get_ci()->s->from('history_boosterpack')
		    ->insert([
			    'user_id' => $user->id,
			    'boosterpack_id' => $this->get_id(),
			    'price' => $this->get_price(),
			    'likes' => $countLikes,
		    ])
		    ->execute();

	    return ['count_likes' => $countLikes, 'wallet_balance' => $user->get_wallet_balance()];
    }

    public static function get_history()
    {
        $user = User_model::get_user();
		$id = $user->get_id();

        $historyData = App::get_ci()->s->from('history_boosterpack')
	        ->select(['time_created', 'boosterpack_id', 'price', 'likes'])
	        ->where('user_id', $id)
	        ->many();

        foreach ($historyData as $data) {
        	$raw[] = [
        		'Date' => $data['time_created'],
		        'NBP' => $data['boosterpack_id'],
		        'Price' => $data['price'],
	            'CountLike' => $data['likes'],
	        ];
        }

        return $raw;

    }
}
