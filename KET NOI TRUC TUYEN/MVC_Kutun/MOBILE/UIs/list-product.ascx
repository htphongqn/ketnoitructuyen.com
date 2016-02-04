<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="list-product.ascx.cs"
    Inherits="MVC_Kutun.MOBILE.UIs.list_product" %>
<%@ Register Src="path.ascx" TagName="path" TagPrefix="uc1" %>
<div class="path">
    <a href="/">Trang chủ</a>
    <uc1:path ID="path1" runat="server" />
</div>
<!--List Products-->
<div class="box">
    <h1 class="box_Tab">
        <asp:Label ID="Lbtitle" runat="server" Text=""></asp:Label></h1>
    <div id="list_products">
        <div id="moredata">
            <asp:Repeater ID="Rplistpro" runat="server">
                <ItemTemplate>
                    <!--#item_P-->
                    <div class="item_P">
                        <div class="product">
                            <div class="img_product">
                                <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                    <img src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" alt="" />
                                </a>
                            </div>
                            <div class="info_P">
                                <h3 class="product_name">
                                    <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                        <%#Eval("NEWS_TITLE") %></a></h3>
                                <div class="first_price">
                                    <del>
                                        <%#GetPrice2(Eval("News_Price1"), Eval("NEWS_PRICE2"))%></del></div>
                                <price><%#GetPrice1(Eval("News_Price1"), Eval("NEWS_PRICE2"))%></price>
                                <!--btn_P-->
                            </div>
                            <!--info_P-->
                            <%#Getgiam(Eval("News_Price1"), Eval("News_Price2"))%>
                        </div>
                        <!--product-->
                    </div>
                    <!--/item_P-->
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
    <!--list_products-->
    <div class="navigation_news">
        <asp:HiddenField ID="Hdcount" runat="server" />
        <a onclick="viewmore(<%=getCatid() %>,<%=getCount() %>);" href="javascript:void(0)">
            Xem thêm</a>
    </div>
    <!--/box-->
    <script>
        $(function () {
            var _count = document.getElementById("<%=Hdcount.ClientID %>").value;
            if (_count <= 15)
                document.getElementById("divmore").style.display = "none";
        });
        var skip = 15;
        function viewmore(id, count) {
            $.ajax({
                type: "POST",
                url: '/MOBILE/vi-vn/Ajax-morelistpro.aspx/getmorepro',
                data: "{id:'" + id + "',skip:'" + skip + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (e) {
                    skip += 15;
                    $('#moredata').append(e.d);
                    if (skip >= count)
                        document.getElementById("divmore").style.display = "none";

                }
            });
        }
    </script>
</div>
