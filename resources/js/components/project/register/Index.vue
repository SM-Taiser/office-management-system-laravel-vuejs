<template>
    <div class="container">
        <div class="row mt-3">
          <div class="col-12">
            <div class="card card-primary card-outline">

              <div class="card-header">
                <h5 class="card-title m-0">List</h5>
              </div>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover">
                  <tbody>
                  <tr>
                    <th>ID</th>
                    <th>Client</th>                    
                    <th>Project Name</th>
                    <th>Category</th>
                    <th>Start Date</th>
                    <th>Total Project Value</th>
                    <th>Service Charge</th>
                    <th>Status</th>
                    <th>Action</th>
                  </tr>
                  <tr v-for="value in project_masters.project_masters" :key="value.id">
                    <td>{{value.id}}</td>
                    <td>{{value.client_info.name}}</td>
                    <td>{{value.name}}</td>
                    <td>{{value.category_info.cata_name}}</td>
                    <td>{{value.start_date| myDate()}}</td>
                    <td>{{value.total_project_value}}</td>
                    <td>{{value.service_charge}}</td>
                    <td v-if="value.status==1">Active</td>
                    <td v-if="value.status==0">Inactive</td>

                    <td>
                     <!--  <a href="#">
                        <i class="fas fa-eye"></i>View
                      </a>  -->
                      <router-link  :to="{ name: 'ProjectView', params: { id: value.id}}"><i class="fas fa-eye"></i>
                          View 
                      </router-link>
                      <a href="#" @click="deleteProject(value.id)"><i class="fas fa-trash red"></i></a>
                    </td>
                  </tr>
                  
                </tbody></table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer">
                 <pagination :data="project_masters" 
                    @pagination-change-page="getResults">
                 </pagination>
              </div>
            </div>
            <!-- /.card -->
          </div>
        </div>
       
    </div>
    
</template>

<script>
    export default {
        
        data() {
        return {
          editmode:false,
          project_masters :{}

        }
      },
      methods: {
        getResults(page = 1) {
          axios.get('api/project-register?page=' + page)
            .then(response => {
              this.project_masters = response.data;
            });
        },
        
       deleteProject(id){
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
                axios.delete('api/project-register/'+id).then(() =>{
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

        console.log(this.project_masters.project_master);

       },

       loadProjectMasters(){
        axios.get('api/project-register').then(({data}) => (this.project_masters = data));
       },

      },
      created() {
        
        
        Fire.$on('searching',() =>{
          let query = this.$parent.search;
          axios.get('api/findProjectRegister?q=' + query)
          .then((data) =>{
            this.project_masters = data.data
          })
          .catch(() =>{

          })
        })

       this.loadProjectMasters();
       Fire.$on('AfterCreate',() => {
       this.loadProjectMasters();
       });

        //  setInterval(() => this.loadUsers(),3000);
      }

    }
</script>
