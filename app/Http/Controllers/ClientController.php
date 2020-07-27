<?php

namespace App\Http\Controllers;

use App\Client;
use Illuminate\Http\Request;
use App\User;
use App\Constant;


class ClientController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    
    public function index()
    {
        //
        $clients = Client::where('action_type','!=',Constant::ACTION_TYPE_DELETE)->paginate(10);

        return $clients;
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
        $this->validate($request, [
         'company_name' =>'required|string|max:191',
         'email' =>'required|unique:clients|max:191',
         'company_mbl_no' =>'required|numeric|min:11'
        ]);
        $client = new Client;
        $client->name = $request->name;
        $client->address = $request->address;
        $client->mbl_no = $request->mbl_no;
        $client->birth_date = $request->birth_date;
        $client->nationality = $request->nationality;
        
        $client->company_name = $request->company_name;
        $client->company_mbl_no = $request->company_mbl_no;
        $client->company_address = $request->company_address;
        $client->email = $request->email;
        $client->city_country = $request->city_country;
        $client->website = $request->website;
        $client->status = $request->status;
        $client->action_type = Constant::ACTION_TYPE_INSERT;
        $client->user_code = auth('api')->user()->id;
        $client->save();

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Client  $client
     * @return \Illuminate\Http\Response
     */
    public function show(Client $client)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Client  $client
     * @return \Illuminate\Http\Response
     */
    public function edit(Client $client)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Client  $client
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
        $client = Client::find($id);
        $client->name = $request->name;
        $client->address = $request->address;
        $client->mbl_no = $request->mbl_no;
        $client->birth_date = $request->birth_date;
        $client->nationality = $request->nationality;
        
        $client->company_name = $request->company_name;
        $client->company_mbl_no = $request->company_mbl_no;
        $client->company_address = $request->company_address;
        $client->email = $request->email;
        $client->city_country = $request->city_country;
        $client->website = $request->website;
        $client->status = $request->status;
        $client->action_type = Constant::ACTION_TYPE_UPDATE;
        $client->user_code = auth('api')->user()->id;
        $client->update();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Client  $client
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
         $client = Client::findOrFail($id);
         $client->action_type = Constant::ACTION_TYPE_DELETE;
         $client->user_code = auth('api')->user()->id;
         $client->update();

        return ['message' => 'Client Deleted'];
    }
    public function search(){
        if($search = \Request::get('q')){
            $clients = Client::where(function($query) use ($search) {
                $query->where('company_name', 'LIKE', "%$search%")
                ->orWhere('email', 'LIKE', "%$search%");
            })->paginate(20);
        }else{
            $clients = Client::latest()->paginate(10);
        }

        return $clients;
    }
}
