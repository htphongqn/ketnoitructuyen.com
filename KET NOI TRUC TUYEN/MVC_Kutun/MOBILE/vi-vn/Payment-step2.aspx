﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MOBILE/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Payment-step2.aspx.cs" Inherits="MVC_Kutun.MOBILE.vi_vn.Payment_step2" %>

<%@ Register Src="../UIs/Payment-giaohangtannoi.ascx" TagName="Payment" TagPrefix="uc1" %>
<%@ Register Src="../UIs/cart.ascx" TagName="cart" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="name_web">
        KetNoiTrucTuyen.vn</h1>
    <div class="path">
        <a href="/">Trang chủ</a> » <a href="#">Thông tin giao hàng</a></div>
    <!--address-->
    <div class="bg_chk">
        <img src="/MOBILE/vi-vn/Images/bg_b_b1.png" /></div>
    <div class="box">
        <div class="box_Tab">
            <span>THÔNG TIN GIAO HÀNG</span></div>
        <div class="box_ct ship_info" id=" ">
            <uc1:Payment ID="Payment1" runat="server" />
        </div>
    </div>
    <!--End Cart Page-->
    <!--order_info-->
    <div class="box">
        <uc2:cart ID="cart1" runat="server" />
    </div>
    <!--order_info-->
</asp:Content>
