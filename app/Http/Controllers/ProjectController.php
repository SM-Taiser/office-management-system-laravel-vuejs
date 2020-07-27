<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\ProjectMaster;
use App\ProjectDetails;
use DB;
use Auth;
use App\Constant;

class ProjectController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $project_masters = ProjectMaster::with(['clientInfo','categoryInfo'])
        ->where('action_type','!=',Constant::ACTION_TYPE_DELETE)  
        ->get();
        return response()->json(['project_masters'=>$project_masters]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
        DB::beginTransaction();

        $project_master = new ProjectMaster;
        $project_master->name = $request->name;
        $project_master->client_id = $request->client_id;
        $project_master->project_category_id = $request->project_category_id;
        $project_master->installation_charge = $request->installation_charge;
        $project_master->service_charge = $request->service_charge;
        $project_master->total_project_value = $request->total_project_value;
        $project_master->start_date = $request->start_date;
        $project_master->delivery_date = $request->delivery_date;
        $project_master->status = 1;
        $project_master->action_type = Constant::ACTION_TYPE_INSERT;
        $project_master->user_code = auth('api')->user()->id;

 
        if($project_master->save()){
            foreach($request->project_details as $key=>$data){
                $project_details = new ProjectDetails;
                $project_details->project_master_id = $project_master->id;
                $project_details->description = $data['description'];
                $project_details->item_type_id = $data['item_type_id'];
                $project_details->amount = $data['amount'];
                $project_details->start_date = $data['start_date'];
                $project_details->delivery_date = $data['delivery_date'];
                $project_details->next_billing_date = $data['next_billing_date'];
                $project_details->recurring_month = $data['recurring_month'];
                $project_details->is_recurring = $data['is_recurring'];
                $project_details->is_transaction = $data['is_transaction'];
                $project_details->action_type = Constant::ACTION_TYPE_INSERT;
                $project_details->user_code = auth('api')->user()->id;
                $project_details->save();
            }
        }

        DB::commit();
       return ['message' => 'Success'];
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
        $project_masters = ProjectMaster::with(['clientInfo','categoryInfo'])
        ->where('action_type','!=',Constant::ACTION_TYPE_DELETE) 
        ->where('id','=',$id)  
        ->first();
        $project_details = ProjectDetails::with('itemTypeInfo')
        ->where('action_type','!=',Constant::ACTION_TYPE_DELETE) 
        ->where('project_master_id','=',$project_masters->id)  
        ->get();
        return response()->json(['project_masters'=>$project_masters,'project_details'=>$project_details]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
        $project_master = ProjectMaster::find($id);
        $project_master->name = $request->name;
        $project_master->client_id = $request->client_id;
        $project_master->project_category_id = $request->project_category_id;
        $project_master->installation_charge = $request->installation_charge;
        $project_master->delivery_date = $request->delivery_date;
        $project_master->service_charge = $request->service_charge;
        $project_master->total_project_value = $request->total_project_value;
        $project_master->start_date = $request->start_date;
        $project_master->status = $request->status;
        $project_master->action_type = Constant::ACTION_TYPE_UPDATE;
        $project_master->user_code = auth('api')->user()->id;
        $project_master->update();
        return ['message'=>'Success'];
        
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
        DB::beginTransaction();
        
        $project_masters = ProjectMaster::find($id);
        $project_masters->action_type = Constant::ACTION_TYPE_DELETE;
        $project_masters->user_code = auth('api')->user()->id;
        $project_masters->update();
        
        $project_details = ProjectDetails::where('project_master_id',$id)
        ->update(['action_type' => Constant::ACTION_TYPE_DELETE,
                  'user_code' => auth('api')->user()->id
        ]);
     
        DB::commit();
    }

    public function search(){
        if($search = \Request::get('q')){
            $project_masters = ProjectMaster::with(['clientInfo','categoryInfo'])
            ->where(function($query) use ($search) {
                $query->where('name', 'LIKE', "%$search%")
                      ->orWhere('start_date', 'LIKE', "%$search%");
             })       
            ->where('action_type','!=',Constant::ACTION_TYPE_DELETE)  
            ->get();
            
        }else{
            $project_masters = ProjectMaster::with(['clientInfo','categoryInfo'])
            ->where('action_type','!=',Constant::ACTION_TYPE_DELETE)  
            ->get();
        }

        return response()->json(['project_masters'=>$project_masters]);
    }
    public function addToExistingProjectMaster(Request $request, $id){

        $project_details = new ProjectDetails;
        $project_details->project_master_id = $id;
        $project_details->description = $request->description;
        $project_details->item_type_id = $request->item_type_id;
        $project_details->amount = $request->amount;
        $project_details->start_date = $request->start_date;
        $project_details->delivery_date = $request->delivery_date;
        $project_details->next_billing_date = $request->next_billing_date;
        $project_details->recurring_month = $request->recurring_month;
        $project_details->is_recurring = $request->is_recurring;
        $project_details->is_transaction = $request->is_transaction;

        $project_details->action_type = Constant::ACTION_TYPE_INSERT;
        $project_details->user_code = auth('api')->user()->id;
        $project_details->save();

        return ['message'=>'Success'];
    }

    public function updateProjectDeatils(Request $request, $id){


        $project_details = ProjectDetails::find($id);
        $project_details->description = $request->description;
        $project_details->item_type_id = $request->item_type_id;
        $project_details->amount = $request->amount;
        $project_details->start_date = $request->start_date;
        $project_details->delivery_date = $request->delivery_date;
        $project_details->next_billing_date = $request->next_billing_date;
        $project_details->recurring_month = $request->recurring_month;
        $project_details->is_recurring = $request->is_recurring;
        $project_details->is_transaction = $request->is_transaction;
        $project_details->action_type = Constant::ACTION_TYPE_UPDATE;
        $project_details->user_code = auth('api')->user()->id;
        $project_details->update();

        return ['message'=>'Success'];
    }
    public function destroyProjectDeatils($id){
        
        $project_details = ProjectDetails::findOrFail($id);
        $project_details->action_type = Constant::ACTION_TYPE_DELETE;
        $project_details->user_code = auth('api')->user()->id;
        $project_details->update();
        return ['message'=>'Success'];

    }

}
