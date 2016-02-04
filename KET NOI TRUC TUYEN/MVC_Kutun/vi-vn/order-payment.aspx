<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Order-payment.aspx.cs" Inherits="MVC_Kutun.vi_vn.Order_payment" %>

<%@ Register Src="../UIs/History-payment.ascx" TagName="History" TagPrefix="uc1" %>
<%@ Register Src="../UIs/leftmenu-userinfo.ascx" TagName="leftmenu" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="path">
        <a href="/trang-chu.html">Trang chủ</a> » Quản lý đơn hàng
    </div>
    <div id="div_left" runat="server">
        <!--Left Col-->
        <div id="left_col" class="fl">
            <uc2:leftmenu ID="leftmenu1" runat="server" />
        </div>
        <!--end Left Col-->
    </div>
    <!--Right Col-->
    <div id="right_col" class="fr">
        <div class="box">
            <div class="box_Tab_main">
                <h1>
                    Quản lý đơn hàng</h1>
            </div>
            <div class="list_products">
                <uc1:History ID="History1" runat="server" />
            </div>
        </div>
    </div>
</asp:Content>
