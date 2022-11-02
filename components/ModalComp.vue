<template>
    <div class="modal" v-if="show">
        <div class="modal__body" @click.stop>
            <slot></slot>
            <button  @click="close">Закрыть</button>
        </div>
               
    </div>
</template>

<script>
    export default {
        name: "ModalComp",
        props:{
            show:{
                type: Boolean,
                default: false,
            }
        },
        methods:{
            close(){              
                this.$emit('update:show', false)
            }
        }
        
    }
</script>

<style lang="scss" scoped>
.modal{
    background-color: rgba($color: #000000, $alpha: .5);
    position: fixed;
    top: 0;
    right: 0;
    left: 0;
    bottom: 0;
    display: flex;
    justify-content: center;
    align-items: center;
}
.modal__body{
    background-color: aliceblue;
    min-height: 200px;
    min-width: 300px;
    padding: 20px;
}
</style>