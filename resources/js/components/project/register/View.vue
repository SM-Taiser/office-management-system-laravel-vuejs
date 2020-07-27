<template>
    <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-primary card-outline">
                        <div class="card-body">
                          <div class="card-header">
			                <h3 class="card-title">Basic Info</h3>
			                <div class="card-tools">
			                   <button class="btn btn-info text-white btn-sm" @click="editModal()">Edit <i class="fas fa-edit"></i></button>
			                </div>
			              </div>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Project Name</th>
                                            <th>Client</th>
                                            <th>Project Category</th>
                                            <th>Total Project Value</th>
                                            <th>Installation Charge</th>
                                            <th>Service Charge</th>
                                            <th>Start Date</th>
                                            <th>Delivery Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td> {{projects.project_masters.name}} </td>
                                            <td> {{projects.project_masters.client_info.company_name}} </td>
                                            <td> {{projects.project_masters.category_info.cata_name}} </td>
                                            <td> {{projects.project_masters.total_project_value}}</td>
                                            <td> {{projects.project_masters.installation_charge}}</td>
                                            <td> {{projects.project_masters.service_charge}}</td>
                                            <td> {{projects.project_masters.start_date}}</td>
                                            <td> {{projects.project_masters.delivery_date}}</td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-primary card-outline">
                        <div class="card-body">
						    <div class="card-header">
						      <h3 class="card-title">Details Info</h3>
						       <div class="card-tools">
						         <button class="btn btn-info text-white btn-sm" @click="newModal()">Add New <i class="fas fa-plus "></i></button>
						      </div>
						     </div>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th width="15%">Item Type</th>
                                            <th width="20%">Particular</th>
                                            <th>Start Date</th>
                                            <th>Delivery Date</th>
                                            <th>Next Billing Date</th>
                                            <th width="12%">Recurring Month </th>
                                            <th width="2%">Is Recurring?</th>
                                            <th width="2%">Is Transaction?</th>
                                            <th width="14%">Amount</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(val, index) in projects.project_details" :key="val.id">
                                            <td>{{++index}} </td>
                                            <td>{{val.item_type_info.item_name}} </td>
                                            <td>{{val.description}}</td>
                                            <td>{{val.start_date}}</td>
                                            <td>{{val.delivery_date}}</td>
                                            <td>{{val.next_billing_date}}</td>
                                            <td>{{val.recurring_month}}</td>
                                            <td v-if="val.is_recurring==1">Yes</td>
                                            <td v-if="val.is_recurring==0">No</td>
                                            <td v-if="val.is_transaction==1">Yes</td>
                                            <td v-if="val.is_transaction==0">No</td>                                       
                                            <td>{{val.amount}}</td>
                                            <td>
                                            	<a href="#" @click="editProjectDetails(val)">
						                          <i class="fas fa-edit"></i>
						                        </a> 
						                        <a href="#" @click="deleteProjectDetails(val.id)"><i class="fas fa-trash red"></i></a>
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td class="text-right"></td>
                                            <td class="text-right"></td>
                                            <td class="text-right"></td>
                                            <td class="text-right"></td>
                                            <td class="text-right"></td>
                                            <td class="text-right"></td>
                                            <td class="text-right"></td>
                                            <td class="text-right"></td>
                                            <td class="text-right"><b>Total:</b></td>
                                            <td>{{total}}</td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>


                            <!-- <div class="footer">
                                <button type="submit" class="btn btn-primary float-right">Submit</button>
                            </div> -->
                        </div>
                    </div>
                </div>
            </div>
        <!--Start Edit Modal -->    
        <div class="modal fade" id="edit" tabindex="-1" role="dialog" aria-labelledby="addNewLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="card card-primary card-outline">
                <div class="card-body">
                <form  @submit.prevent="updateProjectMaster()"  method="post">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-7">
							  <div class="form-group row">
							    <label for="inputPassword" class="col-sm-4 col-form-label">Project Name</label>
							    <div class="col-sm-8">
							      <input type="text" v-model="form.name" name="name" class="form-control" id="inputPassword" placeholder="Password">
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="inputPassword" class="col-sm-4 col-form-label">Client</label>
							    <div class="col-sm-8">
						            <select class="form-control select2" name="client_id" v-model="form.client_id" required="">
						                <option value="">---Select---</option>
						                <option  v-for="client in clients.data" :key="client.id" :value="client.id">{{client.company_name}}</option>
						            </select>
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="inputPassword" class="col-sm-4 col-form-label">Project Category</label>
							    <div class="col-sm-8">
						            <select class="form-control select2" name="project_category_id" v-model="form.project_category_id" required="">
						                <option value="">---Select---</option>
						                <option  v-for="category in categories.data" :key="category.id" :value="category.id">{{category.cata_name}}</option>
						            </select>
							    </div>
							  </div>

                              <div class="form-group row">
                                <label for="inputPassword" class="col-sm-4 col-form-label">Total Project Value</label>
                                <div class="col-sm-8">
                                   <input type="number" name="total_project_value" class="form-control" v-model="form.total_project_value" required="">
                                </div>
                              </div>

							  <div class="form-group row">
							    <label for="inputPassword" class="col-sm-4 col-form-label">Installation Charge</label>
							    <div class="col-sm-8">
							       <input type="number" name="installation_charge" class="form-control" v-model="form.installation_charge" required="">
							    </div>
							  </div>

                            </div>
                            <div class="col-md-5">
                               <div class="form-group row">
							    <label for="inputPassword" class="col-sm-4 col-form-label">Service Charge</label>
							    <div class="col-sm-8">
							       <input type="number" name="service_charge" class="form-control" v-model="form.service_charge">
							    </div>
							  </div>

							  <div class="form-group row">
							    <label for="inputPassword" class="col-sm-4 col-form-label">Start Date</label>
							    <div class="col-sm-8">
							       <input type="date" name="start_date" class="form-control" v-model="form.start_date" required="">
							    </div>
							  </div>

                              <div class="form-group row">
                                <label for="inputPassword" class="col-sm-4 col-form-label">Delivery Date</label>
                                <div class="col-sm-8">
                                   <input type="date" name="delivery_date" class="form-control" v-model="form.delivery_date" required="">
                                </div>
                              </div>

							  <div class="form-group row">
							    <label for="inputPassword" class="col-sm-4 col-form-label">Status</label>
							    <div class="col-sm-8">
							       <select v-model="form.status" name="status" class="form-control">
                                        <option value="">---Select---</option>
                                        <option value="1">Active</option>
                                        <option value="0">Inactive</option>
                                    </select>
							    </div>
							  </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        <button  type="submit" class="btn btn-success">Update</button>
                    </div>
                </form>

                </div>
              </div>
            </div>
          </div>
        </div>
        <!--End Edit Modal -->    

       <!--Start Add new Modal -->    
        <div class="modal fade" id="newModal" tabindex="-1" role="dialog" aria-labelledby="addNewLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="card card-primary card-outline">
                <div class="card-body">
                <form  @submit.prevent="editMode? updateProjectDetails() : addNew() "  method="post">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-7">
							  <div class="form-group row">
							    <label for="inputPassword" class="col-sm-4 col-form-label">Item Type</label>
							    <div class="col-sm-8">
							       <select class="form-control select2" name="item_type_id" v-model="form_add_new.item_type_id" required="">
						                <option value="">---Select---</option>
						                <option  v-for="item in item_types.data" :key="item.id" :value="item.id">{{item.item_name}}</option>
						            </select>
							    </div>
							  </div>
							  
							  <div class="form-group row">
							    <label for="inputPassword" class="col-sm-4 col-form-label">Description</label>
							    <div class="col-sm-8">
						            <textarea v-model="form_add_new.description" class="form-control" name="description" rows="4" :class="{ 'is-invalid': form.errors.has('description') }"></textarea>
							    </div>
							  </div>

							  <div class="form-group row">
							    <label for="inputPassword" class="col-sm-4 col-form-label">Start Date</label>
							    <div class="col-sm-8">
							       <input type="date" name="start_date" class="form-control" v-model="form_add_new.start_date" required="">
							    </div>
							  </div>

                              <div class="form-group row">
                                <label for="inputPassword" class="col-sm-4 col-form-label">Delivery Date</label>
                                <div class="col-sm-8">
                                   <input type="date" name="delivery_date" class="form-control" v-model="form_add_new.delivery_date" required="">
                                </div>
                              </div>

                            </div>
                            <div class="col-md-5">
                               <div class="form-group row">
							    <label for="inputPassword" class="col-sm-4 col-form-label">Next Billing Date </label>
							    <div class="col-sm-8">
							       <input type="date" name="next_billing_date" class="form-control" v-model="form_add_new.next_billing_date">
							    </div>
							   </div>

							  <div class="form-group row">
                                <label for="inputPassword" class="col-sm-4 col-form-label">Recurring Month </label>
							  	<div class="col-sm-8">
			  		                <select class="form-control select2" name="recurring_month" v-model="form_add_new.recurring_month" required="">
                                        <option value="">Select</option>
                                        <option  v-for="recurring_month in recurring_months"  :value="recurring_month">{{recurring_month}}</option>
                                    </select>
							  	</div>
							  </div>

							  <div class="form-group row">
                                <label for="inputPassword" class="col-sm-6 col-form-label">Is Recurring? </label>
							  	<div class="col-sm-2">
			  		               <input class="form-control" type="checkbox" v-model="form_add_new.is_recurring" value="1" name="is_recurring"/>
							  	</div>
							  </div>

                              <div class="form-group row">
                                <label for="inputPassword" class="col-sm-6 col-form-label">Is Transaction? </label>
                                <div class="col-sm-2">
                                   <input class="form-control" type="checkbox" v-model="form_add_new.is_transaction" value="1" name="is_transaction"/>
                                </div>
                              </div>

							  <div class="form-group row">
							    <label for="inputPassword" class="col-sm-4 col-form-label">Amount</label>
							    <div class="col-sm-8">
							       <input class="form-control text-right" type="number" v-model="form_add_new.amount" name="amount" required="" />
							    </div>
							  </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        <button v-show="editMode" type="submit" class="btn btn-primary">Update</button>
                        <button v-show="!editMode" type="submit" class="btn btn-primary">Create</button>
                    </div>
                </form>

                </div>
              </div>
            </div>
          </div>
        </div>
        <!--End Add new Modal --> 
       
       </div>
