<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="List-product-deal.ascx.cs"
    Inherits="MVC_Kutun.UIs.List_product_deal" %>
<script type="text/javascript">
    $(function () {
        // duyệt toàn bộ các div có class là smart_deal 
        $(".smart_deal").each(function () {
            CountDown($(this).attr('id'));
        });
    });

    function CountDown(id) {
        $id = id.replace('smart_deal_', '');
        $totalSecond = $("#deal_timeleft_" + $id).attr('curtime');
        //alert($totalSecond);
        $totalMin = $totalSecond / 60;
        $hour = parseInt($totalMin / 60);
        $min = parseInt($totalMin % 60);
        $second = parseInt($totalSecond - ($hour * 3600) - ($min * 60));

        $("#deal_timeleft_" + $id).attr('curtime', --$totalSecond);
        // GAN THOI GIAN VAO LABEL 

        $("#counterlist_" + $id).html($hour + ":" + $min + ":" + $second);
        $("#lbTimeID").html($hour + ":" + $min + ":" + $second);
        $(".hour_" + $id).html($hour);
        $(".minu_" + $id).html($min);
        $(".seco_" + $id).html($second);

        if ($totalSecond > -1) {
            setTimeout("CountDown('" + $id + "')", 1000);

        }
    }
</script>

<div class="path"> <a href="/">Trang chủ</a> » Giờ vàng giá sốc </div>
<!--Right Col-->
<div class="box">
  <div class="box_Tab_main">
    <h1> Giờ vàng giá sốc</h1>
  </div>
  <div id="list_deal_products">
    <ul>
      <asp:Repeater ID="Rpproduct" runat="server">
        <ItemTemplate>
          <li class="product">
            <!--Start Product-->
            <div class="product_inner">
              <div class="boxgrid fl"> <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"></a><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"
                                        class="img_deal_P"> <img alt=" <%#Eval("NEWS_TITLE") %>" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" /></a>
                <!--Box Caption-->
                <%--<div class="boxcaption trans">
                                        <div class="nolist cf">
                                            <%#Eval("NEWS_DESC") %>
                                        </div>
                                    </div>--%>
                <!--End Box Caption-->
              </div>
              <h3 class="product_name"> <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"> <%#Eval("NEWS_TITLE") %></a></h3>
              <del> <%#GetPrice2(Eval("News_Price1"), Eval("News_Price3"))%></del>
              <div class="price"><b> <%#GetPrice1(Eval("News_Price1"), Eval("News_Price3"))%></b></div>
              <%#getBuy(Eval("NEWS_ID"), Eval("NEWS_FIELD3"))%> <%#Getgiam(Eval("News_Price1"), Eval("News_Price3"))%>
              <div class="time_deal_P"> <span>
                <div class="smart_deal" id='<%# String.Format("smart_deal_{0}", Eval("NEWS_ID")) %>'>
                  <div class="deal_timeleft1" id='<%# String.Format("deal_timeleft_{0}", Eval("NEWS_ID")) %>'
                                                curtime="<%# GetTotalSecond(Eval("NEWS_FROM_HOUR"),Eval("NEWS_TO_HOUR"),Eval("NEWS_UPDATE")) %>">
                    <div id='<%# String.Format("counterlist_{0}", Eval("NEWS_ID")) %>'> </div>
                  </div>
                </div>
              </div>
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
