document.addEventListener("turbolinks:load", function () {
  console.log("test");

  $('#user-edit-modal').click(function () {
    $('#user-input-modal').fadeIn();
    $('#user-edit-modal').hide();
  });

  $('#user-modal-cancel').click(function () {
    $('#user-input-modal').fadeOut();
    $('#user-edit-modal').show();
  });

  $('#owner-edit-modal').click(function () {
    $('#owner-input-modal').fadeIn();
    $('#owner-edit-modal').hide();
  });

  $('#owner-modal-cancel').click(function () {
    $('#owner-input-modal').fadeOut();
    $('#owner-edit-modal').show();
  });

  $('#preview-edit-modal').click(function () {
    $('#preview-input-modal').fadeIn();
    $('#preview-edit-modal').hide();
  });

  $('#preview-modal-cancel').click(function () {
    $('#preview-input-modal').fadeOut();
    $('#preview-edit-modal').show();
  });

  $('#preview2-edit-modal').click(function () {
    $('#preview2-input-modal').fadeIn();
    $('#preview2-edit-modal').hide();
  });

  $('#preview2-modal-cancel').click(function () {
    $('#preview2-input-modal').fadeOut();
    $('#preview2-edit-modal').show();
  });

  $('#preview3-edit-modal').click(function () {
    $('#preview3-input-modal').fadeIn();
    $('#preview3-edit-modal').hide();
  });

  $('#preview3-modal-cancel').click(function () {
    $('#preview3-input-modal').fadeOut();
    $('#preview3-edit-modal').show();
  });

  $('#preview4-edit-modal').click(function () {
    $('#preview4-input-modal').fadeIn();
    $('#preview4-edit-modal').hide();
  });

  $('#preview4-modal-cancel').click(function () {
    $('#preview4-input-modal').fadeOut();
    $('#preview4-edit-modal').show();
  });

  $('#preview5-edit-modal').click(function () {
    $('#preview5-input-modal').fadeIn();
    $('#preview5-edit-modal').hide();
  });

  $('#preview5-modal-cancel').click(function () {
    $('#preview5-input-modal').fadeOut();
    $('#preview5-edit-modal').show();
  });

  $(document).ready(function () {
    $('.slick-index').slick({
      centerMode: true,
      focusOnSelect: true,
      slidesToShow: 1,
      slidesToScroll: 1,
      centerPadding: '25%',
      dots: true,
      dotsClass: 'slide-dots',
      pauseOnHover: true,
      autoplay: true,
      autoplaySpeed: 5000,
      speed: 800,
      responsive: [
        {
          breakpoint: 768,
          settings: {
            arrows: false,
            centerMode: true,
            slidesToShow: 1,
            slidesToScroll: 1,
            centerPadding: '60px',
          }
        },
        {
          breakpoint: 480,
          settings: {
            arrows: false,
            centerMode: true,
            centerPadding: '40px',
            slidesToShow: 1
          }
        }
      ]
    });
  });
  $(document).ready(function () {
    $('.slick-current').addClass('is--active');
  });
  $('.slick-index').on('beforeChange', function () {
    $('.slick-current').removeClass('is--active');
  });
  $('.slick-index').on('afterChange', function () {
    $('.slick-current').addClass('is--active');
  });

  // $(function () {
  //   var slider = ".project-image"; // スライダー
  //   var thumbnailItem = ".project-image-list .thumbnail-item"; // サムネイル画像アイテム

  //   // サムネイル画像アイテムに data-index でindex番号を付与
  //   $(thumbnailItem).each(function () {
  //     var index = $(thumbnailItem).index(this);
  //     $(this).attr("data-index", index);
  //   });

  //   // スライダー初期化後、カレントのサムネイル画像にクラス「thumbnail-current」を付ける
  //   // 「slickスライダー作成」の前にこの記述は書いてください。
  //   $(slider).on('init', function (slick) {
  //     var index = $(".slide-item.slick-slide.slick-current").attr("data-slick-index");
  //     $(thumbnailItem + '[data-index="' + index + '"]').addClass("thumbnail-current");
  //   });

  //   //slickスライダー初期化  
  //   $(slider).slick({
  //     arrows: false,
  //     fade: true,
  //     infinite: false //これはつけましょう。
  //   });
  //   //サムネイル画像アイテムをクリックしたときにスライダー切り替え
  //   $(thumbnailItem).on('click', function () {
  //     var index = $(this).attr("data-index");
  //     $(slider).slick("slickGoTo", index, false);
  //   });

  //   //サムネイル画像のカレントを切り替え
  //   $(slider).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
  //     $(thumbnailItem).each(function () {
  //       $(this).removeClass("thumbnail-current");
  //     });
  //     $(thumbnailItem + '[data-index="' + nextSlide + '"]').addClass("thumbnail-current");
  //   });
  // });

  $(function () {
    $(window).scroll(function () {
      var scroll = $(window).scrollTop();
      if (scroll > 500) {
        $('.footer-btn').addClass('fixed');
      }
      var doch = $(document).innerHeight(); //ページ全体の高さ
      var winh = $(window).innerHeight(); //ウィンドウの高さ
      var bottom = doch - winh; //ページ全体の高さ - ウィンドウの高さ = ページの最下部位置
      if (bottom - 500 <= $(window).scrollTop()) {
        $('.footer-btn').removeClass('fixed');
      }
    });

  });
  $(function () {
    $(window).scroll(function () {
      var scroll = $(window).scrollTop();
      $('.footer-btn-ad').addClass('fixed-ad');
      var doch = $(document).innerHeight(); //ページ全体の高さ
      var winh = $(window).innerHeight(); //ウィンドウの高さ
      var bottom = doch - winh; //ページ全体の高さ - ウィンドウの高さ = ページの最下部位置
      if (bottom - 503 <= $(window).scrollTop()) {
        $('.footer-btn-ad').removeClass('fixed-ad');
      }
    });
  });

  function countdown(due) {
    const now = new Date();
    const rest = due.getTime() - now.getTime();
    const sec = Math.floor(rest / 1000) % 60;
    const min = Math.floor(rest / 1000 / 60) % 60;
    const hours = Math.floor(rest / 1000 / 60 / 60) % 24;
    const count = [hours, min, sec];

    return count;
  }

  let goal = new Date();
  goal.setHours(23);
  goal.setMinutes(59);
  goal.setSeconds(59);

  function recalc() {
    const counter = countdown(goal);
    const time = `${counter[0]}時間${counter[1]}分${counter[2]}秒`;
    document.getElementById('timer').textContent = time;
    refresh();
  }

  function refresh() {
    setTimeout(recalc, 1000);
  }

  recalc();
});