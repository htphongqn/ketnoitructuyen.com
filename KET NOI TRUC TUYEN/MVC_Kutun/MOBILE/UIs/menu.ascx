<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="menu.ascx.cs" Inherits="MVC_Kutun.MOBILE.UIs.menu" %>
<ul>
    <li class="cat-header"><a href="/">Trang chủ</a> </li>
    <li class="cat-header" id="div_login" runat="server"><a href="/m-dang-nhap.aspx">Đăng nhập / Đăng ký</a></li>
    <li class="cat-header" id="div_logout" runat="server"><a href="/m-quan-ly-tai-khoan.aspx">
        <asp:Label ID="Lbname" runat="server" Text=""></asp:Label></a> </li>
</ul>
<div class="close_menu">
    Đóng Menu</div>
