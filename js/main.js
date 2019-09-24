$(function () {
    $(document).ready(function () {
        setTimeout(function () {
            $(".loader-wrapper").addClass("pt-page-moveToTop");
        }, 1000);

        if (!/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {

            $(".slick-slide").overscroll({
                direction: 'auto',
                showThumbs: false
            });

        } else {
            $(".slick-slide").css("overflow", "scroll");
        }
        $('#zoom-out').addClass('d-none');
    });

    $('.images-container').slick({
        dots: false,
        infinite: true,
        speed: 500,
        fade: true,
        cssEase: 'linear',
        arrows: false,
        swipe: false
    });

    let cantidad = $('.images-container').find('img').length;
    let i = 1;
    let clicked = 1;

    $("#next-step").click(function () {
        if (i < cantidad) {
            $('.images-container').slick('slickNext');
            i++
            verifica();
        }
    });

    $("#prev-step").click(function () {
        if (i > 1) {
            $('.images-container').slick('slickPrev');
            i--
            verifica();
        }
    });

    $('.info-popup, .instrucciones').magnificPopup({
        type: 'inline',

        fixedContentPos: false,
        fixedBgPos: true,

        overflowY: 'auto',

        closeBtnInside: true,
        preloader: false,

        midClick: true,
        removalDelay: 300,
        mainClass: 'my-mfp-zoom-in'
    });

    $(".to_path").click(function () {
        $(".to_path").removeClass("active");
        $(this).addClass("active");
        var path = $(this).data("path");
        $(".images-container").addClass("hide");
        $("#" + path).removeClass("hide").addClass("active").fadeIn('slow');
        $('.images-container').slick('slickGoTo', 0);
    });


    // -----------------------------------------------Start ---------------------------------------------------

    $("#zoom-in").on("click", function (e) {
        //$(".inner-image-wrapper").css("height", "auto");

        var container = $(".slick-slide");
        var image = $(".inner-image-wrapper-1");

        var css = {};

        css.height = image.height() + image.height() * 0.2;
        css.width = image.width() + image.width() * 0.2;

        var ratio = css.width / image.width();

        var x = container.scrollLeft() + container.width() / 2;
        var y = container.scrollTop() + container.height() / 2;

        var newX = x * ratio;
        var newY = y * ratio;

        //if (css.width >= container.width() && css.height >= container.height()) {

        image.css(css);

        container.scrollTo({
            left: newX - container.width() / 2,
            top: newY - container.height() / 2
        });

        //}
        $(".inner-image-wrapper-1").css({
            transform: "translate(-25%, -25%)"
        });

        clicked++
        verifyzoom()
    });



    $("#zoom-out").on("click", function (e) {
        var container = $(".slick-slide");
        var image = $(".inner-image-wrapper-1");

        var css = {};

        css.height = image.height() - image.height() * 0.2;
        css.width = image.width() - image.width() * 0.2;

        var ratio = css.width / image.width();

        var x = container.scrollLeft() + container.width() / 2;

        var y = container.scrollTop() + container.height() / 2;

        var newX = x * ratio;
        var newY = y * ratio;

        if (css.width >= container.width() && css.height >= container.height()) {
            image.css(css);
            container.scrollTo({
                left: newX - container.width() / 2,
                top: newY - container.height() / 2
            });

        } else {
            if ($(".map-image").height() > $(".slick-slide").height()) {
                $(".inner-image-wrapper-1, .map-image").css({
                    width: "auto",
                    height: "100%",

                });
                $(".inner-image-wrapper-1").css({
                    transform: "translate(-50%, -50%)"
                });
            } else if ($(".map-image").height() != $(".slick-slide").height() || $(".map-image").width() > $(".slick-slide").width()) {
                $(".inner-image-wrapper-1, .map-image").css({
                    width: "100%",
                    height: "auto",

                });
                $(".inner-image-wrapper-1").css({
                    transform: "translate(-50%, -50%)"
                });
            }
            container.scrollTo({
                left: newX - container.width() / 2,
                top: newY - container.height() / 2
            });
        }

        clicked--
        verifyzoom()
    });



    //---instrucciones -------

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/CC_DECODER.pdf" target="_blank" class="instrucciones" data-id="Decoder_0"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/CC_DECODER.v" target="_blank" class="codigo" data-id="Decoder_0"></a >');

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/CC_DECODER.pdf" target="_blank" class="instrucciones" data-id="Decoder_u1"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/CC_DECODER.v" target="_blank" class="codigo" data-id="Decoder_u1"></a >');

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_0"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_0"></a >');

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_1"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_1"></a >');

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_2"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_2"></a >');

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_3"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_3"></a >');

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/SC_RegFIXED.pdf" target="_blank" class="instrucciones" data-id="RegFIXED_0"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/SC_RegFIXED.v" target="_blank" class="codigo" data-id="RegFIXED_0"></a >');

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/SC_RegFIXED.pdf" target="_blank" class="instrucciones" data-id="RegFIXED_1"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/SC_RegFIXED.v" target="_blank" class="codigo" data-id="RegFIXED_1"></a >');

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/CC_MUXX.pdf" target="_blank" class="instrucciones" data-id="MUXX_0"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/CC_MUXX.v" target="_blank" class="codigo" data-id="MUXX_0"></a >');

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/CC_MUXX.pdf" target="_blank" class="instrucciones" data-id="MUXX_1"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/CC_MUXX.v" target="_blank" class="codigo" data-id="MUXX_1"></a >');

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/CC_ALU.v" target="_blank" class="instrucciones" data-id="ALU_0"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/CC_ALU.v" target="_blank" class="codigo" data-id="ALU_0"></a >');

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/SC_RegSHIFTER.pdf" target="_blank" class="instrucciones" data-id="RegSHIFTER_0"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/SC_RegSHIFTER.v" target="_blank" class="codigo" data-id="RegSHIFTER_0"></a >');

    $(".inner-image-wrapper-1").append('<a href="codigos/start/help/SC_STATEMACHINE_START.pdf" target="_blank" class="instrucciones" data-id="Caja"></a >');
    $(".inner-image-wrapper-1").append('<a href="codigos/start/doc/SC_STATEMACHINE_START.v" target="_blank" class="codigo" data-id="Caja"></a >');



    if ($(".map-image").width() >= $(".slick-slide").width()) {
        $(".inner-image-wrapper-1, .map-image").css({
            width: "100%",
            height: "auto"
        });
    }

    $(window).resize(function () {
        if ($(".map-image").height() > $(".slick-slide").height()) {
            $(".inner-image-wrapper-1, .map-image").css({
                width: "auto",
                height: "100%"
            });
        } else {
            $(".inner-image-wrapper-1, .map-image").css({
                width: "100%",
                height: "auto"
            });
        }
    });


    // -----------------------------------------------Mov ---------------------------------------------------

    $("#zoom-in").on("click", function (e) {

        //$(".inner-image-wrapper").css("height", "auto");

        var container = $(".slick-slide");
        var image = $(".inner-image-wrapper-2");

        var css = {};

        css.height = image.height() + image.height() * 0.2;
        css.width = image.width() + image.width() * 0.2;

        var ratio = css.width / image.width();

        var x = container.scrollLeft() + container.width() / 2;
        var y = container.scrollTop() + container.height() / 2;

        var newX = x * ratio;
        var newY = y * ratio;

        //if (css.width >= container.width() && css.height >= container.height()) {

        image.css(css);

        container.scrollTo({
            left: newX - container.width() / 2,
            top: newY - container.height() / 2
        });

        //}
        $(".inner-image-wrapper-2").css({
            transform: "translate(-25%, -25%)"
        });

    });



    $("#zoom-out").on("click", function (e) {

        var container = $(".slick-slide");
        var image = $(".inner-image-wrapper-2");

        var css = {};

        css.height = image.height() - image.height() * 0.2;
        css.width = image.width() - image.width() * 0.2;

        var ratio = css.width / image.width();

        var x = container.scrollLeft() + container.width() / 2;

        var y = container.scrollTop() + container.height() / 2;

        var newX = x * ratio;
        var newY = y * ratio;

        if (css.width >= container.width() && css.height >= container.height()) {
            image.css(css);
            container.scrollTo({
                left: newX - container.width() / 2,
                top: newY - container.height() / 2
            });

        } else {
            if ($(".map-image").height() > $(".slick-slide").height()) {
                $(".inner-image-wrapper-2, .map-image").css({
                    width: "auto",
                    height: "100%",

                });
                $(".inner-image-wrapper-2").css({
                    transform: "translate(-50%, -50%)"
                });
            } else if ($(".map-image").height() != $(".slick-slide").height() || $(".map-image").width() > $(".slick-slide").width()) {
                $(".inner-image-wrapper-2, .map-image").css({
                    width: "100%",
                    height: "auto",

                });
                $(".inner-image-wrapper-2").css({
                    transform: "translate(-50%, -50%)"
                });
            }
            container.scrollTo({
                left: newX - container.width() / 2,
                top: newY - container.height() / 2
            });
        }

    });



    //---instrucciones -------

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/CC_DECODER.pdf" target="_blank" class="instrucciones" data-id="Decoder_0"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/CC_DECODER.v" target="_blank" class="codigo" data-id="Decoder_0"></a >');

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/CC_DECODER.pdf" target="_blank" class="instrucciones" data-id="Decoder_u1"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/CC_DECODER.v" target="_blank" class="codigo" data-id="Decoder_u1"></a >');

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_0"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_0"></a >');

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_1"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_1"></a >');

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_2"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_2"></a >');

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_3"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_3"></a >');

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/SC_RegFIXED.pdf" target="_blank" class="instrucciones" data-id="RegFIXED_0"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/SC_RegFIXED.v" target="_blank" class="codigo" data-id="RegFIXED_0"></a >');

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/SC_RegFIXED.pdf" target="_blank" class="instrucciones" data-id="RegFIXED_1"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/SC_RegFIXED.v" target="_blank" class="codigo" data-id="RegFIXED_1"></a >');

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/CC_MUXX.pdf" target="_blank" class="instrucciones" data-id="MUXX_0"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/CC_MUXX.v" target="_blank" class="codigo" data-id="MUXX_0"></a >');

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/CC_MUXX.pdf" target="_blank" class="instrucciones" data-id="MUXX_1"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/CC_MUXX.v" target="_blank" class="codigo" data-id="MUXX_1"></a >');

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/CC_ALU.pdf" target="_blank" class="instrucciones" data-id="ALU_0"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/CC_ALU.v" target="_blank" class="codigo" data-id="ALU_0"></a >');

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/SC_RegSHIFTER.pdf" target="_blank" class="instrucciones" data-id="RegSHIFTER_0"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/SC_RegSHIFTER.v" target="_blank" class="codigo" data-id="RegSHIFTER_0"></a >');

    $(".inner-image-wrapper-2").append('<a href="codigos/mov/help/SC_STATEMACHINE_MOV.pdf" target="_blank" class="instrucciones" data-id="Caja"></a >');
    $(".inner-image-wrapper-2").append('<a href="codigos/mov/doc/SC_STATEMACHINE_MOV.v" target="_blank" class="codigo" data-id="Caja"></a >');



    if ($(".map-image").width() >= $(".slick-slide").width()) {
        $(".inner-image-wrapper-2, .map-image").css({
            width: "100%",
            height: "auto"
        });
    }

    $(window).resize(function () {
        if ($(".map-image").height() > $(".slick-slide").height()) {
            $(".inner-image-wrapper-2, .map-image").css({
                width: "auto",
                height: "100%"
            });
        } else {
            $(".inner-image-wrapper-2, .map-image").css({
                width: "100%",
                height: "auto"
            });
        }
    });


    // -----------------------------------------------arith/log ---------------------------------------------------

    $("#zoom-in").on("click", function (e) {

        //$(".inner-image-wrapper").css("height", "auto");

        var container = $(".slick-slide");
        var image = $(".inner-image-wrapper-3");

        var css = {};

        css.height = image.height() + image.height() * 0.2;
        css.width = image.width() + image.width() * 0.2;

        var ratio = css.width / image.width();

        var x = container.scrollLeft() + container.width() / 2;
        var y = container.scrollTop() + container.height() / 2;

        var newX = x * ratio;
        var newY = y * ratio;

        //if (css.width >= container.width() && css.height >= container.height()) {

        image.css(css);

        container.scrollTo({
            left: newX - container.width() / 2,
            top: newY - container.height() / 2
        });

        //}
        $(".inner-image-wrapper-3").css({
            transform: "translate(-25%, -25%)"
        });

    });



    $("#zoom-out").on("click", function (e) {

        var container = $(".slick-slide");
        var image = $(".inner-image-wrapper-3");

        var css = {};

        css.height = image.height() - image.height() * 0.2;
        css.width = image.width() - image.width() * 0.2;

        var ratio = css.width / image.width();

        var x = container.scrollLeft() + container.width() / 2;

        var y = container.scrollTop() + container.height() / 2;

        var newX = x * ratio;
        var newY = y * ratio;

        if (css.width >= container.width() && css.height >= container.height()) {
            image.css(css);
            container.scrollTo({
                left: newX - container.width() / 2,
                top: newY - container.height() / 2
            });

        } else {
            if ($(".map-image").height() > $(".slick-slide").height()) {
                $(".inner-image-wrapper-3, .map-image").css({
                    width: "auto",
                    height: "100%",

                });
                $(".inner-image-wrapper-3").css({
                    transform: "translate(-50%, -50%)"
                });
            } else if ($(".map-image").height() != $(".slick-slide").height() || $(".map-image").width() > $(".slick-slide").width()) {
                $(".inner-image-wrapper-3, .map-image").css({
                    width: "100%",
                    height: "auto",

                });
                $(".inner-image-wrapper-3").css({
                    transform: "translate(-50%, -50%)"
                });
            }
            container.scrollTo({
                left: newX - container.width() / 2,
                top: newY - container.height() / 2
            });
        }

    });



    //---instrucciones -------

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/CC_DECODER.pdf" target="_blank" class="instrucciones" data-id="Decoder_0"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/CC_DECODER.v" target="_blank" class="codigo" data-id="Decoder_0"></a >');

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/CC_DECODER.pdf" target="_blank" class="instrucciones" data-id="Decoder_u1"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/CC_DECODER.v" target="_blank" class="codigo" data-id="Decoder_u1"></a >');

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_0"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_0"></a >');

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_1"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_1"></a >');

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_2"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_2"></a >');

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_3"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_3"></a >');

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/SC_RegFIXED.pdf" target="_blank" class="instrucciones" data-id="RegFIXED_0"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/SC_RegFIXED.v" target="_blank" class="codigo" data-id="RegFIXED_0"></a >');

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/SC_RegFIXED.pdf" target="_blank" class="instrucciones" data-id="RegFIXED_1"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/SC_RegFIXED.v" target="_blank" class="codigo" data-id="RegFIXED_1"></a >');

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/CC_MUXX.pdf" target="_blank" class="instrucciones" data-id="MUXX_0"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/CC_MUXX.v" target="_blank" class="codigo" data-id="MUXX_0"></a >');

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/CC_MUXX.pdf" target="_blank" class="instrucciones" data-id="MUXX_1"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/CC_MUXX.v" target="_blank" class="codigo" data-id="MUXX_1"></a >');

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/CC_ALU.pdf" target="_blank" class="instrucciones" data-id="ALU_0"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/CC_ALU.v" target="_blank" class="codigo" data-id="ALU_0"></a >');

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/SC_RegSHIFTER.pdf" target="_blank" class="instrucciones" data-id="RegSHIFTER_0"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/SC_RegSHIFTER.v" target="_blank" class="codigo" data-id="RegSHIFTER_0"></a >');

    $(".inner-image-wrapper-3").append('<a href="codigos/arith/help/SC_STATEMACHINE_ADD.pdf" target="_blank" class="instrucciones" data-id="Caja"></a >');
    $(".inner-image-wrapper-3").append('<a href="codigos/arith/doc/SC_STATEMACHINE_ADD.v" target="_blank" class="codigo" data-id="Caja"></a >');


    if ($(".map-image").width() >= $(".slick-slide").width()) {
        $(".inner-image-wrapper-3, .map-image").css({
            width: "100%",
            height: "auto"
        });
    }

    $(window).resize(function () {
        if ($(".map-image").height() > $(".slick-slide").height()) {
            $(".inner-image-wrapper-3, .map-image").css({
                width: "auto",
                height: "100%"
            });
        } else {
            $(".inner-image-wrapper-3, .map-image").css({
                width: "100%",
                height: "auto"
            });
        }
    });

    // -----------------------------------------------shift register ---------------------------------------------------

    $("#zoom-in").on("click", function (e) {

        //$(".inner-image-wrapper").css("height", "auto");

        var container = $(".slick-slide");
        var image = $(".inner-image-wrapper-4");

        var css = {};

        css.height = image.height() + image.height() * 0.2;
        css.width = image.width() + image.width() * 0.2;

        var ratio = css.width / image.width();

        var x = container.scrollLeft() + container.width() / 2;
        var y = container.scrollTop() + container.height() / 2;

        var newX = x * ratio;
        var newY = y * ratio;

        //if (css.width >= container.width() && css.height >= container.height()) {

        image.css(css);

        container.scrollTo({
            left: newX - container.width() / 2,
            top: newY - container.height() / 2
        });
        //}
        $(".inner-image-wrapper-4").css({
            transform: "translate(-25%, -25%)"
        });

    });



    $("#zoom-out").on("click", function (e) {

        var container = $(".slick-slide");
        var image = $(".inner-image-wrapper-4");

        var css = {};

        css.height = image.height() - image.height() * 0.2;
        css.width = image.width() - image.width() * 0.2;

        var ratio = css.width / image.width();

        var x = container.scrollLeft() + container.width() / 2;

        var y = container.scrollTop() + container.height() / 2;

        var newX = x * ratio;
        var newY = y * ratio;

        if (css.width >= container.width() && css.height >= container.height()) {
            image.css(css);
            container.scrollTo({
                left: newX - container.width() / 2,
                top: newY - container.height() / 2
            });
        } else {
            if ($(".map-image").height() > $(".slick-slide").height()) {
                $(".inner-image-wrapper-4, .map-image").css({
                    height: "100%",
                    width: "auto",

                });
                $(".inner-image-wrapper-4").css({
                    transform: "translate(-50%, -50%)"
                });
            } else if ($(".map-image").height() === $(".slick-slide").height()) {
                $(".inner-image-wrapper-4, .map-image").css({
                    height: "100%",
                    width: "auto",
                    
                });
                $(".inner-image-wrapper-4").css({
                    transform: "translate(-50%, -50%)"
                });
                clicked = 1;
                verifyzoom()
            } else if (($(".map-image").height() != $(".slick-slide").height()) || ($(".map-image").width() > $(".slick-slide").width())) {
                $(".inner-image-wrapper-4, .map-image").css({
                    width: "100%",
                    height: "auto",
                });
                $(".inner-image-wrapper-4").css({
                    transform: "translate(-50%, -50%)"
                });
            }
            container.scrollTo({
                left: newX - container.width() / 2,
                top: newY - container.height() / 2
            });
        }

    });


    //---instrucciones -------

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/CC_DECODER.pdf" target="_blank" class="instrucciones" data-id="Decoder_0"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/CC_DECODER.v" target="_blank" class="codigo" data-id="Decoder_0"></a >');

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/CC_DECODER.pdf" target="_blank" class="instrucciones" data-id="Decoder_u1"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/CC_DECODER.v" target="_blank" class="codigo" data-id="Decoder_u1"></a >');

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_0"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_0"></a >');

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_1"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_1"></a >');

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_2"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_2"></a >');

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_3"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_3"></a >');

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/SC_RegFIXED.pdf" target="_blank" class="instrucciones" data-id="RegFIXED_0"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/SC_RegFIXED.v" target="_blank" class="codigo" data-id="RegFIXED_0"></a >');

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/SC_RegFIXED.pdf" target="_blank" class="instrucciones" data-id="RegFIXED_1"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/SC_RegFIXED.v" target="_blank" class="codigo" data-id="RegFIXED_1"></a >');

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/CC_MUXX.pdf" target="_blank" class="instrucciones" data-id="MUXX_0"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/CC_MUXX.v" target="_blank" class="codigo" data-id="MUXX_0"></a >');

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/CC_MUXX.pdf" target="_blank" class="instrucciones" data-id="MUXX_1"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/CC_MUXX.v" target="_blank" class="codigo" data-id="MUXX_1"></a >');

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/CC_ALU.pdf" target="_blank" class="instrucciones" data-id="ALU_0"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/CC_ALU.v" target="_blank" class="codigo" data-id="ALU_0"></a >');

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/SC_RegSHIFTER.pdf" target="_blank" class="instrucciones" data-id="RegSHIFTER_0"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/SC_RegSHIFTER.v" target="_blank" class="codigo" data-id="RegSHIFTER_0"></a >');

    $(".inner-image-wrapper-4").append('<a href="codigos/shift/help/SC_STATEMACHINE_SHIFT.pdf" target="_blank" class="instrucciones" data-id="Caja"></a >');
    $(".inner-image-wrapper-4").append('<a href="codigos/shift/doc/SC_STATEMACHINE_SHIFT.v" target="_blank" class="codigo" data-id="Caja"></a >');


    if ($(".map-image").width() >= $(".slick-slide").width()) {
        $(".inner-image-wrapper-4, .map-image").css({
            width: "100%",
            height: "auto"
        });
    }

    $(window).resize(function () {
        if ($(".map-image").height() > $(".slick-slide").height()) {
            $(".inner-image-wrapper-4, .map-image").css({
                width: "auto",
                height: "100%"
            });
        } else {
            $(".inner-image-wrapper-4, .map-image").css({
                width: "100%",
                height: "auto"
            });
        }
    });


    // ----------------------------------------------- flag ---------------------------------------------------

    $("#zoom-in").on("click", function (e) {

        //$(".inner-image-wrapper").css("height", "auto");

        var container = $(".slick-slide");
        var image = $(".inner-image-wrapper-5");

        var css = {};

        css.height = image.height() + image.height() * 0.2;
        css.width = image.width() + image.width() * 0.2;

        var ratio = css.width / image.width();

        var x = container.scrollLeft() + container.width() / 2;
        var y = container.scrollTop() + container.height() / 2;

        var newX = x * ratio;
        var newY = y * ratio;

        //if (css.width >= container.width() && css.height >= container.height()) {

        image.css(css);

        container.scrollTo({
            left: newX - container.width() / 2,
            top: newY - container.height() / 2
        });

        //}
        $(".inner-image-wrapper-5").css({
            transform: "translate(-25%, -25%)"
        });

    });



    $("#zoom-out").on("click", function (e) {

        var container = $(".slick-slide");
        var image = $(".inner-image-wrapper-5");

        var css = {};

        css.height = image.height() - image.height() * 0.2;
        css.width = image.width() - image.width() * 0.2;

        var ratio = css.width / image.width();

        var x = container.scrollLeft() + container.width() / 2;

        var y = container.scrollTop() + container.height() / 2;

        var newX = x * ratio;
        var newY = y * ratio;

        if (css.width >= container.width() && css.height >= container.height()) {
            image.css(css);
            container.scrollTo({
                left: newX - container.width() / 2,
                top: newY - container.height() / 2
            });

        } else {
            if ($(".map-image").height() > $(".slick-slide").height()) {
                $(".inner-image-wrapper-5, .map-image").css({
                    width: "auto",
                    height: "100%",
                });
                $(".inner-image-wrapper-5").css({
                    transform: "translate(-50%, -50%)"
                });
            } else if ($(".map-image").height() != $(".slick-slide").height() || $(".map-image").width() > $(".slick-slide").width()) {
                $(".inner-image-wrapper-5, .map-image").css({
                    width: "100%",
                    height: "auto",

                });
                $(".inner-image-wrapper-5").css({
                    transform: "translate(-50%, -50%)"
                });
            }
            container.scrollTo({
                left: newX - container.width() / 2,
                top: newY - container.height() / 2
            });
        }

    });



    //---instrucciones -------

    $(".inner-image-wrapper-5").append('<a href="codigos/flags/help/CC_DECODER.pdf" target="_blank" class="instrucciones" data-id="Decoder_0"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/CC_DECODER.v" target="_blank" class="codigo" data-id="Decoder_0"></a >');

$(".inner-image-wrapper-5").append('<a href="codigos/flags/help/CC_DECODER.pdf" target="_blank" class="instrucciones" data-id="Decoder_u1"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/CC_DECODER.v" target="_blank" class="codigo" data-id="Decoder_u1"></a >');

$(".inner-image-wrapper-5").append('<a href="codigos/flags/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_0"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_0"></a >');

$(".inner-image-wrapper-5").append('<a href="codigos/flags/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_1"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_1"></a >');

$(".inner-image-wrapper-5").append('<a href="codigos/flags/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_2"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_2"></a >');

$(".inner-image-wrapper-5").append('<a href="codigos/flags/help/SC_RegGENERAL.pdf" target="_blank" class="instrucciones" data-id="RegGENERAL_3"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/SC_RegGENERAL.v" target="_blank" class="codigo" data-id="RegGENERAL_3"></a >');

$(".inner-image-wrapper-5").append('<a href="codigos/flags/help/SC_RegFIXED.pdf" target="_blank" class="instrucciones" data-id="RegFIXED_0"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/SC_RegFIXED.v target="_blank" class="codigo" data-id="RegFIXED_0"></a >');

$(".inner-image-wrapper-5").append('<a href="codigos/flags/help/SC_RegFIXED.pdf" target="_blank" class="instrucciones" data-id="RegFIXED_1"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/SC_RegFIXED.v" target="_blank" class="codigo" data-id="RegFIXED_1"></a >');

$(".inner-image-wrapper-5").append('<a href="codigos/flags/help/CC_MUXX.pdf" target="_blank" class="instrucciones" data-id="MUXX_0"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/CC_MUXX.v" target="_blank" class="codigo" data-id="MUXX_0"></a >');

$(".inner-image-wrapper-5").append('<a href="codigos/flags/help/CC_MUXX.pdf" target="_blank" class="instrucciones" data-id="MUXX_1"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/CC_MUXX.v" target="_blank" class="codigo" data-id="MUXX_1"></a >');

$(".inner-image-wrapper-5").append('<a href="codigos/flags/help/CC_ALU.pdf" target="_blank" class="instrucciones" data-id="ALU_0"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/CC_ALU.v" target="_blank" class="codigo" data-id="ALU_0"></a >');

$(".inner-image-wrapper-5").append('<a href="codigos/flags/help/SC_RegSHIFTER.pdf" target="_blank" class="instrucciones" data-id="RegSHIFTER_0"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/SC_RegSHIFTER.v" target="_blank" class="codigo" data-id="RegSHIFTER_0"></a >');

$(".inner-image-wrapper-5").append('<a href="codigos/flags/help/SC_STATEMACHINE_EXAMPLE.pdf" target="_blank" class="instrucciones" data-id="Caja"></a >');
$(".inner-image-wrapper-5").append('<a href="codigos/flags/doc/SC_STATEMACHINE_EXAMPLE.v" target="_blank" class="codigo" data-id="Caja"></a >');


    if ($(".map-image").width() >= $(".slick-slide").width()) {
        $(".inner-image-wrapper-5, .map-image").css({
            width: "100%",
            height: "auto"
        });
    }

    $(window).resize(function () {
        if ($(".map-image").height() > $(".slick-slide").height()) {
            $(".inner-image-wrapper-5, .map-image").css({
                width: "auto",
                height: "100%"
            });
        } else {
            $(".inner-image-wrapper-5, .map-image").css({
                width: "100%",
                height: "auto"
            });
        }
    });

    function verifica() {
        if (i >= cantidad) {
            $('#next-step').addClass('disabled');
            $('#prev-step').removeClass('disabled');
        } else if (i <= 1) {
            $('#prev-step').addClass('disabled');
            $('#next-step').removeClass('disabled');
        } else if ((i > 1) || (i < cantidad)) {
            $('#next-step').removeClass('disabled');
            $('#prev-step').removeClass('disabled');
        }
    }

    function verifyzoom() {
        if (clicked >= 5) {
            $('#zoom-in').addClass('d-none');
            $('#zoom-out').removeClass('d-none');
        } else if (clicked <= 1) {
            $('#zoom-out').addClass('d-none');
            $('#zoom-in').removeClass('d-none');
        } else {
            $('#zoom-in').removeClass('d-none');
            $('#zoom-out').removeClass('d-none');
        }
    }
});