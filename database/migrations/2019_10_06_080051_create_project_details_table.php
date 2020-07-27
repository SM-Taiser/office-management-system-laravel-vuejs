<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProjectDetailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('project_details', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('project_master_id');
            $table->integer('item_type_id');
            $table->text('description');
            $table->float('amount');
            $table->date('start_date');
            $table->date('delivery_date')->nullable();
            $table->date('next_billing_date')->nullable();
            $table->integer('recurring_month')->nullable();            
            $table->tinyInteger('is_recurring')->default(0)->nullable();
            $table->tinyInteger('is_transaction')->default(0)->nullable();
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
        Schema::dropIfExists('project_details');
    }
}
