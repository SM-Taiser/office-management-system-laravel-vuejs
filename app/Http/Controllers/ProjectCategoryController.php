<?php

namespace App\Http\Controllers;

use App\ProjectCategory;
use Illuminate\Http\Request;
use App\Constant;

class ProjectCategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $categories = ProjectCategory::where('action_type','!=',Constant::ACTION_TYPE_DELETE)->paginate(10);
        return $categories;

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
         'cata_name' =>'required|string|max:191'
        ]);

        $category = new ProjectCategory;
        $category->cata_name = $request->cata_name;
        $category->description = $request->description;

        $category->action_type = Constant::ACTION_TYPE_INSERT;
        $category->user_code = auth('api')->user()->id;
        $category->save();
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\ProjectCategory  $projectCategory
     * @return \Illuminate\Http\Response
     */
    public function show(ProjectCategory $projectCategory)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\ProjectCategory  $projectCategory
     * @return \Illuminate\Http\Response
     */
    public function edit(ProjectCategory $projectCategory)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\ProjectCategory  $projectCategory
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
        $category = ProjectCategory::find($id);
        $category->cata_name = $request->cata_name;
        $category->description = $request->description;

        $category->action_type = Constant::ACTION_TYPE_UPDATE;
        $category->user_code = auth('api')->user()->id;
        $category->update();

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\ProjectCategory  $projectCategory
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
         $category = ProjectCategory::findOrFail($id);
         $category->action_type = Constant::ACTION_TYPE_DELETE;
         $category->user_code = auth('api')->user()->id;
         $category->update();

        return ['message' => 'Info Deleted'];
    }
    public function search(){
        if($search = \Request::get('q')){
            $category = ProjectCategory::where(function($query) use ($search) {
                $query->where('cata_name', 'LIKE', "%$search%")
                ->orWhere('description', 'LIKE', "%$search%");
            })->where('action_type','!=',Constant::ACTION_TYPE_DELETE)->paginate(20);
            
        }else{
            $category = ProjectCategory::latest()->where('action_type','!=',Constant::ACTION_TYPE_DELETE)->paginate(10);
        }

        return $category;
    }
    
}
