﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="order.aspx.cs" Inherits="vpro.eshop.cpanel.page.order" %>

<%@ Register Src="../Calendar/pickerAndCalendar.ascx" TagName="pickerAndCalendar"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Thông tin liên hệ | vpro.eshop</title>
    <link href="../Calendar/calendarStyle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="icon_function_parent">
        <%--			<div class="icon_function_Child">
		<asp:LinkButton ID="lbtHelp" runat="server">
				<img src="../Images/ICON_Help.jpg" width="30" height="30" style="border: 0px" /><div>
					Trợ giúp</div>
			</asp:LinkButton>
		</div>--%>
        <div class="icon_function_Child">
            <asp:LinkButton ID="lbtSave" runat="server" OnClick="lbtSave_Click"><img src="../Images/ICON_SAVE.jpg" width="30" height="30" style="border: 0px" /><div>
					Lưu</div></asp:LinkButton>
        </div>
        <div class="icon_function_Child" id="dvDelete" runat="server">
            <asp:LinkButton ID="lbtDelete" runat="server" OnClick="lbtDelete_Click" OnClientClick="return confirm('Bạn có chắc chắn xóa không?');"
                CausesValidation="false">
				<img src="../Images/ICON_DELETE.jpg" width="30" height="30" style="border: 0px" /><div>
					Xóa</div>
            </asp:LinkButton>
        </div>
        <div class="icon_function_Child">
            <a href="#" onclick="javascript:document.location.reload(true);">
                <img src="../Images/ICON_UPDATE.jpg" width="30" height="30" style="border: 0px" /><div>
                    Cập nhật</div>
            </a>
        </div>
        <div class="icon_function_Child">
            <a href="order_list.aspx">
                <img src="../Images/ICON_RETURN.jpg" width="30" height="30" style="border: 0px" />
                <div>
                    Quay lại</div>
            </a>
        </div>
        <div class="icon_function_Child">
            <asp:LinkButton ID="Lbprint" runat="server" OnClick="Lbprint_Click">
				<img src="../Images/print_icon.png" width="30" height="30" style="border: 0px" /><div>
					In</div>
            </asp:LinkButton>
        </div>
    </div>
    <!--icon_function_parent-->
    <div id="field">
        <table width="auto" border="0">
            <tr>
                <td height="5" colspan="3" align="left">
                </td>
            </tr>
            <tr>
                <td height="18" align="left" style="border-bottom: #e3e3e3 1px  solid;" class="general"
                    colspan="2">
                    Thông tin đơn hàng
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Ngày đặt hàng
                </th>
                <td>
                    <input type="text" name="txtOrderDate" id="txtOrderDate" runat="server" style="width: 500px;"
                        readonly="readonly" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Mã đơn hàng
                </th>
                <td>
                    <input type="text" name="txtOrderCode" id="txtOrderCode" runat="server" style="width: 500px;"
                        readonly="readonly" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Trạng thái
                </th>
                <td>
                    <asp:DropDownList ID="ddlStatus" runat="server" Width="500px">
                        <asp:ListItem Value="0" Text="Chưa xử lý"></asp:ListItem>
                        <asp:ListItem Value="1" Text="Đang giao dịch"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Giao hàng"></asp:ListItem>
                        <asp:ListItem Value="3" Text="Thành công"></asp:ListItem>
                        <asp:ListItem Value="4" Text="Thất bại"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Ghi chú
                </th>
                <td>
                    <textarea id="txtOrderDesc" runat="server" style="width: 500px;"></textarea>
                </td>
            </tr>
            <tr>
                <td height="5" colspan="3" align="left">
                </td>
            </tr>
            <tr>
                <td height="18" align="left" style="border-bottom: #e3e3e3 1px  solid;" class="general"
                    colspan="2">
                    Thông tin người mua hàng
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Tên
                </th>
                <td>
                    <input type="text" name="txtName" id="txtName" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Email
                </th>
                <td>
                    <input type="text" name="txtEmail" id="txtEmail" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Địa chỉ
                </th>
                <td>
                    <input type="text" name="txtAddress" id="txtAddress" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Điện thoại
                </th>
                <td>
                    <input type="text" name="txtPhone" id="txtPhone" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Ngày giao hàng
                </th>
                <td>
                    <uc1:pickerAndCalendar ID="ucDate" runat="server" />
                </td>
            </tr>
            <tr>
                <td height="5" colspan="2" align="left">
                </td>
            </tr>
            <%--<tr>
				<td height="18" align="left" style="border-bottom: #e3e3e3 1px  solid;" class="general"
					colspan="2">
					Thông tin người nhận hàng
				</td>
			</tr>
			<tr>
				<th valign="top" class="left">
					Tên
				</th>
				<td>
					<input type="text" name="txtReName" id="txtReName" runat="server" style="width: 500px;"
						 />
				</td>
			</tr>
			<tr>
				<th valign="top" class="left">
					Email
				</th>
				<td>
					<input type="text" name="txtReEmail" id="txtReEmail" runat="server" style="width: 500px;"
						 />
				</td>
			</tr>
			<tr>
				<th valign="top" class="left">
					Địa chỉ
				</th>
				<td>
					<input type="text" name="txtReAddress" id="txtReAddress" runat="server" style="width: 500px;"
						 />
				</td>
			</tr>
			<tr>
				<th valign="top" class="left">
					Điện thoại
				</th>
				<td>
					<input type="text" name="txtRePhone" id="txtRePhone" runat="server" style="width: 500px;"
						 />
				</td>
			</tr>
			<tr>
				<td height="5" colspan="2" align="left">
				</td>
			</tr>--%>
            <tr>
                <td height="18" align="left" style="border-bottom: #e3e3e3 1px  solid;" class="general"
                    colspan="2">
                    Danh sách mặt hàng
                </td>
            </tr>
            <tr>
                <td colspan="2" align="left">
                    <asp:DataGrid ID="GridItemList" CellPadding="0" runat="server" AutoGenerateColumns="False"
                        Width="100%" DataKeyField="ITEM_ID" CssClass="tdGridTable" SelectedIndex="0"
                        PagerStyle-Mode="NumericPages" PagerStyle-HorizontalAlign="Right" AllowPaging="false"
                        PageSize="20" PagerStyle-CssClass="PageClass" AllowSorting="true" OnPageIndexChanged="GridItemList_PageIndexChanged"
                        OnSortCommand="GridItemList_SortCommand" GridLines="None">
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
                            <asp:TemplateColumn HeaderText="Sản phẩm" HeaderStyle-Width="25%" ItemStyle-Wrap="False"
                                HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False"
                                SortExpression="NEWS_TITLE">
                                <ItemTemplate>
                                    <%# GetNewsTitle(Eval("NEWS_TITLE"), Eval("ITEM_FIELD1"),Eval("ITEM_FIELD2"))%>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="25%"></HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="tdGridRow"></ItemStyle>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Đơn giá" HeaderStyle-Width="25%" ItemStyle-Wrap="False"
                                HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False"
                                SortExpression="ITEM_PRICE">
                                <ItemTemplate>
                                    <%# GetMoney(DataBinder.Eval(Container.DataItem, "ITEM_PRICE"))%>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="25%"></HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="tdGridRow" HorizontalAlign="Center"></ItemStyle>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Số lượng" HeaderStyle-Width="24%" ItemStyle-Wrap="False"
                                HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False"
                                SortExpression="ITEM_QUANTITY">
                                <ItemTemplate>
                                    <input type="hidden" id="hdValue" runat="server" value='<%# Eval("ITEM_ID") %>' />
                                    <%#Eval("ITEM_QUANTITY")%>
                                  <%--  <asp:DropDownList ID="drSoLuong" runat="server" AutoPostBack="True" OnSelectedIndexChanged="drSoLuong_SelectedIndexChanged">
                                        <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                                        <asp:ListItem Value="2">2</asp:ListItem>
                                        <asp:ListItem Value="3">3</asp:ListItem>
                                        <asp:ListItem Value="4">4</asp:ListItem>
                                        <asp:ListItem Value="5">5</asp:ListItem>
                                        <asp:ListItem Value="6">6</asp:ListItem>
                                        <asp:ListItem Value="7">7</asp:ListItem>
                                        <asp:ListItem Value="8">8</asp:ListItem>
                                        <asp:ListItem Value="9">9</asp:ListItem>
                                        <asp:ListItem Value="10">10</asp:ListItem>
                                    </asp:DropDownList>--%>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="24%" HorizontalAlign="Left">
                                </HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="tdGridRow" HorizontalAlign="Center"></ItemStyle>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Thành tiền" HeaderStyle-Width="25%" ItemStyle-Wrap="true"
                                HeaderStyle-CssClass="tdGridHeader" ItemStyle-CssClass="tdGridRow" HeaderStyle-Wrap="False"
                                SortExpression="ITEM_SUBTOTAL">
                                <ItemTemplate>
                                    <%# GetMoney(DataBinder.Eval(Container.DataItem, "ITEM_SUBTOTAL"))%>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" CssClass="tdGridHeader" Width="25%" HorizontalAlign="Left">
                                </HeaderStyle>
                                <ItemStyle Wrap="true" CssClass="tdGridRow" HorizontalAlign="Right"></ItemStyle>
                            </asp:TemplateColumn>
                        </Columns>
                        <PagerStyle Mode="NumericPages" HorizontalAlign="Right"></PagerStyle>
                    </asp:DataGrid>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left" style="text-align: right;" colspan="2">
                    Giá giảm :
                    <asp:TextBox ID="txtpricegiam" runat="server" AutoPostBack="true" Width="100" 
                        Text="0" ontextchanged="txtpricegiam_TextChanged"></asp:TextBox>
                </th>
            </tr>
            <tr>
                <th valign="top" class="left" style="text-align: right;" colspan="2">
                    Phí vận chuyển :
                    <asp:TextBox ID="Txtchiphi" runat="server" OnTextChanged="Txtchiphi_TextChanged"
                        AutoPostBack="true" Width="100"></asp:TextBox>
                </th>
            </tr>
            <tr>
                <th valign="top" class="left" style="text-align: right;" colspan="2">
                    <asp:Label ID="lblTotal_amount" runat="server"></asp:Label>
                </th>
            </tr>
            <tr>
                <td height="15" colspan="2" align="left">
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
