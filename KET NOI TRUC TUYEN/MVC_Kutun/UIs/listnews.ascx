<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="listnews.ascx.cs" Inherits="MVC_Kutun.UIs.listnews" %>
<%@ Register Src="path.ascx" TagName="path" TagPrefix="uc1" %>
<%@ Register Src="left-menu-news.ascx" TagName="left" TagPrefix="uc2" %>
<div class="path">
    <a href="/">Trang chủ</a>
    <uc1:path ID="path1" runat="server" />
</div>
<!--Left Col-->
<div id="left_col" class="fl">
    <uc2:left ID="left1" runat="server" />
</div>
<!--end Left Col-->
<!--Right Col-->
<div id="right_col" class="fr">
    <!--List News-->
    <div class="box">
        <div class="box_Tab_main">
            <h1>
                <asp:Label ID="Lbtitle" runat="server" Text=""></asp:Label></h1>
        </div>
        <div id="list_news">
            <ul>
                <asp:Repeater ID="Rplistnews" runat="server">
                    <ItemTemplate>
                        <li><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),0) %>">
                            <%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %></a>
                            <h2>
                                <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),0) %>"
                                    class="news_title">
                                    <%# Eval("NEWS_TITLE") %>
                                </a>
                            </h2>
                            <p>
                                <%# Eval("NEWS_DESC") %></p>
                            <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),0) %>"
                                class="view_more">Chi tiết &raquo;</a> </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
            <div class="pagination">
                <asp:Literal ID="ltrPage" runat="server"></asp:Literal>
            </div>
        </div>
    </div>
    <!--End List News-->
</div>
<!--end Right Col-->
