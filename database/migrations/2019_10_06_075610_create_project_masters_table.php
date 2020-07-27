<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProjectMastersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('project_masters', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name');
            $table->integer('client_id');
            $table->integer('project_category_id');
            $table->float('installation_charge');
            $table->float('service_charge')->default(0);
            $table->float('total_project_value')->nullable();
            $table->date('start_date');
            $table->date('delivery_date')->nullable();
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
        Schema::dropIfExists('project_masters');
    }
}
