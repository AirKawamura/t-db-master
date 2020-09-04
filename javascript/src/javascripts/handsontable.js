import Handsontable from 'handsontable';
import 'handsontable/languages/ja-JP';

function handsontable(container) {
  if (container == null) { return; };
  const doneButton = document.getElementById('done');
  const headerKeys = Object.keys(gon.grid_header);

  let hot = new Handsontable(container, {
    licenseKey: 'de3c7-62f69-d3ce2-74940-af62a',
    language: 'ja-JP',
    data: gon.grid_data,
    colHeaders: Object.values(gon.grid_header),
    rowHeaders: false,
    colWidths: 130,
    width: '100%',
    height: 630,
    rowHeights: 23,
    filters: true,
    dropdownMenu: ['filter_by_condition', 'filter_by_value', 'filter_action_bar'],
    fillHandle: false,
    hiddenColumns: {
      columns: [0],
      indicators: false
    },
    columns: function(index) {
      let props = {className: 'cell'};
      switch (index) {
        case 0:  // エンジニアID
          props.readOnly = true;  
          break;
        case 1:  // 公開設定
          props.type = 'dropdown';
          props.source = gon.privacies;  
          break;
        case 6:  // 性別
          props.type = 'dropdown';
          props.source = gon.genders;  
          break;
        case 7:  // 国籍
          props.type = 'dropdown';
          props.source = gon.countries;  
          break;
        case 8:  // 雇用形態
          props.type = 'dropdown';
          props.source = gon.employment_types;  
          break;
        case 10:  // 商流
          props.type = 'dropdown';
          props.source = gon.commercial_distributions;
          break;
        case 11:  // 希望単価
          props.type = 'numeric';
          break;
      }
      return props;
    },
    afterChange: (changes) => {
      if (changes == null) { return; };
      const changedData = changes.map(function([row, prop, oldValue, newValue]) {
        return [hot.getDataAtCell(row, 0), headerKeys[parseInt(prop)], newValue];
      });

      doneButton.classList.add('is-loading');

      $.ajax({
        url: 'bulk_update',
        type: 'PATCH',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        dataType: 'json',
        data: {
          data: changedData
        },
        timeout: 5000,
      })
      .done(function(data) {
        // console.log("done");
      })
      .fail(function() {
        console.log("fail");
      })
      .always(function() {
        doneButton.classList.remove('is-loading');
      });
    }
  });
};

export default handsontable;
