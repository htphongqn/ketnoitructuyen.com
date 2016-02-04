<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="right-fix.ascx.cs" Inherits="MVC_Kutun.UIs.right_fix" %>
<script type='text/javascript'>//<![CDATA[ 
$(function() {    
			var sticky_navigation_offset_top = $('#left_fix_side').offset().top;
			var sticky_navigation = function(){
				var scroll_top = $(window).scrollTop();
				if (scroll_top > sticky_navigation_offset_top) { 
					$('#left_fix_side').css({ 'position': 'fixed', 'top':0 });
				} else {
					$('#left_fix_side').css({ 'position': 'fixed', 'top':200 }); 
				}   
			};
			
			sticky_navigation();
			
			$(window).scroll(function() {
			sticky_navigation();
			});
		});// JavaScript Document
</script>
<!--Viewed Products-->

<div id="viewed_P" class="item_side_fix" style="display:none">
  <div class="tt_viewedP"> Sản phẩm đã xem (<i><%=countprosee() %></i>)</div>
  <div id="slide_viewed_P">
    <ul>
      <asp:Repeater ID="Rppro_see" runat="server">
        <ItemTemplate>
          <li><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"
                    title="<%#Eval("NEWS_TITLE") %>"> <img src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" width="42" height="42" /></a> </li>
        </ItemTemplate>
      </asp:Repeater>
    </ul>
    <div class="cf"></div>
    <a id="prev_viewed" class="prev" href="#">&lt;</a> <a id="next_viewed" class="next" href="#">&gt;</a></div>
</div>
<!--end Viewed Products-->
<!--Liked Products-->
<div id="liked_P" class="item_side_fix cf">
  <div class="tt_viewedP"> Sản phẩm bạn thích</div>
  <div id="slide_liked_P">
    <ul>
      <asp:Repeater ID="Rppro_like" runat="server">
        <ItemTemplate>
          <li><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"
                    title="<%#Eval("NEWS_TITLE") %>"> <img src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" width="42" height="42" /></a> </li>
        </ItemTemplate>
      </asp:Repeater>
    </ul>
    <div class="cf"></div>
    <a id="prev_liked" class="prev" href="#">&lt;</a> <a id="next_liked" class="next" href="#">&gt;</a> </div>
</div>
<!--end Liked Products-->
<!--Face-->
<div class="item_side_fix cf">
    <div style="margin-bottom:10px">
    <div id="fb-root"></div>
    <script>    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.4";
        fjs.parentNode.insertBefore(js, fjs);
    } (document, 'script', 'facebook-jssdk'));</script>
    <div class="fb-share-button" data-href="https://www.facebook.com/ketnoitructuyen?_rdr=p" data-layout="box_count"></div>
    </div>
        <!-- Place this tag in your head or just before your close body tag. -->
    <script src="https://apis.google.com/js/platform.js" async defer></script>

    <!-- Place this tag where you want the +1 button to render. -->
    <div class="g-plusone"></div>
</div>
<!--end face-->
<!--Convert Mobile Version-->
<div class="item_side_fix cf">
  <asp:LinkButton ID="Lbadddevice" runat="server" OnClick="Lbadddevice_Click" class="icon_mobile trans"></asp:LinkButton>
</div>
<!--end Convert Mobile Version-->
