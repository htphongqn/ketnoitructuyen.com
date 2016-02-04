<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="menu_child.aspx.cs" Inherits="vpro.eshop.cpanel.page.menu_child" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Left menu | Vpro.Eshop </title>
    <script src="../Jquery/jquery.min.1.7.2.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="icon_function_parent">
        <div class="icon_function_Child">
            <asp:LinkButton ID="lbtSaveNew" runat="server" OnClick="lbtSaveNew_Click">
				<img src="../Images/ICON_ADD.jpg" width="30" height="30" style="border: 0px" /><div>
					Lưu và thêm mới</div>
            </asp:LinkButton>
        </div>
        <div class="icon_function_Child">
            <asp:LinkButton ID="lbtSave" runat="server" OnClick="lbtSave_Click"><img src="../Images/ICON_SAVE.jpg" width="30" height="30" style="border: 0px" /><div>
					Lưu</div></asp:LinkButton>
        </div>
    </div>
    <!--icon_function_parent-->
    <div id="field">
        <table width="auto" border="0">
            <tr>
                <td colspan="3" align="left">
                    <asp:Label CssClass="user" ID="lblError" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Chuyên mục cấp cha
                </th>
                <td>
                    <asp:DropDownList ID="Drchuyenmuc" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Tên chuyên mục
                </th>
                <td>
                    <input type="text" name="Txtname" id="Txtname" runat="server" style="width: 500px;"
                        onkeyup="ParseText(this);" onblur="ParseText(this);" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Vui lòng nhập tên ngân hàng"
                        Text="Vui lòng nhập tên chuyên mục" ControlToValidate="Txtname" CssClass="errormes"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    <span class="user">*</span>Link
                </th>
                <td>
                    <input type="text" name="Txtlink" id="Txtlink" runat="server" style="width: 500px;"
                        onkeyup="ParseText(this);" onblur="ParseText(this);" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Vui lòng nhập link"
                        Text="Vui lòng nhập link" ControlToValidate="Txtlink" CssClass="errormes"></asp:RequiredFieldValidator>
                </td>
            </tr>
             <tr>
                <th valign="top" class="left">
                    Thứ tự
                </th>
                <td>
                    <input type="text" name="txtorder" id="txtorder" runat="server" style="width: 500px;"
                       value="1" />
                    
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
