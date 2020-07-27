<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProjectDetails extends Model
{
    //
    public function itemTypeInfo(){

    	return $this->hasOne(ItemType::class, 'id', 'item_type_id');
    }
}
