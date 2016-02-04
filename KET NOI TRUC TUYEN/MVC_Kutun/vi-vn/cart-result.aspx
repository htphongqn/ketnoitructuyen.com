<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="cart-result.aspx.cs" Inherits="MVC_Kutun.vi_vn.cart_result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--Cart Page-->
    <link href="../vi-vn/Styles/process_payment.css" rel="stylesheet" type="text/css" />
    <div id="cart_page">
        <div class="row_th_cart">
            <h3 class="th_table_cart fl" style="width: 15%">
                Hình ảnh
            </h3>
            <h3 class="th_table_cart fl" style="width: 40%">
                Tên Sản Phẩm
            </h3>
            <h3 class="th_table_cart fl" style="width: 15%">
                Giá Bán
            </h3>
            <h3 class="th_table_cart fl" style="width: 10%">
                Số Lượng
            </h3>
            <h3 class="th_table_cart fl" style="width: 20%">
                Thành Tiền
            </h3>
        </div>
        <asp:Repeater ID="Rpgiohang" runat="server" OnItemCommand="Rpgiohang_ItemCommand">
            <ItemTemplate>
                <!--Item Cart-->
                <div class="item_cart fl">
                    <input type="hidden" value='<%# Eval("news_id") %>' id="newsid" runat="server" />
                    <a href='<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>'
                        target='_parent' class='img_cart fl'>
                        <img src='<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>' alt='' width='100'
                            height='100' /></a>
                    <div class="cell name">
                        <div>
                            <span>
                                <%# Eval("NEWS_TITLE") %></span></div>
                    </div>
                    <div class="cell unit">
                        <span class="new" id="soldprice_1757">
                            <%# String.Format("{0:0,0 VNĐ}", Eval("Basket_Price")).Replace(",",".")%></span></div>
                    <div class="cell amount">
                        <!-- so luong -->
                        <div class="quantity" style="margin: 0">
                            <asp:TextBox ID="Txtquantity" runat="server" Text='<%# Eval("Basket_quantity")  %>'
                                onkeyup="this.value=formatNumeric(this.value);" onblur="this.value=formatNumeric(this.value);"
                                Width="35" Style="text-align: center; border: 1px solid;"></asp:TextBox>
                        </div>
                        <!-- -->
                    </div>
                    <div class="cell total" id="dealtotal_1757">
                        <%# String.Format("{0:0,0 VNĐ}",Convert.ToInt32(Eval("Basket_Price"))*Convert.ToInt32(Eval("Basket_Quantity"))).Replace(",",".") %></div>
                    <asp:LinkButton ID="LinkXoa" class="close" runat="server" CommandName="delete" CommandArgument='<%# Eval("news_id") %>'></asp:LinkButton>
                </div>
                <!--end Item Cart-->
            </ItemTemplate>
        </asp:Repeater>
        <div class="foo-cart">
            <div class="total-cart">
                <p style="display: block">
                    Tổng tiền:<span id="total-money">
                        <asp:Label ID="Lbtotal" runat="server" Text=""></asp:Label>
                    </span>
                </p>
            </div>
        </div>
        <div class="button_cart">
            <a class="btn_web btn_payment fr" href="/thanh-toan-buoc-1.aspx" style="margin-left: 15px">
                Thanh toán</a>
            <asp:LinkButton ID="Lbcapnhap" runat="server" class="btn_web btn_payment fr" OnClick="Lbcapnhap_Click"
                Style="margin-left: 15px">Cập nhật giỏ hàng</asp:LinkButton>
            <a class="btn_web btn_payment fr" href="/">Mua thêm sản phẩm khác...</a>
            <asp:HyperLink ID="HyPrintbaogia" runat="server" Target="_blank" class="btn_web btn_payment fr" style="margin-right:20px">In báo giá</asp:HyperLink>
            </div>
    </div>
    <!--end Cart Page-->
    <script>
        function formatNumeric(num) {
            num = repStr(num.toString());
            if (isNaN(num)) {
                num = "0";
            }
            return (num);
        }
        function repStr(str) {
            var strResult = "";
            for (i = 0; i < str.length; i++)
                if ((str.charAt(i) != "$") && (str.charAt(i) != ",")) {
                    strResult = strResult + str.charAt(i)
                }
            return strResult;
        }
    </script>
</asp:Content>
