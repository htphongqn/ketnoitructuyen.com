<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="topmenu.ascx.cs" Inherits="MVC_Kutun.UIs.topmenu" %>
<%@ Register Src="header-search.ascx" TagName="header" TagPrefix="uc1" %>
<!-- Main Menu-->
<div class="all_categories fl">
    <div id="div_script" runat="server">
        <script type='text/javascript'>//<![CDATA[
            $(function () {
                var sticky_navigation_offset_top = $('#sticky_navigation').offset().top;
                var sticky_navigation = function () {
                    var scroll_top = $(window).scrollTop();
                    if (scroll_top > sticky_navigation_offset_top) {
                        $('#sticky_navigation').css({ 'position': 'fixed', 'top': 0 });
                    } else {
                        $('#sticky_navigation').css({ 'position': 'relative' });
                    }
                };

                sticky_navigation();

                $(window).scroll(function () {
                    sticky_navigation();
                });
            }); // JavaScript Document
        </script>
    </div>
    <div class="show_menu">
        <div class="tab_cate">
            <span>DANH MỤC SẢN PHẨM<i class="arr_down"></i></span></div>
        <!--Main Menu-->
        <ul class="nav_menu" <%=setStyle() %>>
            <script type="text/javascript">
                $(function () {                   
                    $('.m_li').bind('mouseenter', function () {

                        $(this).find('.list_categories').stop(true, true).fadeIn(200);                        
                    }).bind('mouseleave', function () {
                        $(this).find('.list_categories').stop(true, true).fadeOut(200, function () {

                        });
                    });
                })	
            </script>
            <asp:Repeater ID="Rpmenucate" runat="server">
                <ItemTemplate>
                    <li class="m_li">
                        <img alt="<%#Eval("cat_name")%>" src="<%#getImagecat(Eval("CAT_ID"),Eval("CAT_IMAGE1")) %>" /><h3><a href="<%#GetLink(Eval("cat_url"),Eval("cat_seo_url"))%>"
                            class="t_menu">
                            <%#Eval("cat_name")%></a></h3>
                        <div style="left: 0px; display: none;" class="list_categories">
                            <div class="subcatwrapper">
                                <asp:Repeater ID="Repeater1" runat="server" DataSource='<%# Load_Menu2(Eval("Cat_ID")) %>'>
                                    <ItemTemplate>
                                        <div class="pc_menu">
                                            <h4>
                                                <a href="<%#GetLink(Eval("cat_url"),Eval("cat_seo_url"))%>" title="<%#Eval("cat_name")%>">
                                                    <%#Eval("cat_name")%></a>

                                                    <asp:Repeater ID="Repeater1" runat="server" DataSource='<%# Load_Menu2(Eval("Cat_ID")) %>'>
                                                        <ItemTemplate>
                                                            <div class="pc_menu">
                                                                <h4>
                                                                    <a href="<%#GetLink(Eval("cat_url"),Eval("cat_seo_url"))%>" title="<%#Eval("cat_name")%>" style="font-weight:normal">
                                                                        <%#Eval("cat_name")%></a>
                                                                </h4>
                                                                <div class="cf">
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                            </h4>
                                            <div class="cf">
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <span class="backgroundMenu" style="display: none">
                                    <img src="<%#getImagecat(Eval("CAT_ID"),Eval("CAT_IMAGE2")) %>" alt='<%#Eval("cat_name")%>' title="<%#Eval("cat_name")%>" width="100%" />
                                </span>
                            </div>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </div>
</div>
<!--end Main Menu-->
<!--Right Top Main-->
<div id="right_top_main" class="fr">
    <div class="topbar">
        <uc1:header ID="header1" runat="server" />
    </div>
    <asp:PlaceHolder ID="PlSlider" runat="server"></asp:PlaceHolder>
</div>
