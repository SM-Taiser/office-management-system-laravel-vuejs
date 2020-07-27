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
                    <th>Name</th>
                    <th>Description</th>
                    <th>Action</th>
                  </tr>
                  <tr v-for="category in categories.data" :key="category.id">
                    <td>{{category.id}}</td>
                    <td>{{category.cata_name}}</td>
                    <td>{{category.description}}</td>
                    <td>
                        <a href="#" @click="editModal(category)">
                          <i class="fas fa-edit"></i>
                        </a> 
                        <a href="#" @click="deleteCategory(category.id)"><i class="fas fa-trash red"></i></a>
                    </td>
                  </tr>
                </tbody></table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer">
                 <pagination :data="categories" 
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
              <form @submit.prevent="editmode ? updateCategory() : createCategory()" method="post">
              <div class="modal-body">
                <div class="form-group">
                  
                  <input v-model="form.cata_name" type="text" name="cata_name"
                    class="form-control" placeholder="Name" :class="{ 'is-invalid': form.errors.has('cata_name') }">
                  <has-error :form="form" field="cata_name"></has-error>
                </div>
                <div class="form-group">
                    <textarea v-model="form.description" class="form-control" name="description" rows="4" :class="{ 'is-invalid': form.errors.has('description') }"></textarea>
                    <has-error :form="form" field="description"></has-error>
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
          categories :{},
          form:new Form({
            id:'',
            cata_name : '',
            description: ''
          })
        }
      },
     methods: {

        // Our method to GET results from a Laravel endpoint
        getResults(page = 1) {
          axios.get('api/project-category?page=' + page)
            .then(response => {
              this.categories = response.data;
            });
        },
       updateCategory(){
         this.$Progress.start();
         this.form.put('api/project-category/'+this.form.id)

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
       editModal(category){
          this.editmode = true;
          this.form.reset();
          $('#addNew').modal('show');
          this.form.fill(category);
       },
       deleteCategory(id){
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
                this.form.delete('api/project-category/'+id).then(() =>{
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
       loadCategories(){
         axios.get('api/project-category').then(({data}) => (this.categories = data));
       },
       mounted() {
        console.log("Component mounted.");
       },
       createCategory(){
         this.$Progress.start();
         this.form.post('api/project-category')
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

         })
         
       } 
     },
      created() {

        Fire.$on('searching',() =>{
          let query = this.$parent.search;
          axios.get('api/findProjectCategory?q=' + query)
          .then((data) =>{
            this.categories = data.data
          })
          .catch(() =>{

          })
        })
          this.loadCategories();
          Fire.$on('AfterCreate',() => {
          this.loadCategories();
         });
        //  setInterval(() => this.loadUsers(),3000);
      }
    }
</script>
