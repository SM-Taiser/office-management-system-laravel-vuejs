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
                    <th>Action</th>
                  </tr>
                  <tr v-for="item in item_types.data" :key="item.id">
                    <td>{{item.id}}</td>
                    <td>{{item.item_name}}</td>

                    <td>
                        <a href="#" @click="editModal(item)">
                          <i class="fas fa-edit"></i>
                        </a> 
                        <a href="#" @click="deleteItem(item.id)"><i class="fas fa-trash red"></i></a>
                    </td>
                  </tr>
                </tbody></table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer">
                 <pagination :data="item_types" 
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
              <form @submit.prevent="editmode ? updateItem() : createItem()" method="post">
              <div class="modal-body">
                <div class="form-group">
                  
                  <input v-model="form.item_name" type="text" name="item_name"
                    class="form-control" placeholder="Item Name" :class="{ 'is-invalid': form.errors.has('item_name') }">
                  <has-error :form="form" field="item_name"></has-error>
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
          item_types :{},
          form:new Form({
            id:'',
            item_name : ''    
          })
        }
      },
     methods: {

        // Our method to GET results from a Laravel endpoint
        getResults(page = 1) {
          axios.get('api/project-item-type?page=' + page)
            .then(response => {
              this.item_types = response.data;
            });
        },
       updateItem(){
         this.$Progress.start();
         this.form.put('api/project-item-type/'+this.form.id)

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
       editModal(item){
          this.editmode = true;
          this.form.reset();
          $('#addNew').modal('show');
          this.form.fill(item);
       },
       deleteItem(id){
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
                this.form.delete('api/project-item-type/'+id).then(() =>{
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
       loadItemTypes(){
         axios.get('api/project-item-type').then(({data}) => (this.item_types = data));
       },
       mounted() {
        console.log("Component mounted.");
       },
       createItem(){
         this.$Progress.start();
         this.form.post('api/project-item-type')
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
          axios.get('api/findProjectItemType?q=' + query)
          .then((data) =>{
            this.item_types = data.data
          })
          .catch(() =>{

          })
        })
          this.loadItemTypes();
          Fire.$on('AfterCreate',() => {
          this.loadItemTypes();
         });
        //  setInterval(() => this.loadUsers(),3000);
      }
    }
</script>
