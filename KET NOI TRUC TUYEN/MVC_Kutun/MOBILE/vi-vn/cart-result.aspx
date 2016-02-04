<%@ Page Title="" Language="C#" MasterPageFile="~/MOBILE/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="cart-result.aspx.cs" Inherits="MVC_Kutun.MOBILE.vi_vn.cart_result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="path">
        <a href="/">Trang chủ</a> &gt; <a class="aLink1" href="#">Giỏ hàng
            của bạn</a>
    </div>
    <!--Cart-->
    <div class="block">
        <div class="block_ct">
            <asp:Repeater ID="Rpgiohang" runat="server" OnItemCommand="Rpgiohang_ItemCommand">
                <ItemTemplate>
                    <div class="item_cart">
                        <input type="hidden" value='<%# Eval("news_id") %>' id="newsid" runat="server" />
                        <a target="_parent" href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                            <img alt="" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" class="img_cart" /></a>
                        <div class="detail_cart fleft">
                            <div class="cell name">
                                <div>
                                    <span>
                                        <%# Eval("NEWS_TITLE") %></span></div>
                            </div>
                            <div class="cell unit">
                                <span class="new">
                                    <%# String.Format("{0:0,0 VNĐ}", Eval("Basket_Price")).Replace(",",".")%></span></div>
                        </div>
                        <div class="fright">
                            <div class="cell amount">
                                <!-- so luong -->
                                Số lượng:
                                <asp:TextBox ID="Txtquantity" runat="server" Text='<%# Eval("Basket_quantity")  %>'
                                    onkeyup="this.value=formatNumeric(this.value);" onblur="this.value=formatNumeric(this.value);"
                                    Width="35" Style="text-align: center; border: 1px solid;"></asp:TextBox>
                            </div>
                            <asp:LinkButton ID="LinkXoa" class="close" runat="server" CommandName="delete" CommandArgument='<%# Eval("news_id") %>'></asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div class="foo-cart">
                <div class="total-cart">
                    <p style="display: block">
                        <div class="line_dot" style="margin-bottom: 10px">
                        </div>
                        Tổng tiền:<span id="total-money"><asp:Label ID="Lbtotal" runat="server" Text=""></asp:Label></span>
                    </p>
                </div>
            </div>
            <div class="button_cart">
                <a href="/thanh-toan-buoc-1-mobile.aspx" class="btn_web btn_payment"">Tiến hành đặt hàng</a>
                <asp:LinkButton ID="Lbcapnhap" runat="server" class="btn_web btn_payment" OnClick="Lbcapnhap_Click">Cập nhật giỏ hàng</asp:LinkButton>
                <a href="/" class="btn_web btn_payment">Mua
                    thêm sản phẩm khác</a>
            </div>
        </div>
    </div>
    <!--End Cart-->
</asp:Content>
