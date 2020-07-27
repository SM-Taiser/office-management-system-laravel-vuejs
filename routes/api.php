<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

// Dashboard
Route::group(['middleware' => 'auth:api'], function() {
	
    Route::get('dashboard','DashboardController@dashboard');

	Route::apiResources(['user' => 'API\UserController']);
	Route::get('findUser','API\UserController@search');
	Route::get('profile','API\UserController@profile');
	Route::put('profile','API\UserController@updateProfile');
	Route::resource('task','TaskController');

	Route::apiResources(['client' => 'ClientController']);
	Route::get('findClient','ClientController@search');

	Route::apiResources(['billing' => 'BillingController']);
	Route::get('findBilling','BillingController@search');

	Route::apiResources(['project-category' => 'ProjectCategoryController']);
	Route::get('findProjectCategory','ProjectCategoryController@search');

	Route::apiResources(['project-item-type' => 'ItemTypeController']);
	Route::get('findProjectItemType','ItemTypeController@search');

	Route::apiResources(['project-register' => 'ProjectController']);
	Route::get('findProjectRegister','ProjectController@search');
	Route::post('project-register/single-create/{project_master_id}','ProjectController@addToExistingProjectMaster');
	Route::put('project-register/project-details-update/{project_details_id}','ProjectController@updateProjectDeatils');
	Route::delete('project-register/project-details-delete/{project_details_id}','ProjectController@destroyProjectDeatils');

	// Route::apiResources(['expense-head' => 'BillingController']);
	// Route::get('findBilling','BillingController@search');
});


