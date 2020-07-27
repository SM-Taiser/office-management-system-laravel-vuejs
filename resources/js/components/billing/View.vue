
<template>
  <div class="content">
     
  <div class="container">
    <button v-on:click="print">Print</button>
   </div>

    <div class="container" id="printMe">
      <div class="row justify-content-between">
        <div class="col-4">
          <address>
            <p>VIP Tower, 3rd Floor <br> 125 Kazirdowry<br>Chittagong 4000, Bangladesh<br>Tel: +88 031 286 8319-20</p>
          </address>
        </div>
        <div class="col-4">
          <strong><i style="font-size: 21px;">INVOICE (BILL)</i></strong><br>
          <b><i>Invoice No:</i></b> &nbsp;&nbsp; {{billings.billing_masters.invoice_no}} <br>
          <b><i>Invoice Date:</i></b> &nbsp;&nbsp; {{billings.billing_masters.date}} <br>
          <b><i>Payment Due Date:</i></b> &nbsp;&nbsp; {{billings.billing_masters.payment_due_date}} <br>
        </div>
      </div> 

      <div class="row justify-content-start">
        <div class="col-5">
         <b><i>Bill To:</i></b>&nbsp;&nbsp; {{billings.billing_masters.name}} <br>
         <b><i>Company:</i></b>&nbsp;&nbsp; {{billings.billing_masters.company_name}} <br>
         <b><i>Address:</i></b>&nbsp;&nbsp; {{billings.billing_masters.company_address}}<br>
         <b><i>Phone:</i></b>&nbsp;&nbsp; {{billings.billing_masters.company_mbl_no}} <br>
        </div>
      </div>
       
       <div class="tbl mt-4">
        <div class="row">
          <div class="col-12">
             
              <!-- /.card-header -->
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th>Sl</th>
                      <th>Particular</th>
                      <th>Unit</th>
                      <th>Rate</th>
                      <th>Discount</th>
                      <th>Amount</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="billing in billings.billing_details" :key="billing.id">
                      <td>{{billing.id}}</td>
                      <td width="40%">{{billing.description}}</td>
                      <td>{{billing.unit}}</td>
                      <td>{{billing.rate}}</td>
                      <td>{{billing.discount}}</td>
                      <td>{{billing.unit*billing.rate-billing.discount}}</td>
                    </tr>
                  </tbody>
              </table>
  
          </div>
        </div>
       </div>

       <div class="row justify-content-end">
        <div class="col-5">
         <b><i>Total:</i></b>&nbsp;&nbsp; {{total}} <br>
         <b><i>Company:</i></b>&nbsp;&nbsp; {{billings.billing_masters.company_name}} <br>
         <b><i>Address:</i></b>&nbsp;&nbsp; {{billings.billing_masters.company_address}}<br>
         <b><i>Phone:</i></b>&nbsp;&nbsp; {{billings.billing_masters.company_mbl_no}} <br>
        </div>
      </div>

      <div class="note">
        <p><i>N.B: Please make all payment in cash or checks payable to "V-link Network".</i></p>
      </div>

      <div class="row justify-content-end">
        <div class="col-5">
         _________________________<br>
          <span class="pl-4"> For V-link Network</span>
        </div>
      </div>

      <div class="row justify-content-center">
        <div class="col-5">
          <h6 class="pt-5">THANK YOU FOR YOUR BUSINESS</h6>
        </div>
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
      computed: {
          total() {
             return this.billings.billing_details.reduce(function(total, obj){
                return total + (obj.rate * obj.unit - obj.discount); 
              },0);
          }
      },
      methods: {
        
       print() {

            this.$htmlToPaper('printMe');
       },


       mounted() {
        
        
       },

       loadBillings(){
        axios.get('api/billing/' + this.$route.params.id).then(({data}) => (this.billings = data));
       },

      },
      // computed: {
      //   total() {
      //     return this.billings.billing_details.reduce(function (sum, item) {
      //       return sum + item.rate
      //     }, 0)
      //   }
      // },
      created() {

        this.loadBillings();
         console.log(this.$route.params.id);

        //  setInterval(() => this.loadUsers(),3000);
      }

    }
</script>
