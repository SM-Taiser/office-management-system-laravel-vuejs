
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');
import moment from 'moment';

import jsPDF from 'jsPDF';
window.jsPDF = jsPDF;
//For print

import Vue from 'vue';
import VueHtmlToPaper from 'vue-html-to-paper';
 
const options = {
  name: '_blank',
  specs: [
    'fullscreen=yes',
    'titlebar=yes',
    'scrollbars=yes'
  ],
  styles: [
    'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css',
    'https://unpkg.com/kidlat-css/css/kidlat.css'
  ]
}
 
Vue.use(VueHtmlToPaper, options);

//For print


import { Form, HasError, AlertError } from 'vform'
window.Form = Form;
Vue.component(HasError.name, HasError)
Vue.component(AlertError.name, AlertError)
Vue.component('pagination', require('laravel-vue-pagination'));

window.Event = new Vue();
import VueRouter from 'vue-router';
Vue.use(VueRouter)


Vue.prototype.BASE_URL = "http://localhost/lara-vue/";

//PROGRESSBAR
import VueProgressBar from 'vue-progressbar';
Vue.use(VueProgressBar, {
  color: 'rgb(143, 255, 199)',
  failedColor: 'red',
  height: '2px'
});
//PROGRESSBAR

//Sweetalert2
import swal from 'sweetalert2';
window.swal = swal;

const toast = swal.mixin({
  toast: true,
  position: 'bottom-end',
  showConfirmButton: false,
  timer: 6000
});
window.toast = toast;
//Sweetalert2
//Base URL


let routes = [
    { path: '/dashboard', component: require('./components/Dashboard.vue').default},
    { path: '/developer', component: require('./components/Developer.vue').default},
    { path: '/profile', component: require('./components/Profile.vue').default},
    { path: '/users', component: require('./components/Users.vue').default},
    { path: '/client', component: require('./components/Client.vue').default},
    
    //For Billing
    { path: '/billing/create', component: require('./components/billing/Create.vue').default},
    { path: '/billing/index', component: require('./components/billing/Index.vue').default},
    { path: '/billing/view/:id', name: 'BillingView', component: require('./components/billing/View.vue').default},
    //For Billing

    //For Projects
    { path: '/project/category', component: require('./components/project/ProjectCategory.vue').default},
    { path: '/project/item-type', component: require('./components/project/ItemType.vue').default},
    { path: '/project/register/create', component: require('./components/project/register/Create.vue').default},
    { path: '/project/register/index', component: require('./components/project/register/Index.vue').default},
    { path: '/project/register/view/:id', name:'ProjectView', component: require('./components/project/register/View.vue').default},

    //For Projects


    { path: '*', component: require('./components/NotFound.vue').default}

  ]
  const router = new VueRouter({
    //mode: 'history',
    routes // short for `routes: routes`
  });  

  Vue.filter('myDate',function(created){
    return moment(created).format('MMMM Do YYYY'); // May 16th 2019, 2:27:09 pm
  });

  window.Fire =  new Vue();

  //axios.defaults.baseURL = 'lara-vue/';
/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

// const files = require.context('./', true, /\.vue$/i);
// files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default));
//Start Passport 
Vue.component(
  'passport-clients',
  require('./components/passport/Clients.vue').default
);

Vue.component(
  'passport-authorized-clients',
  require('./components/passport/AuthorizedClients.vue').default
);

Vue.component(
  'passport-personal-access-tokens',
  require('./components/passport/PersonalAccessTokens.vue').default
);
//End Passport 

Vue.component('example-component', require('./components/ExampleComponent.vue').default);
Vue.component('task-form', require('./components/TaskForm.vue').default);
Vue.component('task-list', require('./components/TaskList.vue').default);


/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

const app = new Vue({
    el: '#app',
    router,
    data:{
       search: ''
    },

    methods:{
      searchit: _.debounce(() => {
         Fire.$emit('searching');
      },2000)
    }

});

