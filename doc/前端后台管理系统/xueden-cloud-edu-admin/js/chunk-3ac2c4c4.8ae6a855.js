(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-3ac2c4c4"],{"7db0":function(e,t,n){"use strict";var c=n("23e7"),o=n("b727").find,r=n("44d2"),a=n("ae40"),l="find",u=!0,i=a(l);l in[]&&Array(1)[l]((function(){u=!1})),c({target:"Array",proto:!0,forced:u||!i},{find:function(e){return o(this,e,arguments.length>1?arguments[1]:void 0)}}),r(l)},"8fa9":function(e,t,n){"use strict";n.r(t);n("b0c0");var c=n("7a23"),o={key:1},r={key:1},a={key:0},l=Object(c["createTextVNode"])("添加"),u=Object(c["createTextVNode"])("删除"),i={key:1},d=Object(c["createTextVNode"])("保存"),b=Object(c["createTextVNode"])("取消"),f={key:1},j=Object(c["createTextVNode"])("编辑"),O=Object(c["createTextVNode"])("删除"),p=Object(c["createVNode"])("i",{class:"el-icon-plus"},null,-1),k=Object(c["createTextVNode"])(" 新增内容 ");function v(e,t,n,v,m,s){var w=Object(c["resolveComponent"])("el-input"),y=Object(c["resolveComponent"])("el-table-column"),V=Object(c["resolveComponent"])("el-button"),C=Object(c["resolveComponent"])("el-popconfirm"),h=Object(c["resolveComponent"])("el-table"),x=Object(c["resolveDirective"])("loading");return Object(c["openBlock"])(),Object(c["createBlock"])(c["Fragment"],null,[Object(c["withDirectives"])(Object(c["createVNode"])(h,{"row-key":"key","header-row-class-name":"custom-table-header",data:e.TableData},{default:Object(c["withCtx"])((function(){return[Object(c["createVNode"])(y,{label:"姓名",prop:"name"},{default:Object(c["withCtx"])((function(e){var t=e.row;return[t.edit?(Object(c["openBlock"])(),Object(c["createBlock"])(w,{key:0,modelValue:t.name,"onUpdate:modelValue":function(e){return t.name=e},placeholder:"姓名"},null,8,["modelValue","onUpdate:modelValue"])):(Object(c["openBlock"])(),Object(c["createBlock"])("span",o,Object(c["toDisplayString"])(t.name),1))]})),_:1}),Object(c["createVNode"])(y,{label:"工号",prop:"workId"},{default:Object(c["withCtx"])((function(e){var t=e.row;return[t.edit?(Object(c["openBlock"])(),Object(c["createBlock"])(w,{key:0,modelValue:t.workId,"onUpdate:modelValue":function(e){return t.workId=e},placeholder:"工号"},null,8,["modelValue","onUpdate:modelValue"])):(Object(c["openBlock"])(),Object(c["createBlock"])("span",r,Object(c["toDisplayString"])(t.workId),1))]})),_:1}),Object(c["createVNode"])(y,{label:"操作",prop:"action",width:"200"},{default:Object(c["withCtx"])((function(t){var n=t.row;return[n.edit?(Object(c["openBlock"])(),Object(c["createBlock"])(c["Fragment"],{key:0},[n.isNew?(Object(c["openBlock"])(),Object(c["createBlock"])("span",a,[Object(c["createVNode"])(V,{type:"text",onClick:function(t){return e.saveRow(n)}},{default:Object(c["withCtx"])((function(){return[l]})),_:2},1032,["onClick"]),Object(c["createVNode"])(C,{title:"是否要删除此行？",onConfirm:function(t){return e.remove(n.key)}},{reference:Object(c["withCtx"])((function(){return[Object(c["createVNode"])(V,{type:"text"},{default:Object(c["withCtx"])((function(){return[u]})),_:1})]})),_:2},1032,["onConfirm"])])):(Object(c["openBlock"])(),Object(c["createBlock"])("span",i,[Object(c["createVNode"])(V,{type:"text",onClick:function(t){return e.saveRow(n)}},{default:Object(c["withCtx"])((function(){return[d]})),_:2},1032,["onClick"]),Object(c["createVNode"])(V,{type:"text",onClick:function(t){return e.cancel(n.key)}},{default:Object(c["withCtx"])((function(){return[b]})),_:2},1032,["onClick"])]))],64)):(Object(c["openBlock"])(),Object(c["createBlock"])("span",f,[Object(c["createVNode"])(V,{type:"text",onClick:function(t){return e.toggle(n.key)}},{default:Object(c["withCtx"])((function(){return[j]})),_:2},1032,["onClick"]),Object(c["createVNode"])(C,{title:"是否要删除此行？",onConfirm:function(t){return e.remove(n.key)}},{reference:Object(c["withCtx"])((function(){return[Object(c["createVNode"])(V,{type:"text"},{default:Object(c["withCtx"])((function(){return[O]})),_:1})]})),_:2},1032,["onConfirm"])]))]})),_:1})]})),_:1},8,["data"]),[[x,e.TableLoading]]),Object(c["createVNode"])(V,{style:{width:"100%","margin-top":"16px","border-style":"dashed"},onClick:e.newTableData},{default:Object(c["withCtx"])((function(){return[p,k]})),_:1},8,["onClick"])],64)}n("4de4"),n("7db0"),n("4160"),n("d81d"),n("b64b"),n("159b");var m=n("5530"),s=n("3fd4"),w=Object(c["defineComponent"])({name:"TableForm",props:{modelValue:{type:Array,required:!0}},setup:function(e,t){var n=t.emit,o=Object(c["toRefs"])(e),r=o.modelValue,a=Object(c["ref"])(e.modelValue),l=Object(c["ref"])(!1),u=Object(c["ref"])(0),i=function(){var e=a.value.map((function(e){return Object(m["a"])({},e)}));e.push({key:"NEW_TEMP_ID_".concat(u.value),workId:"",name:"",edit:!0,isNew:!0}),u.value++,a.value=e},d=function(e){l.value=!0;var t=e.key,c=e.name,o=e.workId;if(!c||!o)return l.value=!1,void s["a"].error("请填写完整成员信息。");var r=a.value.find((function(e){return e.key===t}));r&&(r.edit=!1,r.isNew=!1,r._originalData=void 0),l.value=!1;var u=a.value.map((function(e){return Object(m["a"])({},e)}));n("update:modelValue",u)},b=function(e){var t=a.value.filter((function(t){return t.key!==e}));a.value=t,n("update:modelValue",t)},f=function(e){var t=a.value.find((function(t){return t.key===e}));t&&(Object.keys(t).forEach((function(e){t[e]=t._originalData[e]})),t._originalData=void 0)},j=function(e){var t=a.value.find((function(t){return t.key===e}));t._originalData=Object(m["a"])({},t),t.edit=!t.edit};return Object(c["watch"])(r,(function(){var e=r.value.map((function(e){return Object(m["a"])({},e)}));a.value=e})),{TableData:a,TableLoading:l,newTableData:i,saveRow:d,remove:b,cancel:f,toggle:j}}});w.render=v;t["default"]=w}}]);