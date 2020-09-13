

import fileUpload from './fileUpload';
import handsontable from './handsontable';
import Bulma from './bulma';
import tippy from 'tippy.js';
import NProgress from 'nprogress';
import Tagify from '@yaireo/tagify';
import { Notyf } from 'notyf';
import { Grid } from "gridjs";

global.Bulma = Bulma;
global.Tagify = Tagify;
global.Notyf = Notyf;
global.tippy = tippy;

global.TagifySetup = function(elm, options = {}) {
  let dropdown_enabled = 1;
  if (elm.getAttribute('data-tagify-dropdown-enabled')) {
    dropdown_enabled = parseInt(elm.getAttribute('data-tagify-dropdown-enabled'));
  }

  let whitelist = [];
  if (elm.getAttribute('data-tagify-whitelist')) {
    whitelist = elm.getAttribute('data-tagify-whitelist').split(/\s*,\s*/);
  }

  let enforceWhitelist = false;
  if (elm.getAttribute('data-tagify-enforce-whitelist')) {
    enforceWhitelist = (elm.getAttribute('data-tagify-enforce-whitelist') === 'true');
  }

  let maxTags = Infinity;
  if (elm.getAttribute('data-tagify-max-tags')) {
    maxTags = parseInt(elm.getAttribute('data-tagify-max-tags'));
  }

  let defaults = {
    backspace: false,
    editTags: 1,
    enforceWhitelist: enforceWhitelist,
    whitelist: whitelist,
    maxTags: maxTags,
    dropdown: {
      enabled: dropdown_enabled,
      maxItems: 1000,
      highlightFirst: true
    },
    autoComplete: {
      rightKey: true
    },
    originalInputValueFormat: valuesArr => valuesArr.map(item => item.value).join(','),
  };
  options = Object.assign(defaults, options);

  let tagify = new Tagify(elm, options);

  // HACK: 日本語入力時に入力値がクリアされない問題に暫定対応
  tagify.on('add', e => {
    let input = e.detail.tagify.DOM.input;
    input.contentEditable = 'false';
    setTimeout(() => {
      input.contentEditable = 'true';
      input.focus();
    }, 500);
  });
};

document.addEventListener('turbolinks:load', () => {
  console.log('turbolinks:load');
  
  document.querySelectorAll('.upload-file').forEach(fileInput => {
    fileUpload(fileInput);
  });

  handsontable(document.getElementById('handsontable'));

  tippy('[data-tippy-content]');

  Bulma.init();

  document.querySelectorAll('.tagify').forEach(elm => {
    TagifySetup(elm);
  });

  document.querySelectorAll('.gridjs').forEach(table => {
    let oldWrapper = table.nextElementSibling;
    if (oldWrapper && oldWrapper.classList.contains('gridjs-container-wrapper')) {
      oldWrapper.remove();
    }

    const wrapper = document.createElement('div');
    wrapper.classList.add('gridjs-container-wrapper');
    let grid = new Grid({ 
      from: table,
      sort: true,
    }).render(wrapper);
    wrapper.querySelector('.gridjs-table').classList.add('table');
    table.parentNode.appendChild(wrapper);
  });
});


//script.src="https://shifttoiroeng-test.rec.edirium.co.jp/scripts/recommender.js"

// SCRIPTタグの生成




