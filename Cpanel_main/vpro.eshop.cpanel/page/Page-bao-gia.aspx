<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Page-bao-gia.aspx.cs" Inherits="vpro.eshop.cpanel.page.Page_bao_gia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Báo giá</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
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
            padding: 5px;
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
    <div id="icon_function_parent">
        <%--       <div class="icon_function_Child">
            <asp:LinkButton ID="lbtHelp" runat="server">
                <img src="../Images/ICON_Help.jpg" width="30" height="30" style="border: 0px" /><div>
                    Trợ giúp</div>
            </asp:LinkButton>
        </div>--%>
        <div class="icon_function_Child">
            <asp:LinkButton ID="lbtSaveNew" runat="server" OnClick="lbtSaveNew_Click" ValidationGroup="G10"><img src="../Images/ICON_ADD.jpg" width="30" height="30" border="0" style="border: 0px" /><div>
                    Lưu & Thêm mới</div></asp:LinkButton>
        </div>
        <div class="icon_function_Child">
            <asp:LinkButton ID="lbtSave" runat="server" OnClick="lbtSave_Click" ValidationGroup="G10"><img src="../Images/ICON_SAVE.jpg" width="30" height="30" style="border: 0px" /><div>
                    Lưu</div></asp:LinkButton>
        </div>
        <div class="icon_function_Child">
            <asp:HyperLink ID="Hyperprint" runat="server" Target="_blank"><img src="../Images/print_icon.png" width="30" height="30" style="border: 0px" /><div>
					In</div></asp:HyperLink>
        </div>
        <div class="icon_function_Child">
            <asp:HyperLink ID="Hyedit" runat="server"><img src="../Images/ICON_EDIT.jpg" width="30" height="30" style="border: 0px" /><div>
                            Chỉnh sửa sản phẩm báo giá </div></asp:HyperLink>
        </div>
        <div class="icon_function_Child">
            <a href="Page-bao-gia-list.aspx">
                <img src="../Images/ICON_RETURN.jpg" width="30" height="30" style="border: 0px" />
                <div>
                    Quay lại</div>
            </a>
        </div>
    </div>
    <!--icon_function_parent-->
    <div id="field">
        <table width="auto" border="0">
            <tr>
                <td height="18" align="left" style="border-bottom: #e3e3e3 1px  solid;" class="general"
                    colspan="2">
                    Thông tin chung
                </td>
            </tr>
            <tr>
                <td height="5" colspan="2" align="left">
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Tên khách hàng
                </th>
                <td>
                    <asp:TextBox ID="txtname" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Vui lòng nhập tên"
                        Text="Vui lòng nhập tên khách hàng" ControlToValidate="txtname" CssClass="errormes"
                        ValidationGroup="G10"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Email khách hàng
                </th>
                <td>
                    <asp:TextBox ID="txtemail" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Vui lòng nhập email khách hàng"
                        Text="Vui lòng nhập email khách hàng" ControlToValidate="txtemail" CssClass="errormes"
                        ValidationGroup="G10"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    HP
                </th>
                <td>
                    <asp:TextBox ID="txthp" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Phí vận chuyển
                </th>
                <td>
                    <input type="text" name="txtShip" id="txtShip" runat="server" style="width: 500px;"
                        onkeyup="this.value=formatNumeric(this.value);" onblur="this.value=formatNumeric(this.value);"
                        value="0" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Vui lòng nhập Ship"
                        Text="Vui lòng nhập Ship" ControlToValidate="txtShip" CssClass="errormes" ValidationGroup="G10"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Nhân viên báo giá
                </th>
                <td>
                    <asp:TextBox ID="txtNameEmploy" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Email
                </th>
                <td>
                    <asp:TextBox ID="txtEmailEmploy" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    HP
                </th>
                <td>
                    <asp:TextBox ID="txtHpEmploy" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr id="div_search" runat="server">
                <td colspan="2">
                    <ul style="list-style: none">
                        <li style="float: left; margin-right: 5px">
                            <input name="txtKeyword" type="text" id="txtKeyword" style="width: 300px" runat="server"
                                clientidmode="Static" />
                        </li>
                        <li style="float: left; margin-right: 5px">
                            <asp:DropDownList ID="ddlCategory" runat="server">
                            </asp:DropDownList>
                        </li>
                        <li style="float: left;" id="click">
                            <asp:LinkButton ID="lbtSearch" runat="server" OnClick="lbtSearch_Click">Tìm kiếm </asp:LinkButton>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr id="div_probaogia" runat="server">
                <th valign="top" class="left">
                    <span class="user">*</span>Sản phẩm báo giá
                </th>
                <td>
                    <asp:DataGrid ID="GridItemList" CellPadding="0" runat="server" AutoGenerateColumns="False"
                        Width="100%" DataKeyField="NEWS_ID" CssClass="tdGridTable" SelectedIndex="0"
                        PagerStyle-Mode="NumericPages" PagerStyle-HorizontalAlign="Right" AllowPaging="false"
                        PageSize="20" PagerStyle-CssClass="PageClass" AllowSorting="true" OnSortCommand="GridItemList_SortCommand"
                        GridLines="None" OnPageIndexChanged="GridItemList_PageIndexChanged" OnItemCommand="GridItemList_ItemCommand"
                        OnItemDataBound="GridItemList_ItemDataBound">
                        <AlternatingItemStyle BackColor="#f3f3f3" />
                        <Columns>
                            <asp:TemplateColumn HeaderText="STT" HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow"
                                HeaderStyle-Wrap="False">
                                <HeaderStyle Width="1%"></HeaderStyle>
                                <ItemTemplate>
                                    <asp:Label ID="lblSTT" runat="server" EnableViewState="False" Text='<%# getOrder() %>'>
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" CssClass="tdGridRow"></ItemStyle>
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
                            <asp:TemplateColumn HeaderText="SL" HeaderStyle-Width="91%" ItemStyle-Wrap="False"
                                HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtquantity" runat="server" Text='<%#Eval("BGD_QUANTITY") %>' Width="80px"></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="1%"></HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="tdGridRow"></ItemStyle>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="ĐVT" HeaderStyle-Width="91%" ItemStyle-Wrap="False"
                                HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtUnit" runat="server" Text='<%#Eval("BGD_UNIT") %>' Width="80px"></asp:TextBox>
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
                                HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtprice" runat="server" Text='<%#parelongMoney(Eval("BGD_PRICE")) %>' Width="120px"></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="1%"></HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="tdGridRow"></ItemStyle>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Chiếc khấu" HeaderStyle-Width="91%" ItemStyle-Wrap="False"
                                HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtChieckhau" runat="server" Text='<%#Eval("BGD_CHIECKHAU") %>'
                                        Width="80px"></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="1%"></HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="tdGridRow"></ItemStyle>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Ẩn/hiện" HeaderStyle-Width="91%" ItemStyle-Wrap="False"
                                HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False">
                                <ItemTemplate>
                                    <asp:CheckBox ID="Checkactive" runat="server" Checked='<%#setCheckAcive(Eval("BGD_STATUS_DESC")) %>' />
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="1%"></HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="tdGridRow"></ItemStyle>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Xóa">
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="1%"></HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="tdGridRow" HorizontalAlign="Center"></ItemStyle>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkbtnDel" runat="server" CommandName="Delete">
                                <img src="../images/delete_icon.gif" title="Xóa" border="0">
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                        <PagerStyle Mode="NumericPages" HorizontalAlign="Right"></PagerStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
