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
