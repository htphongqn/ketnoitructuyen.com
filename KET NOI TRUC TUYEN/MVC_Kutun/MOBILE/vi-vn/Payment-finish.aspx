<%@ Page Title="" Language="C#" MasterPageFile="~/MOBILE/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Payment-finish.aspx.cs" Inherits="MVC_Kutun.MOBILE.vi_vn.Payment_finish" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="name_web">
        KetNoiTrucTuyen.vn</h1>
    <div class="path">
        <a href="/">Trang chủ</a> » <a href="#">Đăng nhập</a></div>
    <!--Login Page-->
    <div class="box">
        <!--Order Success-->
        <div id="orderInfo" class="box_payment fl">
            <div style="padding: 20px">
                <h1 class="" style="margin-bottom: 10px">
                    <img width="70" height="70" src="../vi-vn/Images/succe.jpg" style="float: left; margin-right: 5px"><span
                        class="large">Chúc mừng bạn đã đặt hàng thành công.</span><br />
                    Chúng tôi sẽ xử lý đơn hàng của bạn trong vòng 24h!
                </h1>
               
                <div class="row">
                    <p>
                        Chúng tôi đã gởi cho bạn một email xác nhận với đầy đủ thông tin chi tiết (Vui lòng
                        kiểm tra hộp thư đến hoặc spam)</p>
                </div>
                <div class="row" style="text-align: center">
                    <a href="/" class="btn_web btn_account" >
                        Trở về trang chủ >></a>
                </div>
            </div>
        </div>
        <!--Order Success-->
    </div>
    <!--End Login Page-->
</asp:Content>
