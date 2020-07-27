<?php

namespace App\Http\Controllers;

use App\ItemType;
use Illuminate\Http\Request;
use DB;
use Auth;
use App\User;
use App\Constant;
class ItemTypeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
   public function index()
    {
        //
        $item_types = ItemType::where('action_type','!=',Constant::ACTION_TYPE_DELETE)->paginate(10);
        return $item_types;

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
         'item_name' =>'required|string|max:191'
        ]);

        $item_type = new ItemType;
        $item_type->item_name = $request->item_name;
        $item_type->action_type = Constant::ACTION_TYPE_INSERT;
        $item_type->user_code = auth('api')->user()->id;
        $item_type->save();
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\ItemType  $ItemType
     * @return \Illuminate\Http\Response
     */
    public function show(ItemType $ItemType)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\ItemType  $ItemType
     * @return \Illuminate\Http\Response
     */
    public function edit(ItemType $ItemType)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\ItemType  $ItemType
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
        $item_type = ItemType::find($id);
        $item_type->item_name = $request->item_name;
        $item_type->action_type = Constant::ACTION_TYPE_UPDATE;
        $item_type->user_code = auth('api')->user()->id;
        $item_type->update();

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\ItemType  $ItemType
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
         $item_type = ItemType::findOrFail($id);
         $item_type->action_type = Constant::ACTION_TYPE_DELETE;
         $item_type->user_code = auth('api')->user()->id;
         $item_type->update();

        return ['message' => 'Info Deleted'];
    }
    public function search(){
        if($search = \Request::get('q')){
            $item_type = ItemType::where(function($query) use ($search) {
                $query->where('item_name', 'LIKE', "%$search%");
            })->where('action_type','!=',Constant::ACTION_TYPE_DELETE)->paginate(20);
            
        }else{
            $item_type = ItemType::latest()->where('action_type','!=',Constant::ACTION_TYPE_DELETE)->paginate(10);
        }

        return $item_type;
    }
}
