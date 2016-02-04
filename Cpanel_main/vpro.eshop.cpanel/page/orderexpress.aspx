<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="orderexpress.aspx.cs" Inherits="vpro.eshop.cpanel.page.orderexpress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Tạo đơn hàng nhanh</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
                    <span class="user">*</span>Số lượng
                </th>
                <td>
                    <input type="text" name="txtquan" id="txtquan" runat="server" style="width: 500px;" value="1" />
                    
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Tên khách hàng
                </th>
                <td>
                    <input type="text" name="txtname" id="txtname" runat="server" style="width: 500px;" />
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
                    <span class="user">*</span>Địa chỉ
                </th>
                <td>
                    <input type="text" name="txtadd" id="txtadd" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Điện thoại
                </th>
                <td>
                    <input type="text" name="txtphone" id="txtphone" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Tỉnh/Thành phố
                </th>
                <td>
                    <asp:DropDownList ID="Drcity" runat="server" class="sl_form_web" AutoPostBack="True"
                        OnSelectedIndexChanged="Drcity_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Quận/Huyện:
                </th>
                <td>
                    <asp:DropDownList ID="Drdistric" runat="server" class="sl_form_web">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
