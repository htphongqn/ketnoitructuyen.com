<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="footer.ascx.cs" Inherits="MVC_Kutun.UIs.footer" %>
<%@ Register Src="Ads-bank.ascx" TagName="Ads" TagPrefix="uc1" %>
<!--Footer Column-->
<div id="footer_columns">
    <ul id="list_col_footer">
        <asp:Repeater ID="Rpmenu_foot" runat="server">
            <ItemTemplate>
                <!--Column Footer-->
                <li class="col_foo">
                    <div class="col_F_ct">
                        <h3 class="title_col_footer">
                            <%#Eval("CAT_NAME") %></h3>
                        <ul class="list_menu_footer">
                            <asp:Repeater ID="Repeater1" runat="server" DataSource='<%#Load_caterank2(Eval("CAT_ID")) %>'>
                                <ItemTemplate>
                                    <li><a class="footer_item_link" href="<%#GetLink_Cat(Eval("Cat_Url"),Eval("Cat_Seo_Url")) %>">
                                        <%#Eval("CAT_NAME") %></a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </li>
                <!--end Column Footer-->
            </ItemTemplate>
        </asp:Repeater>
        <!--Column Footer-->
        <li class="col_foo" id="info_footer">
            <div class="col_F_ct">
                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
            </div>
        </li>
        <!--end Column Footer-->
    </ul>
</div>
<!--end Footer Column-->
<!--Bank-->
<div class="box">
    <div class="tt_bank fl">
        Chấp nhận thanh toán</div>
    <div id="payment_bank" class="fr">
        <div id="sl_logobank">
            <ul>
                <uc1:Ads ID="Ads1" runat="server" />
                <li style="margin-left:340px"><a title="đã đăng ký bộ công thương" href="http://www.online.gov.vn/HomePage/CustomWebsiteDisplay.aspx?DocId=14555"
                    target="_blank">
                    <img title="Click xem chi tiết" src="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT6EEMq27lLhR35NV1FlWTFMQB9TuLv9VnTAK42dIjTZAQ6jaXG"
                        alt="Click xem chi tiết">
                </a></li>
            </ul>
        </div>
    </div>
</div>
<!--End Bank-->
<!--Categories Footer-->
<div id="category_footer" class="cf">
    <p class="title_cat">
        Danh mục và thương hiệu hàng đầu</p>
    <asp:Repeater ID="Rpmenufoot_thuonghieu" runat="server">
        <ItemTemplate>
            <div class="cols_cate_footer">
                <p class="name">
                    <a href="<%#GetLink_Cat(Eval("Cat_Url"),Eval("Cat_Seo_Url")) %>">
                        <%#Eval("CAT_NAME") %></a></p>
                <ul>
                    <asp:Repeater ID="Repeater1" runat="server" DataSource='<%#Load_caterank2(Eval("CAT_ID")) %>'>
                        <ItemTemplate>
                            <li><a href="<%#GetLink_Cat(Eval("Cat_Url"),Eval("Cat_Seo_Url")) %>">
                                <%#Eval("CAT_NAME") %></a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
<!--end Categories Footer-->
