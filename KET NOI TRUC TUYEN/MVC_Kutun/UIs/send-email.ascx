<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="send-email.ascx.cs"
    Inherits="MVC_Kutun.UIs.send_email" %>
<script src="../vi-vn/Ajax/Email.js" type="text/javascript"></script>
<div class="voucher_l fl">
    <h3 class="voucher_text">
        TẶNG NGAY <b>50,000đ</b> KHI ĐĂNG KÝ NHẬN BẢN TIN</h3>
    <div class="voucher_ct">
        <input type="text" class="txf" size="40" id="txtEmail" name="Email" value="Vui lòng nhập email của bạn" onclick="this.value=''">
        <button class="btn_submit" onclick="regis_mail();">
            Đăng ký ngay
        </button>
    </div>
</div>
<div id="social_network" class="fr">
    <b>Kết nối:</b>
    <asp:Repeater ID="Rpfacebook" runat="server">
        <ItemTemplate>
            <%# LoadOnline(Eval("ONLINE_TYPE"), Eval("ONLINE_DESC"), Eval("ONLINE_NICKNAME"))%>
        </ItemTemplate>
    </asp:Repeater>
</div>