//window.onload = script()
document.addEventListener("DOMContentLoaded", function () {
  //もし既に読み込まれてるなら実行しない処理追加
  var el = document.createElement("script");
 
// SCRIPTタグのSRC属性に読み込みたいファイルを指定
el.src = "https://shifttoiroeng-test.rec.edirium.co.jp/scripts/recommender.js";
 
// BODY要素の最後に追加
//document.body.appendChild(el);
document.body.appendChild(el);
console.log("実行")
edi_load()

  })


  var params = {
    serv: 'shifttoiroeng',
    env: 'test',
    n: '5',
    item: "",
    user:"",
    filt:[],
    cat: [],
    kw:[],
    };
  var keywordArray = [];

  //URLから検索キーワード取得
  function get_keyword(){
    var keyword = location.search; 
    keyword = decodeURI(keyword);
    keyword = keyword.split("=");
    for (var c of keyword) {
    //一つ一つ取り出して
    var cArray = c.split("&"); 
    //さらに分割
    if(cArray[0] != ""){
    //数値なら検索キーワードから除外
    if(isNaN(cArray[0])){
    keywordArray.push(cArray[0]);
    }
    }
    }
    //先頭と末尾は必要ないので削除
    keywordArray.shift();
    keywordArray.pop();
    params.kw = keywordArray;
    console.log(keywordArray)
    }
  
    //セッションからID取得
    function get_user() {
    console.log(location.search.split('&'));
    var cookies = document.cookie; //全てのcookieを取り出して
    var cookiesArray = cookies.split(";"); // ;で分割し配列に
    for (var c of cookiesArray) {
    //一つ一つ取り出して
    var cArray = c.split("="); //さらに=で分割して配列に
    if (cArray[0] == "edrvid") {
    // 取り出したいkeyと合致したら
    //console.log(cArray[1]);  // [key,value]
    var user_id = cArray[1];
    console.log(user_id)
    params.user=user_id
  
    //console.log(this.user_id);
  
    }
    }
    }
  
    //おすすめ表示
    //これはエンジニア詳細ではなく、エンジニアホーム画面に置く。
    function edi_rec(){
      
    params.area = 'englist',
    params.item = "";
    edirium_rec.retrieve_recs(params, edirium_rec.write_recs, 'rec_area');
    }
  
    function edi_rec_search(){
    params.area = 'search'
    edirium_rec.retrieve_recs(params, edirium_rec.write_recs, 'rec_area_search');
    }
  
    function convert(){
  
    edirium_rec.notify_convert(params);
    }
  
    function rec_all(){
    get_user()
    //get_id()
    //edi_rec_skill()
    //edi_rec_price()
    edi_rec()
    get_keyword()
    edi_rec_search()
  
    //get_search()
    //edi_rec_search()
    }
  
    //htmlのhiddenからid取得
    function get_id(){
    id = document.getElementById("engineer_id").value;
    params.item = id;
    console.log(id);
    }
  
    //おすすめの中からスキルで絞り込む
    var cat =[]
    function edi_rec_skill() {
    skill = document.getElementsByClassName("tag is-success is-light is-medium");
    for (var i = 0;i < skill.length; i++) {
    //console.log(skill[i].textContent);
    cat.push(skill[i].textContent)
    }
    params.area = "englist";
    params.cat = cat;
    //params.kw = 
    //abc = "language.eq." + this.job.dev_lang;
    //params.filt = this.abc
    //this.params.filt.push(this.abc )
  
    edirium_rec.retrieve_recs(params, edirium_rec.write_recs,
    "rec_area_skill"
    );
    console.log(params.cat)
    params.cat = "";
    }
  
  
    //おすすめの中から単価で絞り込む
    function edi_rec_price(){
    params.area = 	"englist";
    price = document.getElementById("price");
    console.log(price.value)
    price_low ="price.le." + parseInt(price.value) * 1.1 
    price_high = "price.ge." + parseInt(price.value) * 0.9
    params.filt = [price_low,price_high]//価格の＋－10％の範囲
  
  
  
    edirium_rec.retrieve_recs(params, edirium_rec.write_recs,
    "rec_area_price"
    );
  
    params.filt = [];
    } 
    
    var flg = true;
    var href = "http://localhost:3000/";
    var observer = new MutationObserver(function(mutations) {
  
    get_user()
    
    if(href != location.href) {
    href = "http://localhost:3000/engineers";
    if(href != location.href){
  
    console.log("After:", location.href); 
    get_id()
    params.n = 2;
    edi_rec()
    edi_rec_skill()
    edi_rec_price()
    href = location.href;
    }else if(flg = true){
    console.log("bbb")
    edi_rec()
    get_keyword()
    edi_rec_search()
    }
    }
    //console.log(href)
  
    });
  
    observer.observe(document, { childList: true, subtree: true });
  
    //レコメンドに必要なメソッドを実行するか判定する
    function edi_load(){
    if(flg = true){
    //alert(flg);
    get_user()
    edi_rec()
    get_keyword()
    edi_rec_search()
    flg = false;
    }
    }
  
    //window.onload = edi_load()
