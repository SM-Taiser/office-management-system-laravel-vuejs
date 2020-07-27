<template>
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">Task Form</div>

                    <div class="card-body">
                        <form action="./api/task" method="post" @submit.prevent="addTask()">
                         <div class="form-group">
                           <input type="text" name="title" placeholder="Title" v-model="title" class="form-control">
                         </div>
                         <div class="form-group">
                           <input type="text" name="status" placeholder="Status" v-model="status" class="form-control">
                         </div>
                         <div class="form-group">
                             <input type="submit" value="Add Task" class="btn btn-info">
                         </div>
                            
                        </form>
                    </div>
        </div>
    </div>
</template>


<script>
    export default {
        data(){
            return {
                title: '',
                status: ''
                }
        },
        mounted() {
            console.log('Component mounted.')
        },
        methods:{
            addTask(){
                axios.post('./api/task',{title:this.title, status:this.status});
                Event.$emit('taskCreated',{title:this.title, status:this.status});
               // this.title = '';
               
            }
        }
    }
</script>