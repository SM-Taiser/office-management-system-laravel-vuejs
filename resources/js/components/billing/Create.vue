<template>
    <div class="container">
        <form @submit.prevent="createBilling()" method="post">
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-primary card-outline">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-3">
                                    Client
                                    <div class="form-group">
                                        <select class="form-control select2" name="client_id" v-model="client_id" required="">
                                            <option value="">---Select---</option>
                                            <option  v-for="client in clients.data" :key="client.id" :value="client.id">{{client.name}}</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    Invoice No
                                    <div class="form-group">
                                        <input type="" name="invoice_no" class="form-control" v-model="invoice_no" required="">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    Date
                                    <div class="form-group">
                                        <input type="date" name="date" class="form-control" v-model="date" required="">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    Payment Due Date
                                    <div class="form-group">
                                        <input type="date" name="payment_due_date" class="form-control" v-model="payment_due_date" required="">
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
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Particular</th>
                                            <th>Unit</th>
                                            <th>Rate</th>
                                            <th>Discount</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(invoice_product, k) in invoice_products" :key="k">
                                            <td scope="row" class="trashIconContainer">
                                                <i class="far fa-trash-alt" @click="deleteRow(k, invoice_product)"></i>
                                            </td>
                                            <td>
                                                <input class="form-control" type="text" v-model="invoice_product.description" name="description" required="" />
                                            </td>
                                            <td>
                                                <input class="form-control text-right" type="number" min="0" max="10" v-model="invoice_product.unit" name="unit[]" @keyup="calculateLineTotal(invoice_product)" required="" />
                                            </td>
                                            <td>
                                                <input class="form-control text-right" type="number" v-model="invoice_product.rate" name="rate[]" @keyup="calculateLineTotal(invoice_product)" required="" />
                                            </td>
                                            <td>
                                                <input class="form-control" type="number" v-model="invoice_product.discount" name="discount[]" @keyup="calculateLineTotal(invoice_product)" />
                                            </td>

                                            <td>
                                                <input readonly class="form-control text-right" type="number" v-model="invoice_product.line_total" />
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="5" class="text-right">Total</td>
                                            <td class="text-right">{{invoice_subtotal}}</td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                            <button type='button' class="btn btn-info float-left" @click="addNewRow">
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
              client_id: '',
              invoice_no: '',
              date: '',
              payment_due_date:'', 
              invoice_subtotal: 0,
              invoice_total: 0,
              invoice_products: [{
                description: '',
                discount: 0,
                rate: '',
                unit: '',
                line_total: 0
             }]
        }
      },
    
    methods: {
        saveInvoice() {
            console.log(JSON.stringify(this.invoice_products));
        },

        calculateTotal() {
            var subtotal, total;
            subtotal = this.invoice_products.reduce(function (sum, product) {
                var lineTotal = parseFloat(product.line_total);
                if (!isNaN(lineTotal)) {
                    return sum + lineTotal;
                }
            }, 0);

            this.invoice_subtotal = subtotal.toFixed(2);

            // total = (subtotal * (this.invoice_tax / 100)) + subtotal;
            // total = parseFloat(total);
            // if (!isNaN(total)) {
            //     this.invoice_total = total.toFixed(2);
            // } else {
            //     this.invoice_total = '0.00'
            // }
        },

        calculateLineTotal(invoice_product) {
            var total = parseFloat(invoice_product.rate) * parseFloat(invoice_product.unit) - parseFloat(invoice_product.discount);
            if (!isNaN(total)) {
                invoice_product.line_total = total.toFixed(2);
            }
            this.calculateTotal();
        },

        deleteRow(index, invoice_product) {
            var idx = this.invoice_products.indexOf(invoice_product);
            console.log(idx, index);
            if (idx > -1) {
                this.invoice_products.splice(idx, 1);
            }
            this.calculateTotal();
        },

        addNewRow() {
            this.invoice_products.push({
                description: '',
                discount: 0,
                rate: '',
                unit: '',
                line_total: 0
            });
        },

        createBilling(){
          this.$Progress.start();
          axios.post('api/billing', {
             invoice_products: this.invoice_products,
             client_id: this.client_id,
             date: this.date,
             payment_due_date: this.payment_due_date,
             invoice_no: this.invoice_no
          })
          .then(() =>{
            Fire.$emit('AfterCreate');
            toast.fire({
                  type: 'success',
                  title: 'Biiling created successfully'
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
    },
    created(){
       this.loadClients();
       Fire.$on('AfterCreate',() => {
          this.loadClients();
       });
    },
        mounted() {
            console.log('Component mounted.')
        }

    }
</script>
