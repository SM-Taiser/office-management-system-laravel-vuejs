<template>
    <div class="container" id="printMe">
        <div class="row mt-3">
          <div class="col-12">
            <div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title">Billing List </h3> <!-- <button @click="print">Print</button> -->
              </div>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover">
                  <tbody>
                  <tr>
                    <th>ID</th>
                    <th>Client Name</th>
                    <th>Invoice No</th>
                    <th>Date</th>
                    <th>Payment Due Date</th>
                    <th>Action</th>
                  </tr>
                  <tr v-for="billing in billings.data" :key="billing.id">
                    <td>{{billing.id}}</td>
                    <td>{{billing.company_name}}</td>
                    <td>{{billing.invoice_no}}</td>
                    <td>{{billing.date}}</td>
                    <td>{{billing.payment_due_date | myDate()}}</td>
                    <td>
                     <!--  <a href="#">
                        <i class="fas fa-eye"></i>View
                      </a>  -->
                      <router-link  :to="{ name: 'BillingView', params: { id: billing.id}}"><i class="fas fa-eye"></i>
                          View 
                      </router-link>
                      <a href="#" @click="deleteBilling(billing.id)"><i class="fas fa-trash red"></i></a>
                    </td>
                  </tr>
                  
                </tbody></table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer">
                 <pagination :data="billings" 
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
          billings :{}

        }
      },
      methods: {
        getResults(page = 1) {
          axios.get('api/billing?page=' + page)
            .then(response => {
              this.billings = response.data;
            });
        },
        
       
       deleteBilling(id){
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
                axios.delete('api/billing/'+id).then(() =>{
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
       print() {
            // Pass the element id here
            this.$htmlToPaper('printMe');
       },
       download () {
          let pdfName = 'test'; 
          var doc = new jsPDF();
          doc.text(this.name, 10, 10);
          doc.save(pdfName + '.pdf');
       },
       
       mounted() {

        console.log("Component mounted.");

       },

       loadBillings(){
        axios.get('api/billing').then(({data}) => (this.billings = data));
       },

      },
      created() {
        
        
        Fire.$on('searching',() =>{
          let query = this.$parent.search;
          axios.get('api/findBilling?q=' + query)
          .then((data) =>{
            this.billings = data.data
          })
          .catch(() =>{

          })
        })

       this.loadBillings();
       Fire.$on('AfterCreate',() => {
       this.loadBillings();
       });

        //  setInterval(() => this.loadUsers(),3000);
      }

    }
</script>
