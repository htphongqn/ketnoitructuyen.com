$(function () {
    var getcountUl = $('#cate_left ul.list_field').length;
    for (var i = 0; i < getcountUl; i++) {
        var idul = $('#cate_left ul.list_field').eq(i).attr("id");
        var getcountCate = $("#" + idul + " li").length;
        for (var x = 0; x < getcountCate; x++) {
            if (x > 7)
                $("#" + idul + " li").eq(x).hide();
        }
        if (getcountCate > 7) {
            $("#" + idul + "").append("<li><a href='javascript:void()' onclick='viewmoreCate(this," + getcountCate + ");'>Xem thêm</a></li>")
        }
    }
    var getcountUlth = $('#trademark ul li').length;
   
    for (var i = 0; i < getcountUlth; i++) {
        if (i > 7)
            $('#trademark ul li').eq(i).hide();
    }
    if (getcountUlth > 7) {
        $('#trademark ul').append("<li><a href='javascript:void()' onclick='viewmoreThuonghieu(this," + getcountUlth + ");'>Xem thêm</a></li>")
    }
});
function viewmoreCate(e, count) {
    for (var x = 0; x < count; x++) {
        if (x > 7) {
            $(e).parent("li").parent("ul").find("li").eq(x).show();

        }
    }
    $(e).hide();
}
function viewmoreThuonghieu(e,count) {
    for (var i = 0; i < count; i++) {
        if (i > 7)
            $(e).parent("li").parent("ul").find("li").eq(i).show();
    }
    $(e).hide();
}