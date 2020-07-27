<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;
use Hash;
class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function __construct()
    {
        $this->middleware('auth:api');
    }
    public function index()
    {
        //
        return User::latest()->paginate(10);
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
         'name' =>'required|string|max:191',
         'email' =>'required|unique:users|max:191',
         'password' =>'required|string|min:6'
        ]);

        return User::create([
          'name' =>$request['name'],
          'email' =>$request['email'],
          'role' =>$request['role'],
          'password' =>Hash::make($request['password'])
        ]);
        
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
    }

    public function profile()
    {
        //
        return auth('api')->user();
    }
    public function updateProfile(Request $request)
    {
         $user = auth('api')->user();
         $user = User::find($user->id);
        if($request->photo){
            $name = time().'.' . explode('/', explode(':',substr($request->photo, 0, strpos($request->photo, ';')))[1])[1];
            \Image::make($request->photo)->save(public_path('img/profile/').$name);
            $userPhoto = '/public/img/profile/'.$name;
            $user->photo = $userPhoto;
        }
        
        $user->name = $request->name;
        $user->email = $request->email;
        $user->bio = $request->bio;
        
        $user->update();
        return ['message' => 'Updated the User info'];
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
        $user = User::findOrFail($id);
        $this->validate($request, [
            'name' =>'required|string|max:191',
            'email' =>'required|max:191,email,'.$user->id,
            'password' =>'sometimes|min:6'
        ]);

        User::where('id', $id)
        ->update(['name' =>$request->name, 
        'email' => $request->email,
        'role' =>$request->role,
        'password' =>Hash::make($request->password)
        ]);
        return ['message' => 'Updated the User info'];

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
        $user = User::findOrFail($id);
        $user->delete();
        return ['message' => 'User Deleted'];
       
    }
    public function search(){
        if($search = \Request::get('q')){
            $users = User::where(function($query) use ($search) {
                $query->where('name', 'LIKE', "%$search%")
                ->orWhere('email', 'LIKE', "%$search%")
                ->orWhere('role', 'LIKE', "%$search%");
            })->paginate(20);
        }else{
            $users = User::latest()->paginate(2);
        }

        return $users;
    }
}
