<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Ucslider-ads.ascx.cs"
    Inherits="MVC_Kutun.UIs.Ucslider_ads" %>
<%@ Register Src="slider.ascx" TagName="slider" TagPrefix="uc2" %>
<%@ Register Src="Ads-right-slider.ascx" TagName="Ads" TagPrefix="uc3" %>
<!--Right Top Main-->

<div id="homebanners" class="fl">
  <!--Slide Banner-->
  <script type="text/javascript" src="../vi-vn/Scripts/fadeSlideShow.js"></script>
  <script type="text/javascript">
jQuery(document).ready(function(){
	jQuery('#slideshow').fadeSlideShow();
});
</script>
  <ul id="slideshow">
    <uc2:slider ID="slider1" runat="server" />
  </ul>
  <!--end Slide Banner-->
</div>
<!--Ads Right TOp Main-->
<div id="ads_right_top_main" class="fr">
  <uc3:Ads ID="Ads1" runat="server" />
</div>
<!--end Ads Right TOp Main-->
