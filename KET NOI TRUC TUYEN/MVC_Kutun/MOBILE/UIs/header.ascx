<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="header.ascx.cs" Inherits="MVC_Kutun.MOBILE.UIs.header" %>
<div id="menu_button" class="fleft">
    <div class="menu_icon fa fa-fw fa-list">
    </div>
</div>
<div id="mobile_logo">
    <a href="/">
        <img src="/MOBILE/vi-vn/Images/logo.png" alt="Kết Nối Trực Tuyến">
    </a>
</div>
<a href="/m-gio-hang.aspx" id="cart" class="fright"><b class="itemNumber">
    <%=totalCart() %></b></a>