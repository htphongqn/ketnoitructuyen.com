<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="top-page.ascx.cs" Inherits="MVC_Kutun.UIs.top_page" %>
<%@ Register Src="forgetpass.ascx" TagName="forgetpass" TagPrefix="uc2" %>
<div id="top_link" class="wrap">
    <ul class="link_left fl">
        <asp:Repeater ID="Rpmenutop" runat="server">
            <ItemTemplate>
                <li><a href="<%#GetLink(Eval("Cat_Url"),Eval("Cat_Seo_Url")) %>">
                    <%#Eval("CAT_NAME") %></a></li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
    <ul class="link_right fr">
        <li><a href="/chuyen-muc/san-pham-yeu-thich.html" title="Danh sách yêu thích">Danh sách
            yêu thích</a></li>
        <li><span id="div_login" runat="server"><span class="trigger">Đăng nhập</span> / <span>
            <a href="/dang-ky.aspx" style="color: White">Đăng ký</a></span>
            <div class="popup_login" id="dpop">
                <span class="close_box_acc">X</span>
                <div class="input_form">
                    <label for="LoginForm_email">
                        Email <span class="required">*</span></label>
                    <input type="text" class="input identity" maxlength="50" id="txtemail" name="txtemail">
                </div>
                <div class="input_form">
                    <label for="LoginForm_password">
                        Mật khẩu <span class="required">*</span></label>
                    <input type="password" class="input password" id="txtpass" name="txtpass">
                </div>
                <div style="color: Red" class="errors">
                </div>
                <div id="loading-errors">
                </div>
                <div class="note_wrapper clearfix">
                    <div class="lost_password">
                        <a href="javascript:void(0)" class="link_acount" onclick="showquyenmk();">Quên mật khẩu</a>
                    </div>
                </div>
                <div class="input_form">
                    <a style="display: block; height: 28px; padding-top: 10px;" class="button" onclick="ajaxlogin();"
                        href="javascript:void(0)">Đăng nhập</a>
                </div>
                <div class="note_wrapper">
                    Bạn chưa là thành viên? <a class="link_acount" href="/dang-ky.aspx" rel="nofollow">Đăng
                        ký ngay</a></div>
            </div>
        </span><span id="div_logout" runat="server"><span class="trigger"><b>Xin chào,
            <asp:Label ID="lbthanhvien" runat="server" Text=""></asp:Label>
        </b></span>
            <div class="popup_login">
                <span class="close_box_acc">X</span>
                <ul class="account">
                    <li><a target="_parent" href="/quan-ly-tai-khoan.aspx">Quản lý tài khoản</a> </li>
                    <li><a target="_parent" href="/doi-mat-khau.aspx">Đổi mật khẩu</a> </li>
                    <li><a target="_parent" href="/thong-tin-ca-nhan.aspx">Thông tin cá nhân</a> </li>
                    <li><a target="_parent" href="/dia-chi-giao-hang.aspx">Địa chỉ giao hàng</a> </li>
                    <li><a target="_parent" href="/lich-su-mua-hang.aspx">Đơn hàng của tôi</a> </li>
                    <li><a target="_parent" href="/chuyen-muc/san-pham-yeu-thich.aspx">Sản phẩm yêu thích</a>
                    </li>
                    <li>
                        <asp:LinkButton ID="lbtnDangXuat" runat="server" CausesValidation="False" OnClick="lbtnDangXuat_Click">Đăng xuất</asp:LinkButton>
                    </li>
                </ul>
            </div>
        </span></li>
    </ul>
</div>
<uc2:forgetpass ID="forgetpass1" runat="server" />
<script src="../vi-vn/Ajax/login.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var notH = 1,
    $pop = $('.popup_login').hover(function () { notH ^= 1; });

        $(document).on('mouseup keyup', function (e) {
            if (notH || e.which == 27) $pop.stop().hide();
        });
        /////// CALL POPUP 
        $('.trigger').click(function () {
            $('.popup_login').slideToggle('fast').end().siblings().$('.popup_login').hide('fast');
            event.stopPropagation();
        });
        $('.close_box_acc').click(function () {
            $('.popup_login').slideUp('fast');
        });
    }); 
</script>
