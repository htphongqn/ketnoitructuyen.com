function loadproSlider(e, type) {
    $(e).addClass("active");
    $.ajax({
        type: "POST",
        url: "../vi-vn/ServiceAjax.asmx/ajaxProhighlight",
        data: "{'type':'" + type + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (e) {
            alert(e.d);
            switch (type) {
                case 1: $('#popular_products ul').html(e.d); break;
                case 2: $('#recently_viewed_products ul').html(e.d); break;
                case 3: $('#recently_liked_products ul').html(e.d); break;
                case 4: $('#buyed_products ul').html(e.d); break;
                case 5: $('#updated_products ul').html(e.d); break;
                case 6: $('#saleoff_products ul').html(e.d); break;
            }
        }
    });
}