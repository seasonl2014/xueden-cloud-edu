(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-19210000"],{"1da1":function(t,e,n){"use strict";n.d(e,"a",(function(){return i}));n("d3b7");function r(t,e,n,r,i,o,a){try{var c=t[o](a),s=c.value}catch(l){return void n(l)}c.done?e(s):Promise.resolve(s).then(r,i)}function i(t){return function(){var e=this,n=arguments;return new Promise((function(i,o){var a=t.apply(e,n);function c(t){r(a,i,o,c,s,"next",t)}function s(t){r(a,i,o,c,s,"throw",t)}c(void 0)}))}}},"5a91":function(t,e,n){"use strict";n.r(e);var r=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"j-video-left"},[n("div",{staticClass:"j-video-title"},[n("img",{attrs:{src:t.vImgSrc}}),t._v(" "+t._s(t.detailsVideo.title)+" ")]),t._m(0)])},i=[function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"j-video-box"},[n("div",{staticClass:"prism-player",attrs:{id:"J_prismPlayer"}})])}],o=(n("96cf"),n("1da1")),a=n("0407"),c={name:"playVideo",data:function(){return{isEn:!1,vImgSrc:n("aaa9"),videoId:null,detailsVideo:{title:"学灯网温馨提示，请先登录再来观看"},player:"",VideoADComponent:null}},methods:{getVideo:function(t){var e=this;Object(a["a"])("edu/front/video/get/"+t).then((function(t){t.data.success?(e.detailsVideo=t.data.data,e.videoId=e.detailsVideo.id,1==e.detailsVideo.displayAds?e.VideoADComponent=null:e.VideoADComponent={name:"VideoADComponent",type:AliPlayerComponent.VideoADComponent,args:["http://java.goodym.cn/adv.mp4","http://java.goodym.cn/",e.videoAdClose,e.isEn?"Skip Ad":"VIP关闭广告"]},e.playVideoByVideoId(e.detailsVideo.videoSourceId)):10002===t.data.code?(e.creatAliplayer(e.player),e.$notify({title:"学灯网温馨提示",message:"请先登录再来观看吧",type:"warning",offset:200})):(e.detailsVideo.title=t.data.message,e.$notify({title:"学灯网温馨提示",message:t.data.message,type:"warning",offset:200}))})).catch((function(t){e.loading=!1}))},playVideoByVideoId:function(t){var e=this;return Object(o["a"])(regeneratorRuntime.mark((function n(){var r,i,o;return regeneratorRuntime.wrap((function(n){while(1)switch(n.prev=n.next){case 0:return r=e,n.next=3,Object(a["a"])("edu/vod/getPlayAuth2/"+t);case 3:i=n.sent,o=i.data,o.success&&(r.detailsVideo.playAuth=o.data.playAuth,r.creatAliplayer(e.player),r.player.getComponent("PreviewVodComponent").closePreviewLayer(),0===r.detailsVideo.isFree&&(r.player.isPreview(!1),r.player.setPreviewTime(0)));case 6:case"end":return n.stop()}}),n)})))()},videoAdClose:function(t){this.$notify({title:"温馨提示",message:"购买课程或者加入VIP可以去掉广告",type:"success",offset:200})},creatAliplayer:function(t){var e=this;""!=t&&this.player.dispose(),this.player=new Aliplayer({id:"J_prismPlayer",width:"100%",height:"460px",autoplay:!0,vid:e.detailsVideo.videoSourceId,playauth:e.detailsVideo.playAuth,cover:"http://java.goodym.cn/moyuplaylogo.png",encryptType:1,components:[{name:"PreviewVodComponent",type:AliPlayerComponent.PreviewVodComponent,args:[e.detailsVideo.previewDuration,'<div class="vip_limit_content"><div class="vip_limit_wrap"><p class="title">请先购买课程或加入VIP免费观看</p><div class="vip_limit_button_box"><a class="vip_limit_btn">加入 VIP</a></div><div class="vip_limit_close"><span class="vip_limit_close_btn">x</span></div></div></div>','<a  class="vip-join"  style="color: wheat;">购买课程或加入VIP</a> 观看完整视频']},{name:"QualityComponent",type:AliPlayerComponent.QualityComponent},this.VideoADComponent,{name:"RateComponent",type:AliPlayerComponent.RateComponent}]},(function(t){console.log("播放器创建好了。");var n=document.querySelector(".vip_limit_btn");n.addEventListener("click",(function(){window.open("//"+window.location.host+"/details/"+e.detailsVideo.courseId)}));var r=document.querySelector(".vip_limit_close_btn");r.addEventListener("click",(function(){t.getComponent("PreviewVodComponent").closePreviewLayer()}));var i=document.querySelector(".vip-join");i.addEventListener("click",(function(){window.open("//"+window.location.host+"/details/"+e.detailsVideo.courseId)}))}))}},watch:{$route:function(t,e){this.videoId=this.$route.params.videoId,this.getVideo(this.videoId)}},created:function(){this.videoId=this.$route.params.videoId,this.getVideo(this.videoId)}},s=c,l=n("2877"),u=Object(l["a"])(s,r,i,!1,null,"3b58d223",null);e["default"]=u.exports},"96cf":function(t,e){!function(e){"use strict";var n,r=Object.prototype,i=r.hasOwnProperty,o="function"===typeof Symbol?Symbol:{},a=o.iterator||"@@iterator",c=o.asyncIterator||"@@asyncIterator",s=o.toStringTag||"@@toStringTag",l="object"===typeof t,u=e.regeneratorRuntime;if(u)l&&(t.exports=u);else{u=e.regeneratorRuntime=l?t.exports:{},u.wrap=A;var d="suspendedStart",p="suspendedYield",h="executing",f="completed",v={},y={};y[a]=function(){return this};var m=Object.getPrototypeOf,g=m&&m(m(S([])));g&&g!==r&&i.call(g,a)&&(y=g);var w=I.prototype=b.prototype=Object.create(y);x.prototype=w.constructor=I,I.constructor=x,I[s]=x.displayName="GeneratorFunction",u.isGeneratorFunction=function(t){var e="function"===typeof t&&t.constructor;return!!e&&(e===x||"GeneratorFunction"===(e.displayName||e.name))},u.mark=function(t){return Object.setPrototypeOf?Object.setPrototypeOf(t,I):(t.__proto__=I,s in t||(t[s]="GeneratorFunction")),t.prototype=Object.create(w),t},u.awrap=function(t){return{__await:t}},V(j.prototype),j.prototype[c]=function(){return this},u.AsyncIterator=j,u.async=function(t,e,n,r){var i=new j(A(t,e,n,r));return u.isGeneratorFunction(e)?i:i.next().then((function(t){return t.done?t.value:i.next()}))},V(w),w[s]="Generator",w[a]=function(){return this},w.toString=function(){return"[object Generator]"},u.keys=function(t){var e=[];for(var n in t)e.push(n);return e.reverse(),function n(){while(e.length){var r=e.pop();if(r in t)return n.value=r,n.done=!1,n}return n.done=!0,n}},u.values=S,M.prototype={constructor:M,reset:function(t){if(this.prev=0,this.next=0,this.sent=this._sent=n,this.done=!1,this.delegate=null,this.method="next",this.arg=n,this.tryEntries.forEach(G),!t)for(var e in this)"t"===e.charAt(0)&&i.call(this,e)&&!isNaN(+e.slice(1))&&(this[e]=n)},stop:function(){this.done=!0;var t=this.tryEntries[0],e=t.completion;if("throw"===e.type)throw e.arg;return this.rval},dispatchException:function(t){if(this.done)throw t;var e=this;function r(r,i){return c.type="throw",c.arg=t,e.next=r,i&&(e.method="next",e.arg=n),!!i}for(var o=this.tryEntries.length-1;o>=0;--o){var a=this.tryEntries[o],c=a.completion;if("root"===a.tryLoc)return r("end");if(a.tryLoc<=this.prev){var s=i.call(a,"catchLoc"),l=i.call(a,"finallyLoc");if(s&&l){if(this.prev<a.catchLoc)return r(a.catchLoc,!0);if(this.prev<a.finallyLoc)return r(a.finallyLoc)}else if(s){if(this.prev<a.catchLoc)return r(a.catchLoc,!0)}else{if(!l)throw new Error("try statement without catch or finally");if(this.prev<a.finallyLoc)return r(a.finallyLoc)}}}},abrupt:function(t,e){for(var n=this.tryEntries.length-1;n>=0;--n){var r=this.tryEntries[n];if(r.tryLoc<=this.prev&&i.call(r,"finallyLoc")&&this.prev<r.finallyLoc){var o=r;break}}o&&("break"===t||"continue"===t)&&o.tryLoc<=e&&e<=o.finallyLoc&&(o=null);var a=o?o.completion:{};return a.type=t,a.arg=e,o?(this.method="next",this.next=o.finallyLoc,v):this.complete(a)},complete:function(t,e){if("throw"===t.type)throw t.arg;return"break"===t.type||"continue"===t.type?this.next=t.arg:"return"===t.type?(this.rval=this.arg=t.arg,this.method="return",this.next="end"):"normal"===t.type&&e&&(this.next=e),v},finish:function(t){for(var e=this.tryEntries.length-1;e>=0;--e){var n=this.tryEntries[e];if(n.finallyLoc===t)return this.complete(n.completion,n.afterLoc),G(n),v}},catch:function(t){for(var e=this.tryEntries.length-1;e>=0;--e){var n=this.tryEntries[e];if(n.tryLoc===t){var r=n.completion;if("throw"===r.type){var i=r.arg;G(n)}return i}}throw new Error("illegal catch attempt")},delegateYield:function(t,e,r){return this.delegate={iterator:S(t),resultName:e,nextLoc:r},"next"===this.method&&(this.arg=n),v}}}function A(t,e,n,r){var i=e&&e.prototype instanceof b?e:b,o=Object.create(i.prototype),a=new M(r||[]);return o._invoke=L(t,n,a),o}function E(t,e,n){try{return{type:"normal",arg:t.call(e,n)}}catch(r){return{type:"throw",arg:r}}}function b(){}function x(){}function I(){}function V(t){["next","throw","return"].forEach((function(e){t[e]=function(t){return this._invoke(e,t)}}))}function j(t){function e(n,r,o,a){var c=E(t[n],t,r);if("throw"!==c.type){var s=c.arg,l=s.value;return l&&"object"===typeof l&&i.call(l,"__await")?Promise.resolve(l.__await).then((function(t){e("next",t,o,a)}),(function(t){e("throw",t,o,a)})):Promise.resolve(l).then((function(t){s.value=t,o(s)}),a)}a(c.arg)}var n;function r(t,r){function i(){return new Promise((function(n,i){e(t,r,n,i)}))}return n=n?n.then(i,i):i()}this._invoke=r}function L(t,e,n){var r=d;return function(i,o){if(r===h)throw new Error("Generator is already running");if(r===f){if("throw"===i)throw o;return C()}n.method=i,n.arg=o;while(1){var a=n.delegate;if(a){var c=k(a,n);if(c){if(c===v)continue;return c}}if("next"===n.method)n.sent=n._sent=n.arg;else if("throw"===n.method){if(r===d)throw r=f,n.arg;n.dispatchException(n.arg)}else"return"===n.method&&n.abrupt("return",n.arg);r=h;var s=E(t,e,n);if("normal"===s.type){if(r=n.done?f:p,s.arg===v)continue;return{value:s.arg,done:n.done}}"throw"===s.type&&(r=f,n.method="throw",n.arg=s.arg)}}}function k(t,e){var r=t.iterator[e.method];if(r===n){if(e.delegate=null,"throw"===e.method){if(t.iterator.return&&(e.method="return",e.arg=n,k(t,e),"throw"===e.method))return v;e.method="throw",e.arg=new TypeError("The iterator does not provide a 'throw' method")}return v}var i=E(r,t.iterator,e.arg);if("throw"===i.type)return e.method="throw",e.arg=i.arg,e.delegate=null,v;var o=i.arg;return o?o.done?(e[t.resultName]=o.value,e.next=t.nextLoc,"return"!==e.method&&(e.method="next",e.arg=n),e.delegate=null,v):o:(e.method="throw",e.arg=new TypeError("iterator result is not an object"),e.delegate=null,v)}function N(t){var e={tryLoc:t[0]};1 in t&&(e.catchLoc=t[1]),2 in t&&(e.finallyLoc=t[2],e.afterLoc=t[3]),this.tryEntries.push(e)}function G(t){var e=t.completion||{};e.type="normal",delete e.arg,t.completion=e}function M(t){this.tryEntries=[{tryLoc:"root"}],t.forEach(N,this),this.reset(!0)}function S(t){if(t){var e=t[a];if(e)return e.call(t);if("function"===typeof t.next)return t;if(!isNaN(t.length)){var r=-1,o=function e(){while(++r<t.length)if(i.call(t,r))return e.value=t[r],e.done=!1,e;return e.value=n,e.done=!0,e};return o.next=o}}return{next:C}}function C(){return{value:n,done:!0}}}(function(){return this}()||Function("return this")())},aaa9:function(t,e){t.exports="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABcAAAAXCAYAAADgKtSgAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDE0IDc5LjE1MTQ4MSwgMjAxMy8wMy8xMy0xMjowOToxNSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozQkFBNDEyNjk4NDkxMUVBOENEMEUyMDYxMEQxNjJGMiIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDozQkFBNDEyNzk4NDkxMUVBOENEMEUyMDYxMEQxNjJGMiI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjNCQUE0MTI0OTg0OTExRUE4Q0QwRTIwNjEwRDE2MkYyIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjNCQUE0MTI1OTg0OTExRUE4Q0QwRTIwNjEwRDE2MkYyIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+3N93FgAAAapJREFUeNqslU8oBFEYwGcnWw6UbMlSuGyUixwchBxc5rKUctKmdSA3F38PDko5c3FBbSkOuwepJTfJQW1ywYGUYv3JloPYjfxevam1zZvZndmvfu3rzZvf93r7zfd8/kSNpogKGAEDOqAB/PAKV3AMe9mhzKNK4FPI52ECmjX7+IJtWCBJxkkegAT0aqXFMwyT4FQlr4MUNGruwyBB0kp+Da2a92giwYMY6HJivUxiEYf5O6/n90mx8Bc25FGFS0gQZvf7YufTNosOYAoGZUleFilfMncu6jSoWLQJ4wVzszADtQ4J+nQbsYhKi7lVCMGWg7xHd/mnvUMUuuXXahUB3WNlnMGi4lm1V3kbzCme5dzKfbAij6RLseZNyNM2kqzF3BjcyOZmF+dCvmuzoCpv3AlJWSUhB/EdHIk6F231XrHoE5Zl650s4dgifKExs3HFYLRMvSWNOJjfuETNvpRJbpgDU56DfnmzeIkou74olGuyrMRdeetC+iNvon8tobDORYm1wxp8FymOi3cQx4u9oDXZwyMwAC2yC4rNfIDopCewgzSlEvwJMAAgzWhpmfvT5wAAAABJRU5ErkJggg=="}}]);