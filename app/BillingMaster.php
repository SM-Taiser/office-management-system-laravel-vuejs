<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class BillingMaster extends Model
{
    //
    public function clientInfo(){
    	//return $this->belongsTo(Client::class,'client_id');
    	return $this->hasOne(Client::class, 'id', 'client_id');
    }
}
