<template>
    <div class="container">
        <form @submit.prevent="createProject()" method="post">
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-primary card-outline">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-3">
                                    Project Name
                                    <div class="form-group">
                                        <input type="text" name="name" class="form-control" v-model="name" required="">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    Client
                                    <div class="form-group">
                                        <select class="form-control select2" name="client_id" v-model="client_id" required="">
                                            <option value="">---Select---</option>
                                            <option  v-for="client in clients.data" :key="client.id" :value="client.id">{{client.company_name}}</option>
                                        </select>
                                    </div>
                                </div>
                         
                                <div class="col-md-3">
                                    Project Category
                                    <div class="form-group">
                                        <select class="form-control select2" name="project_category_id" v-model="project_category_id" required="">
                                            <option value="">---Select---</option>
                                            <option  v-for="category in categories.data" :key="category.id" :value="category.id">{{category.cata_name}}</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="col-md-3">
                                    Total Project Value
                                    <div class="form-group">
                                        <input type="number" name="total_project_value" class="form-control" v-model="total_project_value" required="">
                                    </div>
                                </div>
                              </div>

                              <div class="row">
                                <div class="col-md-3">
                                    Installation Charge
                                    <div class="form-group">
                                        <input type="number" name="installation_charge" class="form-control" v-model="installation_charge" required="">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    Service Charge
                                    <div class="form-group">
                                        <input type="number" name="service_charge" class="form-control" v-model="service_charge">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    Start Date
                                    <div class="form-group">
                                        <input type="date" name="start_date" class="form-control" v-model="start_date" required="">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    Delivery Date
                                    <div class="form-group">
                                        <input type="date" name="delivery_date" class="form-control" v-model="delivery_date" required="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-primary card-outline">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table" style="font-size:80%">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th width="15%">Item Type</th>
                                            <th width="20%">Particular</th>
                                            <th>Start Date</th>
                                            <th>Delivery Date</th>
                                            <th>Next Billing Date</th>
                                            <th width="12%">Recurring Month </th>
                                            <th width="2%">Will it recurring?</th>
                                            <th>Is Transaction?</th>
                                            <th width="14%">Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(details, k) in project_details" :key="k">
                                            <td scope="row" class="trashIconContainer">
                                                <i class="far fa-trash-alt" @click="deleteRow(k, details)"></i>
                                            </td>
                                            <td>
                                                <div class="form-group">
                                                    <select class="form-control-sm select2" name="item_type_id[]" v-model="details.item_type_id" required="">
                                                        <option value="">Select</option>
                                                        <option  v-for="item in item_types.data" :key="item.id" :value="item.id">{{item.item_name}}</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <input class="form-control-sm" type="text" v-model="details.description" name="description" required="" />
                                            </td>
                                           
                                            <td>
                                                <input class="form-control-sm" type="date" v-model="details.start_date" name="start_date[]"/>
                                            </td>
                                            <td>
                                                <input class="form-control-sm" type="date" v-model="details.delivery_date" name="delivery_date[]"/>
                                            </td>
                                            <td>
                                                <input class="form-control-sm" type="date" v-model="details.next_billing_date" name="next_billing_date[]" required="" />
                                            </td>
                                            <td>
                                                <div class="form-group">
                                                    <select class="form-control-sm select2" name="recurring_month[]" v-model="details.recurring_month" required="">
                                                        <option value="">Select</option>
                                                        <option  v-for="recurring_month in recurring_months"  :value="recurring_month">{{recurring_month}}</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <input class="form-control-sm" type="checkbox" v-model="details.is_recurring" value="1" name="is_recurring[]"/>
                                            </td>
                                            <td>
                                                <input class="form-control-sm" type="checkbox" v-model="details.is_transaction" value="1" name="is_transaction[]"/>
                                            </td>
                                            <td>
                                                <input class="form-control-sm text-right" type="number" v-model="details.amount" name="amount[]" @keyup="calculateTotal()" required="" />
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="5" class="text-right"></td>
                                            <td class="text-right"></td>
                                            <td class="text-right">Total</td>
                                            <td class="text-right">{{total}}</td>
                                        </tr>
                                    </tfoot>
                                </table>
                          
                            </div>
                            <button type='button' class="btn btn-info float-left text-white" @click="addNewRow">
                                <i class="fas fa-plus-circle"></i> Add New
                            </button>

                            <div class="footer">
                                <button type="submit" class="btn btn-primary float-right">Submit</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</template>

<script>
    export default {

    data() {
        return {
              clients :{},
              name: '',
              client_id: '',
              project_category_id: '',
              item_types: {},
              start_date: '',
              delivery_date: '',
              categories: {},
              installation_charge: '', 
              service_charge: '',
              total_project_value: '',
              recurring_months: [1,2,3,4,5,6,7,8,9,10,11,12],
              total: 0,
              project_details: [{
                description: '',
                item_type_id: '',
                start_date: '',
                delivery_date: '',
                next_billing_date: '',
                recurring_month: '',
                is_recurring: '',
                is_transaction: '',
                amount: ''
             }]
        }
      },
    
    methods: {

        calculateTotal() {
           var total_sum = this.project_details.reduce(function (sum, obj) {
                var amount = parseFloat(obj.amount);
                if (!isNaN(amount)) {
                    return sum + amount;
                }
            }, 0);
          this.total = total_sum.toFixed(2);
        },

        deleteRow(index, details) {
            var idx = this.project_details.indexOf(details);
            console.log(idx, index);
            if (idx > -1) {
                this.project_details.splice(idx, 1);
            }
            this.calculateTotal();
        },

        addNewRow() {
            this.project_details.push({
                description: '',
                item_type_id: '',
                start_date: '',
                delivery_date: '',
                next_billing_date: '',
                recurring_month: '',
                is_recurring: '',
                is_transaction: '',
                amount: '',
            });
        },

        createProject(){
          this.$Progress.start();
          axios.post('api/project-register', {
             project_details: this.project_details,
             name: this.name,
             client_id: this.client_id,
             start_date: this.start_date,
             delivery_date: this.delivery_date,
             project_category_id: this.project_category_id,
             total_project_value: this.total_project_value,
             installation_charge: this.installation_charge,
             service_charge: this.service_charge,
          })
          .then(() =>{
            Fire.$emit('AfterCreate');
            toast.fire({
                  type: 'success',
                  title: 'Created successfully'
                  });
            this.$Progress.finish();
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
       this.loadItemType(); 
       this.loadCategories(); 
       this.loadClients();
       Fire.$on('AfterCreate',() => {
          this.loadClients();
          this.loadCategories(); 
          this.loadItemType(); 
       });
    },
        mounted() {
            console.log('Component mounted.')
        }

    }
</script>
