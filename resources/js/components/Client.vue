<template>
    <div class="container">
        <div class="row mt-3">
          <div class="col-12">
            <div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title">List</h3>

                <div class="card-tools">
                   <button class="btn btn-info text-white btn-sm" @click="newModal()">Add New <i class="fas fa-plus"></i></button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover">
                  <tbody>
                  <tr>
                    <th>ID</th>
                    <th>Company Name</th>
                    <th>Company Address</th>
                    <th>Email</th>
                    <th>Mobile No</th>
                    <th>Status</th>
                    <th>Action</th>
                  </tr>
                  <tr v-for="client in clients.data" :key="client.id">
                    <td>{{client.id}}</td>
                    <td>{{client.company_name}}</td>
                    <td>{{client.company_address}}</td>
                    <td>{{client.email}}</td>
                    <td>{{client.mbl_no}}</td>
                    <td v-if="client.status==1">Active</td>
                    <td v-else>Inactive</td>
                    <td>
                      <a href="#" @click="editModal(client)">
                        <i class="fas fa-edit"></i>
                      </a> 
                      <a href="#" @click="deleteClient(client.id)"><i class="fas fa-trash red"></i></a>
                    </td>
                  </tr>
                  
                </tbody></table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer">
                 <pagination :data="clients" 
                    @pagination-change-page="getResults">
                 </pagination>
              </div>
            </div>
            <!-- /.card -->
          </div>
        </div>
        <!-- Start Modal -->
           
        <div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="addNewLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="card card-primary card-outline">
                <div class="card-body">
                <form  @submit.prevent="editmode ? updateClient() : createClient()"  method="post">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                              <h5 class="card-title">Personal Information</h5>
                              
                                <div class="form-group">
                                    <input v-model="form.name" type="text" name="name" class="form-control" placeholder="Name">
                                    <has-error :form="form" field="name"></has-error>
                                </div>
                                <div class="form-group">
                                    <input v-model="form.address" type="text" name="address" class="form-control" placeholder="Address" :class="{ 'is-invalid': form.errors.has('address') }">
                                    <has-error :form="form" field="address"></has-error>
                                </div>
                                <div class="form-group">
                                    <input v-model="form.mbl_no" type="text" name="mbl_no" class="form-control" placeholder="Mbl No" :class="{ 'is-invalid': form.errors.has('mbl_no') }">
                                    <has-error :form="form" field="mbl_no"></has-error>
                                </div>
                                <div class="form-group">
                                    <input v-model="form.birth_date" type="date" name="birth_date" class="form-control" placeholder="Birth date" :class="{ 'is-invalid': form.errors.has('birth_date') }">
                                    <has-error :form="form" field="birth_date"></has-error>
                                </div>
                                <div class="form-group">
                                    <input v-model="form.nationality" type="text" name="nationality" class="form-control" placeholder="nationality" :class="{ 'is-invalid': form.errors.has('nationality') }">
                                    <has-error :form="form" field="nationality"></has-error>
                                </div>
                            </div>
                            <div class="col-md-6">
                               <h5 class="card-title">Company Information</h5>
                                <div class="form-group">
                                    <input v-model="form.company_name" type="text" name="company_name" class="form-control" placeholder="Company name">
                                    <has-error :form="form" field="company_name"></has-error>
                                </div>
                                <div class="form-group">
                                    <input v-model="form.company_address" type="text" name="company_address" class="form-control" placeholder="Company address" :class="{ 'is-invalid': form.errors.has('company_address') }">
                                    <has-error :form="form" field="company_address"></has-error>
                                </div>
                                <div class="form-group">
                                    <input v-model="form.email" type="email" name="email" class="form-control" placeholder="Email" :class="{ 'is-invalid': form.errors.has('email') }">
                                    <has-error :form="form" field="email"></has-error>
                                </div>
                                <div class="form-group">
                                    <input v-model="form.company_mbl_no" type="text" name="company_mbl_no" class="form-control" placeholder="Mbl No" :class="{ 'is-invalid': form.errors.has('company_mbl_no') }">
                                    <has-error :form="form" field="company_mbl_no"></has-error>
                                </div>
                                <div class="form-group">
                                    <input v-model="form.city_country" type="text" name="city_country" class="form-control" placeholder="City Country" :class="{ 'is-invalid': form.errors.has('city_country')}">
                                    <has-error :form="form" field="city_country"></has-error>
                                </div>
                                <div class="form-group">
                                    <select v-model="form.status" name="status" class="form-control" :class="{'is-invalid': form.errors.has('status') }">
                                        <option value="">---Select---</option>
                                        <option value="1">Active</option>
                                        <option value="0">Inactive</option>
                                    </select>
                                    <has-error :form="form" field="status"></has-error>
                                </div>

                                <div class="form-group">
                                    <input v-model="form.website" type="text" name="website" class="form-control" placeholder="Website" :class="{ 'is-invalid': form.errors.has('website') }">
                                    <has-error :form="form" field="website"></has-error>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        <button v-show="editmode" type="submit" class="btn btn-success">Update</button>
                        <button v-show="!editmode" type="submit" class="btn btn-primary">Create</button>
                    </div>
                </form>

                </div>
            </div>
               
            </div>
        </div>
</div>
<!--End Modal -->

    </div>
    
</template>

<script>
    export default {
        
        data() {
        return {
          editmode:false,
          clients :{},
          form:new Form({
            id:'',
            name : '',
            address : '',
            mbl_no: '',
            birth_date: '',
            nationality: '',
            company_name: '',
            company_address: '',
            company_mbl_no: '',
            city_country:'',
            email:'',
            website:'',
            status : ''
          })
        }
      },
      methods: {
        getResults(page = 1) {
          axios.get('api/client?page=' + page)
            .then(response => {
              this.clients = response.data;
            });
        },
        updateClient(){
         this.$Progress.start();
         this.form.put('api/client/'+this.form.id)

        .then(() =>{
            //success
            $('#addNew').modal('hide');
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
       newModal(){
          this.form.reset();
          $('#addNew').modal('show');
       },
       editModal(client){
          this.editmode = true;
          this.form.reset();
          $('#addNew').modal('show');
          this.form.fill(client);
       },
       deleteClient(id){
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
                this.form.delete('api/client/'+id).then(() =>{
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

       mounted() {
        console.log("Component mounted.");
       },

       loadClients(){
        axios.get('api/client').then(({data}) => (this.clients = data));
       },

       createClient(){
         this.$Progress.start();
         this.form.post('api/client')
         .then(() =>{
            Fire.$emit('AfterCreate');
            $('#addNew').modal('hide');
            toast.fire({
                  type: 'success',
                  title: 'Created successfully'
                  });
            this.$Progress.finish();
         })
         .catch(() =>{
            this.$Progress.fail();
         })
         
       }
      },
      created() {

        Fire.$on('searching',() =>{
          let query = this.$parent.search;
          axios.get('api/findClient?q=' + query)
          .then((data) =>{
            this.clients = data.data
          })
          .catch(() =>{

          })
        })

       this.loadClients();
       Fire.$on('AfterCreate',() => {
          this.loadClients();
       });
        //  setInterval(() => this.loadUsers(),3000);
      }

    }
</script>
