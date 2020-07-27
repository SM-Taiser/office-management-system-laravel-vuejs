<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Client;
use App\BillingMaster;
use App\ProjectMaster;
use App\Constant;

class DashboardController extends Controller
{
    //
    public function dashboard(){

        $total_client = Client::where('action_type','!=',Constant::ACTION_TYPE_DELETE)->count();
        $total_billings = BillingMaster::where('action_type','!=',Constant::ACTION_TYPE_DELETE)->count();
        $total_projects = ProjectMaster::where('action_type','!=',Constant::ACTION_TYPE_DELETE)->count();
        return response()->json(['total_client'=>$total_client,
                                'total_billings' =>$total_billings,
                                'total_projects' =>$total_projects]);

    }
}
