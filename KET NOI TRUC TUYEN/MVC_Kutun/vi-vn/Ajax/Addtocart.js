﻿function addtocart(id, price) {
    if (price != 0) {
        $.ajax({
            url: '../vi-vn/Addtocart.aspx',
            data: 'id=' + id,
            success: function () {
                document.location = "/gio-hang.aspx";
            }
        });
    }
    else {
        alert("Bạn hãy liên hệ chúng tôi để mua sản phẩm này");
        return false;
    }
}