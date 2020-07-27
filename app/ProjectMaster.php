<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProjectMaster extends Model
{
    //
    public function clientInfo(){
    	//return $this->belongsTo(Client::class,'client_id');
    	return $this->hasOne(Client::class, 'id', 'client_id');
    }
    public function categoryInfo(){
    	//return $this->belongsTo(Client::class,'client_id');
    	return $this->hasOne(ProjectCategory::class, 'id', 'project_category_id');
    }
}
