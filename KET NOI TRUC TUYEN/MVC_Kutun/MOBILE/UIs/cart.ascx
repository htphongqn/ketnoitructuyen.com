<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="cart.ascx.cs" Inherits="MVC_Kutun.MOBILE.UIs.cart" %>
<div class="box_Tab">
    <span>Thông tin đơn hàng</span></div>
<div class="box_ct">
    <div class=" order_info">
        <div class="row row_c">
            <div class="th">
                Sản phẩm</div>
            <div class="th">
                Số lượng</div>
            <div class="th">
                Giá</div>
        </div>
        <asp:Repeater ID="Rpgiohang" runat="server">
            <ItemTemplate>
                <div class="row">
                    <div class="td">
                        <%# Eval("NEWS_TITLE") %></div>
                    <div class="td">
                        <%# Eval("Basket_quantity")  %></div>
                    <div class="td">
                        <%# String.Format("{0:0,0 VNĐ}", Eval("Basket_Price")).Replace(",",".")%></div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <div class="row sum_r">
            <div class="th">
                Tổng tiền:
            </div>
            <div class="td fright">
                <asp:Label ID="lbtotalmoney" runat="server" Text=""></asp:Label></div>
        </div>
        <div class="row sum_r">
            <div class="th">
                Phí vận chuyển:
            </div>
            <div class="td fright">
                <asp:Label ID="Lbship" runat="server" Text=""></asp:Label></div>
        </div>
        <div class="row sum_r">
            <div class="th">
                Thành tiền:
            </div>
            <div class="td fright">
                <asp:Label ID="Lbtotal" runat="server" Text=""></asp:Label></div>
        </div>
    </div>
    <div class="note" style="margin-top: 15px; float: left; width: 100%">
        Miễn phí giao hàng cho đơn hàng &nbsp;<strong style="color: red"> 1.000.000 vnđ</strong>
        trở lên</div>
</div>
