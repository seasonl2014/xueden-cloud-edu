(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2d20901b"],{a6e5:function(e,t,n){"use strict";n.r(t);var o=n("7a23");function l(e,t,n,l,a,u){var c=Object(o["resolveComponent"])("el-option"),r=Object(o["resolveComponent"])("el-select");return Object(o["openBlock"])(),Object(o["createBlock"])(r,{modelValue:e.value,"onUpdate:modelValue":t[1]||(t[1]=function(t){return e.value=t}),clearable:""},{default:Object(o["withCtx"])((function(){return[Object(o["createVNode"])(c,{label:"头部",value:"header"}),Object(o["createVNode"])(c,{label:"底部",value:"footer"})]})),_:1},8,["modelValue"])}var a=Object(o["defineComponent"])({name:"TypeSelect",props:{modelValue:{type:String,default:""}},setup:function(e,t){var n=t.emit,l=Object(o["computed"])({get:function(){return e.modelValue},set:function(e){n("update:modelValue",e||"")}});return{value:l}}});a.render=l;t["default"]=a}}]);