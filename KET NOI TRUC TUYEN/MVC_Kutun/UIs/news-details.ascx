<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="news-details.ascx.cs"
    Inherits="MVC_Kutun.UIs.news_details" %>
<%@ Register Src="left-menu-news.ascx" TagName="left" TagPrefix="uc1" %>
<%@ Register Src="path.ascx" TagName="path" TagPrefix="uc2" %>
<%@ Register Src="toolbar.ascx" TagName="toolbar" TagPrefix="uc3" %>
<div class="path">
    <a href="/">Trang chủ</a>
    <uc2:path ID="path1" runat="server" />
</div>
<!--Left Col-->
<div id="left_col" class="fl">
    <uc1:left ID="left1" runat="server" />
</div>
<!--end Left Col-->
<uc3:toolbar ID="toolbar1" runat="server" />
<!--Right Col-->
<div id="right_col" class="fr">
    <!--Detail news-->
    <div class="box">
        <div class="box_Tab_main">
            <h1>
                <asp:Label ID="lbtitle_cate" runat="server" Text=""></asp:Label></h1>
        </div>
        <div class="box_ct_home" id="detail_news">
            <h1 class="h1Title">
                <asp:Label ID="lbNewsTitle" runat="server" Text=""></asp:Label></h1>
            <div id="info_g">
                <asp:Literal ID="liHtml" runat="server"></asp:Literal>
                <div>
                    <asp:Repeater ID="Rpattfile" runat="server">
                        <ItemTemplate>
                            <%#BindAttItems(Eval("NEWS_ID"), Eval("EXT_ID"), Eval("NEWS_ATT_NAME"), Eval("NEWS_ATT_URL"), Eval("NEWS_ATT_FILE"), Eval("EXT_FILE_IMAGE"))%>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div class="function">
                <div class="addthis_toolbox addthis_default_style like_face">
                    <a class="addthis_button_preferred_1"></a><a class="addthis_button_preferred_2">
                    </a><a class="addthis_button_preferred_3"></a><a class="addthis_button_preferred_4">
                    </a><a class="addthis_button_compact"></a><a class="addthis_counter addthis_bubble_style">
                    </a>
                    <script type="text/javascript">
                        var addthis_config = { "data_track_addressbar": true };
                        addthis_config = addthis_config || {};
                        addthis_config.data_track_addressbar = false;
                    </script>
                    <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-50d418ab2d45f0aa"></script>
                </div>
                <div class="toolbar">
                    <a id="hplSendEmail" href="#" class="email" runat="server">Gửi email</a> <a href="#"
                        id="hplFeedback" runat="server" class="opinion">Phản hồi</a></div>
            </div>
            <!--Other News-->
            <div class="other_news_sub" id="dvOtherNews" runat="server">
                <div class="other_newsT">
                    Tin bài khác</div>
                <ul>
                    <asp:Repeater ID="Rptinkhac" runat="server">
                        <ItemTemplate>
                            <li><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),0) %>">
                                <%# Eval("NEWS_TITLE") %>
                            </a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
                <a id="hplViewmore" runat="server" class="view_all" href="">Xem tất cả &raquo;</a>
            </div>
            <!--Other News-->
        </div>
    </div>
    <!--End Detail news-->
</div>
<!--end Right Col-->
