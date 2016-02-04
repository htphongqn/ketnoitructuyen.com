<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="header.ascx.cs" Inherits="MVC_Kutun.UIs.header" %>
<%@ Register Src="hotlinefix.ascx" TagName="hotlinefix" TagPrefix="uc1" %>
<%@ Register Src="Order-news.ascx" TagName="Order" TagPrefix="uc3" %>
<asp:Repeater ID="Rplogo" runat="server">
    <ItemTemplate>
        <%# Getbanner(Eval("BANNER_TYPE"),Eval("BANNER_FIELD1"), Eval("BANNER_ID"), Eval("BANNER_FILE"))%>
    </ItemTemplate>
</asp:Repeater>
<!--Function Web-->
<div class="info_header fl">
    <div class="info_item">
        <span class="info_ico payment_icon"></span><b>THANH TOÁN<br />
            KHI NHẬN HÀNG</b>
    </div>
    <div class="info_item">
        <span class="info_ico bestprice_icon"></span><b>GIÁ<br />
            TỐT NHẤT</b>
    </div>
    <div class="info_item">
        <span class="info_ico return_icon"></span><b>GIAO HÀNG<br />
            TOÀN QUỐC</b>
    </div>
    <div class="info_item">
        <span class="info_ico delivery_icon"></span><b>7 NGÀY<br />
            TRẢ HÀNG</b>
    </div>
</div>
<!--end Function Web-->
<div id="status_buying" class="fl">
    <uc3:Order ID="Order1" runat="server" />
</div>
<!--Hotline-->
<div class="hotline fr">
    <div>
        <b>
            <uc1:hotlinefix ID="hotlinefix2" runat="server" />
        </b>
    </div>
</div>
<!--end Hotline-->
