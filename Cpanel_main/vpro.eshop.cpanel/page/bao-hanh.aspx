<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="bao-hanh.aspx.cs" Inherits="vpro.eshop.cpanel.page.bao_hanh" %>

<%@ Register Src="../Calendar/pickerAndCalendar.ascx" TagName="pickerAndCalendar"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Bảo hành</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Calendar/calendarStyle.css" rel="stylesheet" type="text/css" />
    <div id="icon_function_parent">
        <%--       <div class="icon_function_Child">
            <asp:LinkButton ID="lbtHelp" runat="server">
                <img src="../Images/ICON_Help.jpg" width="30" height="30" style="border: 0px" /><div>
                    Trợ giúp</div>
            </asp:LinkButton>
        </div>--%>
        <div class="icon_function_Child">
            <asp:LinkButton ID="lbtSaveNew" runat="server" OnClick="lbtSaveNew_Click" ValidationGroup="G10"><img src="../Images/ICON_SAVE.jpg" width="30" height="30" style="border: 0px" /><div>
                    Lưu & Thêm mới</div></asp:LinkButton>
        </div>
        <div class="icon_function_Child">
            <asp:LinkButton ID="lbtSave" runat="server" OnClick="lbtSave_Click" ValidationGroup="G10"><img src="../Images/ICON_SAVE.jpg" width="30" height="30" style="border: 0px" /><div>
                    Lưu</div></asp:LinkButton>
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
                    <span class="user">*</span>Mã sản phẩm
                </th>
                <td>
                    <asp:TextBox ID="txtcode" runat="server" AutoPostBack="true" OnTextChanged="txtcode_TextChanged"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Vui lòng nhập tên"
                        Text="Vui lòng nhập mã sản phẩm" ControlToValidate="txtcode" CssClass="errormes"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="Lberros" runat="server" Text="" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Tên sản phẩm
                </th>
                <td>
                    <asp:HyperLink ID="Hynews" runat="server" ForeColor="Blue" Target="_blank"></asp:HyperLink>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Số phiếu
                </th>
                <td>
                    <input type="text" name="txtsophieu" id="txtsophieu" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Khách hàng
                </th>
                <td>
                    <input type="text" name="txtnamekhachhang" id="txtnamekhachhang" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Địa chỉ
                </th>
                <td>
                    <input type="text" name="txtadd" id="txtadd" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Số điện thoại
                </th>
                <td>
                    <input type="text" name="txtphone" id="txtphone" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Email
                </th>
                <td>
                    <input type="text" name="txtemail" id="txtemail" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Số hóa đơn
                </th>
                <td>
                    <input type="text" name="txtsohoadon" id="txtsohoadon" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Seri
                </th>
                <td>
                    <input type="text" name="txtseri" id="txtseri" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Ngày hẹn trả
                </th>
                <td>
                    <uc1:pickerAndCalendar ID="pickdelivery" runat="server" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Tình trạng nhận hàng
                </th>
                <td>
                    <textarea id="txttinhtrang" runat="server" style="width: 500px;"></textarea>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Ghi chú nhân viên bảo hành
                </th>
                <td>
                    <textarea id="txtnotenhanvien" runat="server" style="width: 500px;"></textarea>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Ghi chú
                </th>
                <td>
                    <textarea id="txtnote" runat="server" style="width: 500px;"></textarea>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Trạng thái bảo hành
                </th>
                <td>
                    <asp:RadioButtonList ID="Rdstatus" runat="server" RepeatColumns="3">
                        <asp:ListItem Value="0" Selected="True">Chưa xử lý</asp:ListItem>
                        <asp:ListItem Value="1" >Đang xử lý</asp:ListItem>
                        <asp:ListItem Value="2">Đã trả KH</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
