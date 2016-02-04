<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="footer.ascx.cs" Inherits="MVC_Kutun.MOBILE.UIs.footer" %>
<script>
  var mySwiper1 = new Swiper('.sw1',{
    //pagination: '.pagination',
    loop:false,
    //grabCursor: true,
    paginationClickable: true,
	//slidesPerView: 3
  }) 
  var mySwiper2 = new Swiper('.sw2',{
    //pagination: '.pagination',
    loop:false,
    //grabCursor: true,
    paginationClickable: true,
	//slidesPerView: 3
  }) 
  var mySwiper3 = new Swiper('.sw3',{
    //pagination: '.pagination',
    loop:false,
    //grabCursor: true,
    paginationClickable: true,
	//slidesPerView: 3
  }) 
</script>
<!--List All Categories-->
<div class="box">
    <div class="box_Tab tab_home" style="background: #006599; color: white; text-align: left;
        text-transform: none;">
        Ketnoitructuyen.com - Kênh mua sắm trực tuyến hàng đầu tại Việt Nam</div>
</div>
<!--end List All Categories-->
<div class="info_header cf">
    <div>
        <a href="/chuyen-muc/quy-trinh-giao-hang.aspx"><span class="delivery"></span>Giao hàng
            toàn quốc</a></div>
    <div>
        <a href="/chuyen-muc/chinh-sach-doi-tra-hang.aspx"><span class="return"></span>7 ngày
            trả hàng</a></div>
    <div>
        <a href="#"><span class="bestprice"></span>Giá tốt nhất</a></div>
    <div>
        <a href="chuyen-muc/huong-dan-thanh-toan.aspx"><span class="payment"></span>Thanh toán
            khi nhận hàng</a></div>
</div>
<!--Footer-->
<div id="footer" class="cf">
    <!--Social Network-->
    <div id="social_network">
        <asp:Repeater ID="Rpfacebook" runat="server">
            <ItemTemplate>
                <%# LoadOnline(Eval("ONLINE_TYPE"), Eval("ONLINE_DESC"), Eval("ONLINE_NICKNAME"))%>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <!--end Social Network-->
    <!--Info Footer-->
    <div id="info_footer" class="cf">
        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
    </div>
</div>
<div class="box_ct" id="menu_footer">
    <asp:Repeater ID="Rpmenufoot" runat="server">
        <ItemTemplate>
            <a href="<%#GetLink_Cat(Eval("Cat_Url"),Eval("Cat_Seo_Url")) %>">
                <%#Eval("CAT_NAME") %></a>
        </ItemTemplate>
    </asp:Repeater>
</div>
