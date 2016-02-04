<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="List-thuonghieu.ascx.cs"
    Inherits="MVC_Kutun.UIs.List_thuonghieu" %>

<div class="path"> <a href="/">Trang chủ</a> » Thương hiệu </div>
<!--Brand-->
<div class="box">
  <div class="box_Tab_main">
    <h1> Thương hiệu</h1>
  </div>
  <div id="list_brand">
    <ul>
      <asp:Repeater ID="RplistThuonghieu" runat="server">
        <ItemTemplate>
          <li class="item_brand">
            <!--Start Product-->
            <div class="boxgrid"> <a href="<%# getLinkCat(Eval("CAT_URL"),Eval("CAT_SEO_URL")) %>"></a><a href="<%# getLinkCat(Eval("CAT_URL"),Eval("CAT_SEO_URL")) %>"
                                        class="img_brand"> <img alt=" <%#Eval("CAT_NAME") %>" src="<%# getImgCat(Eval("CAT_ID"),Eval("CAT_IMAGE1")) %>" /></a> </div>
            <!--end Start Product-->
          </li>
        </ItemTemplate>
      </asp:Repeater>
    </ul>
  </div>
</div>
<!--end Brand-->
