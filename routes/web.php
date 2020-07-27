<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

//Route::get('/lara-vue/{path}','HomeController@index')->where('path', '[\/\w\.-]*' );
//Route::get('{path}', 'HomeController@index')->where('path', '([A-z\d-\/_.]+)?');
//Route::get('{path}', 'API\UserController@index')->where('path', '([A-z\d-\/_.]+)?');

//Route::get('/lara-vue/{route?}', 'HomeController@index')->where('route', '([0-9]+(\/){0,1})*');
