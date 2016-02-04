<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Page-bao-gia-detail.aspx.cs" Inherits="vpro.eshop.cpanel.page.Page_bao_gia_detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>DS Sản phẩm - tin tức | Vpro.Eshop</title>
    <script language="javascript">
				<!--
        function ToggleAll(e, action) {
            if (e.checked) {
                CheckAll();
            }
            else {
                ClearAll();
            }
        }

        function CheckAll() {
            var ml = document.forms[0];
            var len = ml.elements.length;
            for (var i = 1; i < len; i++) {
                var e = ml.elements[i];

                if (e.name.toString().indexOf("chkSelect") > 0)
                    e.checked = true;
            }
            ml.MainContent_GridItemList_toggleSelect.checked = true;
        }

        function ClearAll() {
            var ml = document.forms[0];
            var len = ml.elements.length;
            for (var i = 1; i < len; i++) {
                var e = ml.elements[i];
                if (e.name.toString().indexOf("chkSelect") > 0)
                    e.checked = false;
            }
            ml.MainContent_GridItemList_toggleSelect.checked = false;
        }
				    
				// -->
    </script>
    <script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
    <script>
        $(function () {
            $('.check_dongia').click(function () {
                var checkid = $(this).attr("data-value");
                if (this.checked) {
                    setSession(checkid, 1);
                }
                else {
                    setSession(checkid, 0);
                }
            });
        });
        function setSession(id, typecheck) {
            $.ajax({
                type: "POST",
                url: "Ajaxall.aspx/addCookiecheck",
                data: "{checkid:'" + id + "',typecheck:'" + typecheck + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (e) {

                }
            });
        }
    </script>
    <link href="../Complete/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" type="text/css" />
    <script src="../Complete/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>
    <style>
        .ui-autocomplete-category
        {
            font-weight: bold;
            padding: .2em .4em;
            margin: .8em 0 .2em;
            line-height: 1.5;
        }
        .ui-autocomplete
        {
            max-height: 500px;
            overflow: hidden;
        }
        .ui-menu .ui-menu-item
        {
            padding:5px
            }
    </style>
    <script>
        $.widget("custom.catcomplete", $.ui.autocomplete, {
            _create: function () {
                this._super();
                this.widget().menu("option", "items", "> :not(.ui-autocomplete-category)");
            },
            _renderMenu: function (ul, items) {
                var that = this,
        currentCategory = "";
                $.each(items, function (index, item) {
                    var li;
                    if (item.category != currentCategory) {
                        ul.append("<li class='ui-autocomplete-category'>" + item.category + "</li>");
                        currentCategory = item.category;
                    }
                    li = that._renderItemData(ul, item);
                    if (item.category) {
                        li.attr("aria-label", item.category + " : " + item.label);
                    }
                });
            }
        });
    </script>
    <script>
        $(function () {
            $('#txtKeyword').catcomplete({
                delay: 0,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        url: "../page/Ajaxcomplete.aspx/autocomplete",
                        data: "{'searchitem':'" + request.term + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            response($.map(result.d, function (el) {
                                return {
                                    label: el.title,
                                    category: el.catname
                                };
                            }));
                        }
                    });
                }

            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="icon_function_parent">
        <%-- <div class="icon_function_Child">
            <asp:LinkButton ID="lbtHelp" runat="server"> <img src="../Images/ICON_Help.jpg" width="30" height="30" style="border: 0px" /><div>
                    Trợ giúp</div></asp:LinkButton>
        </div>--%>
        <div class="icon_function_Child">
            <asp:LinkButton ID="lbtSave" runat="server" OnClick="lbtSave_Click"> <img src="../Images/ICON_SAVE.jpg" width="30" height="30" style="border: 0px" /><div>
                            Lưu</div></asp:LinkButton>
        </div>
        <div class="icon_function_Child">
            <asp:HyperLink ID="Hyperback" runat="server"><img src="../Images/ICON_RETURN.jpg" width="30" height="30" style="border: 0px" />
                <div>
                    Quay lại</div></asp:HyperLink>
        </div>
        <%-- <div class="icon_function_Child">
            <asp:HyperLink ID="Hyperaddnew" runat="server"><img src="../Images/ICON_ADD.jpg" width="30" height="30" border="0" style="border: 0px" /><div>
                    Thêm mới</div></asp:HyperLink>
        </div>--%>
        <%-- <div class="icon_function_Child" id="dvDelete" runat="server">
            <asp:LinkButton ID="lbtDelete" runat="server" OnClientClick="return confirm('Bạn có chắc chắn xóa không?');"
                CausesValidation="false" OnClick="lbtDelete_Click"> <img src="../Images/ICON_DELETE.jpg" width="30" height="30" style="border: 0px" /><div>
                    Xóa</div></asp:LinkButton>
        </div>--%>
        <%--<div class="icon_function_Child">
            <a href="news_list.aspx">
                <img src="../Images/ICON_UPDATE.jpg" width="30" height="30" style="border: 0px" /><div>
                    Cập nhật</div>
            </a>
        </div>--%>
        <%-- <div class="icon_function_Child">
            <asp:LinkButton ID="lbtnSendMail" runat="server" OnClientClick="return confirm('Bạn có chắc chắn gửi mail không?');"
                OnClick="lbtnSendMail_Click"><img src="../Images/send_mail.png" width="30" height="30" style="border: 0px" />             
                <div>
                    Gửi mail</div>
            </asp:LinkButton>
        </div>--%>
    </div>
    <!--icon_function_parent-->
    <div id="field">
        <table width="100%" border="0">
            <tr>
                <td height="5" colspan="3" align="left">
                </td>
            </tr>
            <tr>
                <th width="50" class="left">
                    Filter
                </th>
                <td width="200px;">
                    <input name="txtKeyword" type="text" id="txtKeyword" style="width: 300px" runat="server"
                        clientidmode="Static" />
                </td>
                <td width="200px;">
                    <asp:DropDownList ID="ddlCategory" runat="server">
                    </asp:DropDownList>
                </td>
                <td>
                    <div id="click">
                        <asp:LinkButton ID="lbtSearch" runat="server" OnClick="lbtSearch_Click">Tìm kiếm </asp:LinkButton>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="height: 10px;" colspan="3">
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:DataGrid ID="GridItemList" CellPadding="0" runat="server" AutoGenerateColumns="False"
                        Width="100%" DataKeyField="NEWS_ID" CssClass="tdGridTable" SelectedIndex="0"
                        PagerStyle-Mode="NumericPages" PagerStyle-HorizontalAlign="Right" AllowPaging="false"
                        PageSize="20" PagerStyle-CssClass="PageClass" AllowSorting="true" OnSortCommand="GridItemList_SortCommand"
                        GridLines="None" OnPageIndexChanged="GridItemList_PageIndexChanged">
                        <AlternatingItemStyle BackColor="#f3f3f3" />
                        <Columns>
                            <asp:TemplateColumn HeaderText="#" HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow"
                                HeaderStyle-Wrap="False">
                                <HeaderStyle Width="1%"></HeaderStyle>
                                <ItemTemplate>
                                    <asp:Label ID="lblSTT" runat="server" EnableViewState="False" Text='<%# getOrder() %>'>
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" CssClass="tdGridRow"></ItemStyle>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderStyle-Width="1%" ItemStyle-Wrap="False" HeaderStyle-CssClass="tdGridHeader"
                                ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False">
                                <HeaderTemplate>
                                    <input type="checkbox" id="toggleSelect" runat="server" onclick="javascript: ToggleAll(this,0);"
                                        style="border-top-style: none; border-right-style: none; border-left-style: none;
                                        border-bottom-style: none" name="toggleSign">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <input id="chkSelect" type="checkbox" name="chkSelect" runat="server" style="border-top-style: none;
                                        border-right-style: none; border-left-style: none; border-bottom-style: none"
                                        checked='<%#checkPro(DataBinder.Eval(Container.DataItem, "NEWS_ID")) %>' class="check_dongia"
                                        data-value='<%#DataBinder.Eval(Container.DataItem, "NEWS_ID") %>'>
                                    <asp:HiddenField ID="Hdnewsid" runat="server" Value='<%#DataBinder.Eval(Container.DataItem, "NEWS_ID") %>' />
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="1%"></HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="tdGridRow" HorizontalAlign="Center"></ItemStyle>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Tên sản phẩm" HeaderStyle-Width="91%" ItemStyle-Wrap="False"
                                HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False"
                                SortExpression="NEWS_TITLE">
                                <ItemTemplate>
                                    <a href='<%# getLink(DataBinder.Eval(Container.DataItem, "NEWS_ID")) %>'>
                                        <%#Eval("NEWS_TITLE")%>
                                    </a>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="1%"></HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="tdGridRow"></ItemStyle>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Nhà sản xuất" HeaderStyle-Width="91%" ItemStyle-Wrap="False"
                                HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False"
                                SortExpression="NEWS_TITLE">
                                <ItemTemplate>
                                    <%# getNameCate(Eval("UNIT_ID2"))%>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="1%"></HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="tdGridRow"></ItemStyle>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Đơn giá" HeaderStyle-Width="91%" ItemStyle-Wrap="False"
                                HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False"
                                SortExpression="NEWS_TYPE">
                                <ItemTemplate>
                                    <%# FormatMoney(DataBinder.Eval(Container.DataItem, "NEWS_PRICE1"))%>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="1%"></HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="tdGridRow"></ItemStyle>
                            </asp:TemplateColumn>
                        </Columns>
                        <PagerStyle Mode="NumericPages" HorizontalAlign="Right"></PagerStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
