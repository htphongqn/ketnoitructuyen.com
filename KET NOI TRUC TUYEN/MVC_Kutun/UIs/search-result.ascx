<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="search-result.ascx.cs"
    Inherits="MVC_Kutun.UIs.search_result" %>
<div class="path">
    <a href="/">Trang chủ</a> » Tìm kiếm
</div>
<!--Right Col-->
<div id="right_col" class="fr" style="width: 100%">
    <div class="box">
        <div class="box_Tab_main">
            <h1>Kết quả tìm kiếm từ khóa: <asp:Literal ID="lbTukhoa" runat="server"></asp:Literal></h1>
        </div>
        <div class="box_ct_home list_products">
            <ul>
                <asp:Repeater ID="Rpproduct" runat="server">
                    <ItemTemplate>
                        <li class="item_P">
                            <!--Start Product-->
                            <div class="product">
                                <div class="boxgrid">
                                    <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"></a><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"
                                        class="img_product">
                                        <img alt=" <%#Eval("NEWS_TITLE") %>" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" /></a>
                                    <!--Box Caption-->
                                    <%--<div class="boxcaption trans">
                                        <div class="nolist cf">
                                            <%#Eval("NEWS_DESC") %>
                                        </div>
                                    </div>--%>
                                    <!--End Box Caption-->
                                </div>
                                <h3 class="product_name">
                                    <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                        <%#Eval("NEWS_TITLE") %></a></h3>
                                <del>
                                    <%#GetPrice2(Eval("News_Price1"), Eval("News_Price2"))%></del>
                                <div class="price">
                                    Giá: <b>
                                        <%#GetPrice1(Eval("News_Price1"), Eval("News_Price2"))%></b></div>
                                <%#getBuy(Eval("NEWS_ID"), Eval("NEWS_FIELD3"))%>
                                <%#Getgiam(Eval("News_Price1"), Eval("News_Price2"))%>
                            </div>
                            <!--end Start Product-->
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
        <div class="pagination">
            <asp:Literal ID="ltrPage" runat="server"></asp:Literal>
        </div>
    </div>
</div>
<!--end Right Col-->
