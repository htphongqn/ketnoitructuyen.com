$(function () {
    var record = document.getElementById("Hdcountcate").value;
    var pos = 0;
    var count = 0;
    var heightmain = $('#div_banchay').offset().top - 800;
//    $(window).scroll(function () {
//        var mostOfTheWayDown = ($(document).height() - $(window).height());
//        var heighttest = (heightmain + $(window).height());
//        if ($(window).scrollTop() >= heighttest) {
//            if (pos < record) {
                $('#loadingmain').show();
                $.ajax({
                    url: '../vi-vn/Ajax-scroll-main.aspx',
                    data: 'pos=' + pos,
                    success: function (e) {
                        setTimeout(function () { getdata(e) }, 1000);
                    }
                });
//            }
            count++;
            pos += 1;
            heightmain += 200;
        //}
 //   });
});

function getdata(e) {
    $('#ajaxmain').append(e);
    $('#loadingmain').hide();
}