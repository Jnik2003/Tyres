<template>
    <div>
        <input type="date" v-model="date" @input="updDate" />
    </div>
</template>

<script>
    export default {
        name: 'InputDateComp',
        props:{
            date: {
                type: String,
            }
        },
        methods:{
            updDate(e){
                // this.$emit('update:date', e.target.value)
                this.$emit('upd', e.target.value)
            }
        }
    }
</script>

<style lang="scss" scoped>

</style>