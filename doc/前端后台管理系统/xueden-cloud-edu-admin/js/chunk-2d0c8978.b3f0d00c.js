(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2d0c8978"],{5612:function(e,o,t){"use strict";t.r(o);var n=t("7a23"),l=Object(n["withScopeId"])("data-v-2968ab86");Object(n["pushScopeId"])("data-v-2968ab86");var a=Object(n["createVNode"])("div",{class:"prism-player",id:"J_prismPlayer"},null,-1),c=Object(n["createTextVNode"])("关闭");Object(n["popScopeId"])();var i=l((function(e,o,t,i,r,d){var u=Object(n["resolveComponent"])("el-button"),p=Object(n["resolveComponent"])("el-dialog");return Object(n["openBlock"])(),Object(n["createBlock"])(p,{"close-on-click-modal":!1,"close-on-press-escape":!1,title:e.modelRef.titleVideo,width:"700px","model-value":e.visible,onClose:e.onCancel},{footer:l((function(){return[a,Object(n["createVNode"])(u,{key:"back",type:"primary",onClick:o[1]||(o[1]=function(){return e.onCancel()})},{default:l((function(){return[c]})),_:1})]})),_:1},8,["title","model-value","onClose"])})),r=(t("d3b7"),t("ddb0"),Object(n["defineComponent"])({name:"VideoPreview",props:{visible:{type:Boolean,required:!0},values:{type:Object,required:!0},onCancel:{type:Function,required:!0}},components:{},setup:function(e){var o=Object(n["reactive"])({videoSourceId:e.values.videoSourceId,isFree:0|e.values.isFree,sort:1|e.values.sort,fileKey:e.values.fileKey,titleVideo:e.values.titleVideo,playAuth:e.values.playAuth}),t=Object(n["ref"])(),l=function(){t.value=new window.Aliplayer({id:"J_prismPlayer",autoplay:!0,width:"100%",vid:o.videoSourceId,playauth:o.playAuth,cover:"http://java.goodym.cn/moyuplaylogo.png"},(function(e){console.log("播放器创建好了。")}))};return Object(n["onMounted"])((function(){l()})),{modelRef:o,player:t}}}));r.render=i,r.__scopeId="data-v-2968ab86";o["default"]=r}}]);