</template>

<script>
    export default {

    data() {
        return {
              projects :{},
              editMode:false,
			  item_types: {},
              clients: {},
              categories: {},
			  recurring_months: [1,2,3,4,5,6,7,8,9,10,11,12],

			  form:new Form({
                id:'',
	            name: '',
				client_id: '',
				project_category_id: '',
				start_date: '',
                total_project_value: '',
				installation_charge: '', 
                delivery_date: '',
				service_charge: '',
				status:''
	          }),

	          form_add_new:new Form({
                id: '',
	          	description: '',
                item_type_id: '',
                start_date: '',
                delivery_date: '',
                next_billing_date: '',
                recurring_month: '',
                is_recurring: '',
                is_transaction: '',
                amount: ''
	          })
        }
      },
    computed: {
          total() {
             return this.projects.project_details.reduce(function(total, obj){
                return total + (obj.amount); 
              },0);
          }
      },
    methods: {
       loadProjects(){
         axios.get('api/project-register/'+ this.$route.params.id).then(({data}) => (this.projects = data));
       },
       editModal(){
          this.form.reset();
          $('#edit').modal('show');
          this.form.fill(this.projects.project_masters);
       },
      newModal(){
      	  this.editMode = false;
          this.form_add_new.reset();
          $('#newModal').modal('show');
       },

      editProjectDetails(val){
      	this.editMode = true;
        this.form_add_new.reset();
        $('#newModal').modal('show');
        this.form_add_new.fill(val);

       },

      addNew(){
       	 this.$Progress.start();
         this.form_add_new.post('api/project-register/single-create/'+ this.$route.params.id)
           .then(() =>{
            Fire.$emit('AfterCreate');
            toast.fire({
                  type: 'success',
                  title: 'Created successfully'
                  });

            this.$Progress.finish();
            $('#newModal').modal('hide');
           })

          .catch(() =>{
            this.$Progress.fail();
            swal.fire(
                    'Failed!',
                    'There was something wrong.',
                    'warning'
                 );
          })
       },
		updateProjectDetails(){
		 this.$Progress.start();
         this.form_add_new.put('api/project-register/project-details-update/'+this.form_add_new.id)

        .then(() =>{
            //success
         $('#newModal').modal('hide');
            swal.fire(
              'Updated!',
              'Information has been updated.',
              'success'
            )
            Fire.$emit('AfterCreate');
            this.$Progress.finish();
        })
        .catch(() =>{
            this.$Progress.fail();
        })
		},
		deleteProjectDetails(id){
			swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
          }).then((result) => {

            //Send request to the server
            if (result.value) {
                this.form_add_new.delete('api/project-register/project-details-delete/'+id).then(() =>{
                      swal.fire(
                        'Deleted!',
                        'Your info has been deleted.',
                        'success'
                      )
                      Fire.$emit('AfterCreate');
                }).catch(()=>{
                      swal.fire(
                        'Failed!',
                        'There was something wrong.',
                        'warning'
                      );
                });
            }
          })
		},
       updateProjectMaster(){
         this.$Progress.start();
         this.form.put('api/project-register/'+this.form.id)

        .then(() =>{
            //success
            $('#edit').modal('hide');
            swal.fire(
              'Updated!',
              'Information has been updated.',
              'success'
            )
            Fire.$emit('AfterCreate');
            this.$Progress.finish();
        })
        .catch(() =>{
            this.$Progress.fail();
        })
       },

       loadClients(){
         axios.get('api/client').then(({data}) => (this.clients = data));
       },
       loadCategories(){
         axios.get('api/project-category').then(({data}) => (this.categories = data));
       },
       loadItemType(){
         axios.get('api/project-item-type').then(({data}) => (this.item_types = data));
       },

    },
    created(){

       this.loadClients();
       this.loadProjects(); 
       this.loadItemType(); 
       this.loadCategories(); 
       Fire.$on('AfterCreate',() => {
          this.loadProjects(); 
          this.loadItemType(); 
          this.loadCategories(); 
          this.loadClients();
       });
    },
        mounted() {
            console.log('Component mounted.')
        }

    }
</script>
