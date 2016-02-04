<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="brand.aspx.cs"
    Inherits="vpro.eshop.cpanel.page.brand" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Thêm nhãn hiệu | vpro.eshop</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="icon_function_parent">
        <div class="icon_function_Child" id="dvDelete" runat="server">
            <asp:LinkButton ID="lbtDelete" runat="server" OnClick="lbtDelete_Click" OnClientClick="return confirm('Bạn có chắc chắn xóa không?');"
                CausesValidation="false">
                <img src="../Images/ICON_DELETE.jpg" width="30" height="30" style="border: 0px" /><div>
                    Xóa</div>
            </asp:LinkButton>
        </div>
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
        <div class="icon_function_Child">
            <a href="#" onclick="javascript:document.location.reload(true);">
                <img src="../Images/ICON_UPDATE.jpg" width="30" height="30" style="border: 0px" /><div>
                    Cập nhật</div>
            </a>
        </div>
        <div class="icon_function_Child">
            <a href="contact_list.aspx">
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
                <td height="5" colspan="3" align="left">
                </td>
            </tr>
            <tr>
                <th valign="top" class="left">
                    Tên nhãn hiệu:
                </th>
                <td>
                    <input type="text" name="txtName" id="txtName" runat="server" style="width: 500px;"
                        readonly="readonly" />
                </td>
            </tr>
            <tr id="trBrandImg" runat="server">
                <th valign="top" class="left">
                    Hình ảnh
                </th>
                <td>
                    <input id="fileImage3" type="file" name="fileImage3" size="50" runat="server" style="width: 500px;" />
                </td>
            </tr>
            <tr id="trImage" runat="server">
                <th valign="top" class="left">
                    <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="../images/delete_icon.gif"
                        BorderWidth="0" Width="13px" ToolTip="Xóa hình chi tiết này" OnClick="btnDelete3_Click"
                        Style="height: 11px"></asp:ImageButton>
                </th>
                <td>
                    <asp:HyperLink runat="server" ID="hplImage" Target="_blank"></asp:HyperLink><br />
                    <img id="Image" runat="server" alt="" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
