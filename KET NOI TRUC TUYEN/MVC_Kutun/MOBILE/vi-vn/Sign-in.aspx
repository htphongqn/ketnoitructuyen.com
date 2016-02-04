<%@ Page Title="" Language="C#" MasterPageFile="~/MOBILE/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Sign-in.aspx.cs" Inherits="MVC_Kutun.MOBILE.vi_vn.Sign_in" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="path">
        <a href="/">Trang chủ</a> » <a href="#">Đăng nhập</a></div>
    <!--Login Page-->
    <div class="box" id="account">
        <div class="box_Tab">
            Đăng nhập</div>
        <span class="form_subtitle">Đăng nhập vào tài khoản đã tạo</span>
        <!--Form Login-->
        <div class="box_ct login_form form_web">
            <div class="row_account">
                <label for="formUsername" class="item_title">
                    Email:<span class="required">*</span></label>
                <input type="text" id="txtemail" name="txtemail" class="inputbox" runat="server">
            </div>
            <div class="row_account">
                <label for="formPassword" class="item_title">
                    Mật khẩu<span class="required">*</span></label>
                <input type="password" id="txtpass" name="txtpass" class="inputbox" runat="server">
            </div>
            <div class="row_account text">
                <a class="forgot_pass" href="/m-quen-mat-khau.aspx">Quên Mật Khẩu</a></div>
            <div class="row_account text">
                <a class="forgot_pass" href="/m-dang-ky.aspx">Bạn chưa có tài khoản?</a>
            </div>
            <div class="row_account text">
                <asp:LinkButton ID="Lblogin" runat="server" class="btn_web button1" 
                    onclick="Lblogin_Click">Đăng nhập</asp:LinkButton>
            </div>
        </div>
        <!--End Form Login-->
    </div>
    <!--End Login Page-->
</asp:Content>
