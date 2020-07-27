<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateClientsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('clients', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name')->nullable();
            $table->string('address')->nullable();
            $table->string('mbl_no')->nullable();
            $table->date('birth_date')->nullable();
            $table->string('nationality')->nullable();


            $table->string('company_name');
            $table->string('company_address');
            $table->string('company_mbl_no');
            $table->string('city_country')->nullable();
            $table->string('email');
            $table->string('website')->nullable();
            $table->longText('description')->nullable();
            $table->integer('status')->default(1);
            $table->string('action_type');
            $table->string('user_code');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('clients');
    }
}
