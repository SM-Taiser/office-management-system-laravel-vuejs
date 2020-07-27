<template>
    <div class="container">
        <div class="row mt-3">
          <div class="col-12">
            <div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title">Users Table</h3>

                <div class="card-tools">
                  <button class="btn btn-success" @click="newModal()">Add New<i class="fas fa-user-plus fa"></i></button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover">
                  <tbody>
                  <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Type</th>
                    <th>Date</th>
                    <th>Action</th>
                  </tr>
                  <tr v-for="user in users.data" :key="user.id">
                    <td>{{user.id}}</td>
                    <td>{{user.name}}</td>
                    <td>{{user.email}}</td>
                    <td>{{user.role}}</td>
                    <td>{{user.created | myDate()}}</td>
                    <td>
                        <a href="#" @click="editModal(user)">
                          <i class="fas fa-edit"></i>
                        </a> 
                        <a href="#" @click="deleteUser(user.id)"><i class="fas fa-trash red"></i></a>
                    </td>
                  </tr>
                </tbody></table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer">
                 <pagination :data="users" 
                    @pagination-change-page="getResults">
                 </pagination>
              </div>
            </div>
            <!-- /.card -->
          </div>
        </div>
        <!-- Start Modal -->
        <div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="addNewLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="addNewLabel">Add New</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <form @submit.prevent="editmode ? updateUser() : createUser()" method="post">
              <div class="modal-body">
                <div class="form-group">
                  
                  <input v-model="form.name" type="text" name="name"
                    class="form-control" placeholder="Name" :class="{ 'is-invalid': form.errors.has('name') }">
                  <has-error :form="form" field="name"></has-error>
                </div>
                <div class="form-group">
                  <input v-model="form.email" type="email" name="email"
                    class="form-control" placeholder="Email" :class="{ 'is-invalid': form.errors.has('email') }">
                  <has-error :form="form" field="email"></has-error>
                </div>
                <div class="form-group">
                  <select v-model="form.role"  name="role"
                    class="form-control" :class="{ 'is-invalid': form.errors.has('role') }">
                      <option value="">Select User Role</option>
                      <option value="admin">Admin</option>
                      <option value="user">User</option>
                      <option value="author">Author</option>
                  </select>
                  <has-error :form="form" field="role"></has-error>
                </div>
                <div class="form-group">
                  <input v-model="form.password" type="password" name="password"
                    class="form-control" placeholder="Password" :class="{ 'is-invalid': form.errors.has('password') }">
                  <has-error :form="form" field="password"></has-error>
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
        <!--End Modal -->
    </div>
    
</template>

<script>
    export default {
      data() {
        return {
          editmode:false,
          users :{},
          form:new Form({
            id:'',
            name : '',
            email: '',
            password: '',
            role : ''
          })
        }
      },
     methods: {

        // Our method to GET results from a Laravel endpoint
        getResults(page = 1) {
          axios.get('api/user?page=' + page)
            .then(response => {
              this.users = response.data;
            });
        },
       updateUser(){
         this.$Progress.start();
         this.form.put('api/user/'+this.form.id)

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
          this.editmode = false;
          this.form.reset();
          $('#addNew').modal('show');
       },
       editModal(user){
          this.editmode = true;
          this.form.reset();
          $('#addNew').modal('show');
          this.form.fill(user);
       },
       deleteUser(id){
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
                this.form.delete('api/user/'+id).then(() =>{
                      swal.fire(
                        'Deleted!',
                        'Your file has been deleted.',
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
       loadUsers(){
         axios.get('api/user').then(({data}) => (this.users = data));
       },
       createUser(){
         this.$Progress.start();
         this.form.post('api/user')
         .then(() =>{
            Fire.$emit('AfterCreate');
            $('#addNew').modal('hide');
            toast.fire({
                  type: 'success',
                  title: 'User created successfully'
                  });
            this.$Progress.finish();
         })
         .catch(() =>{

         })
         
       } 
     },
      created() {

        Fire.$on('searching',() =>{
          let query = this.$parent.search;
          axios.get('api/findUser?q=' + query)
          .then((data) =>{
            this.users = data.data
          })
          .catch(() =>{

          })
        })
          this.loadUsers();
          Fire.$on('AfterCreate',() => {
          this.loadUsers();
         });
        //  setInterval(() => this.loadUsers(),3000);
      }
    }
</script>
