;(function(root, factory) {

  if (typeof define === 'function' && define.amd) {
    define(factory);
  } else if (typeof exports === 'object') {
    module.exports = factory();
  } else {
    root.Bulma = factory();
  }

})(this, function() {
  var Bulma = {};

  Bulma.init = function() {
    Bulma.setToggle();
    Bulma.setDropdown();
    Bulma.setMessage();
  }


  // Toggles
  Bulma.setToggle = function() {
    var $burgers = getAll('.burger');

    if ($burgers.length > 0) {
      $burgers.forEach(function ($el) {
        $el.addEventListener('click', function () {
          var target = $el.dataset.target;
          var $target = document.getElementById(target);
          $el.classList.toggle('is-active');
          $target.classList.toggle('is-active');
        });
      });
    }
  }


  // Dropdowns
  Bulma.setDropdown = function() {
    var $dropdowns = getAll('.dropdown:not(.is-hoverable)');

    if ($dropdowns.length > 0) {
      $dropdowns.forEach(function ($el) {
        $el.addEventListener('click', function (event) {
          closeDropdowns($dropdowns); // 表示中のドロップダウンは閉じる
          
          target = event.target;

          // button/aタグ配下のiタグがクリックされた場合を考慮
          if (target.tagName === 'I') {
            target = target.parentNode;
          }

          if (target.tagName !== 'A') {
            event.stopPropagation();
            $el.classList.toggle('is-active');
          }
        });
      });

      document.addEventListener('click', function (event) {
        closeDropdowns($dropdowns);
      });
    }
  }

  function closeDropdowns($dropdowns) {
    $dropdowns.forEach(function ($el) {
      $el.classList.remove('is-active');
    });
  }


  // Message
  Bulma.setMessage = function() {
    var $messages = getAll('.message');

    if ($messages.length > 0) {
      $messages.forEach(function ($message) {
        var $messageClose = getAll('.message *[data-dismiss="message"]', $message);
        if ($messageClose.length > 0) {
          $messageClose.forEach(function ($messageClose) {
            $messageClose.addEventListener('click', function () {
              $message.parentNode.removeChild($message);
            });
          });
        };
      });
    };
  }


  // Modals
  Bulma.showModal = function() {
    var $html = document.documentElement;
    var $modal = document.querySelector(".modal");
    var $modalCloses = getAll('.modal-background, .modal-close, .modal-card-head .delete, .modal-card-foot .button, *[data-dismiss="modal"]');

    $modal.classList.add('is-active');
    $html.classList.add('is-clipped');

    if ($modalCloses.length > 0) {
      $modalCloses.forEach(function ($el) {
        $el.addEventListener('click', function () {
          closeModal($html, $modal);
        });
      });
    }

    document.addEventListener('keydown', function (event) {
      var e = event || window.event;
      if (e.keyCode === 27) {
        closeModal($html, $modal);
      }
    });
  }

  function closeModal($html, $modal) {
    $html.classList.remove('is-clipped');
    $modal.classList.remove('is-active');
  }
  

  // Functions
  function getAll(selector, root=document) {
    return Array.prototype.slice.call(document.querySelectorAll(selector), 0);
  }


  return Bulma;
});
