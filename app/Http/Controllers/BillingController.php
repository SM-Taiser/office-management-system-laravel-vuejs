<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\BillingMaster;
use App\BillingDetails;
use App\Constant;
use DB;
class BillingController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
       // return BillingMaster::latest()->paginate(2);
       // $billings =  BillingMaster::with('clientInfo')->get();
        $billings = DB::table('billing_masters')
        ->join('clients','billing_masters.client_id','=','clients.id')
        ->selectRaw('billing_masters.*,clients.company_name')
        ->where('billing_masters.action_type','!=',Constant::ACTION_TYPE_DELETE)        
        ->paginate(10);

        return $billings;
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
        $billing_master = new BillingMaster;
        $billing_master->client_id = $request->client_id;
        $billing_master->invoice_no = $request->invoice_no;
        $billing_master->date = $request->date;
        $billing_master->payment_due_date = $request->payment_due_date;
        $billing_master->action_type = Constant::ACTION_TYPE_INSERT;
        $billing_master->user_code = auth('api')->user()->id;
        
        
        if($billing_master->save()){
            foreach($request->invoice_products as $key=>$data){
                $billing_details = new BillingDetails;
                $billing_details->billing_master_id = $billing_master->id;
                $billing_details->description = $data['description'];
                $billing_details->unit = $data['unit'];
                $billing_details->rate = $data['rate'];
                $billing_details->discount = $data['discount'];
                $billing_details->action_type = Constant::ACTION_TYPE_INSERT;
                $billing_details->user_code = auth('api')->user()->id;
                $billing_details->save();
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

        $billing_masters = DB::table('billing_masters')
        ->join('clients','billing_masters.client_id','=','clients.id')
        ->selectRaw('billing_masters.*,clients.company_name,clients.name,clients.company_address,clients.company_mbl_no')
        ->where('billing_masters.id',$id)
        ->where('billing_masters.action_type','!=',Constant::ACTION_TYPE_DELETE)  
        ->first();
  
        $billing_details = DB::table('billing_details')
        ->where('billing_master_id',$id)
        ->where('action_type','!=',Constant::ACTION_TYPE_DELETE)  
        ->get();

       return response()->json(['billing_masters' => $billing_masters, 'billing_details' => $billing_details]);
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
        
        $billing_master = BillingMaster::find($id);
        $billing_master->action_type = Constant::ACTION_TYPE_DELETE;
        $billing_master->user_code = auth('api')->user()->id;
        $billing_master->update();
        
        $billing_details = BillingDetails::where('billing_master_id',$id)
        ->update(['action_type' => Constant::ACTION_TYPE_DELETE,
                  'user_code' => auth('api')->user()->id
        ]);
     
        DB::commit();

        
    }
    public function search(){
        if($search = \Request::get('q')){
            
            $billings = DB::table('billing_masters')
            ->join('clients','billing_masters.client_id','clients.id')
            ->selectRaw('billing_masters.*,clients.company_name')
            ->where(function ($query) use ($search) {
                        $query->where('billing_masters.invoice_no', 'LIKE', "%$search%")
                               ->orWhere('clients.company_name', 'LIKE', "%$search%");
                        })
            ->where('billing_masters.action_type','!=',Constant::ACTION_TYPE_DELETE)        
            ->paginate(10);
        }else{
            $billings = DB::table('billing_masters')
            ->join('clients','billing_masters.client_id','=','clients.id')
            ->selectRaw('billing_masters.*,clients.company_name')
            ->where('billing_masters.action_type','!=',Constant::ACTION_TYPE_DELETE)        
            ->paginate(10);
        }

        return $billings;
    }
    
}
