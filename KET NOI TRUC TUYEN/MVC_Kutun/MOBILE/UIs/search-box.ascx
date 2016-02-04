<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="search-box.ascx.cs"
    Inherits="MVC_Kutun.MOBILE.UIs.search_box" %>
<div id="search_form">
    <input type="text" name="txtsearch" id="txtsearch" class="input_Search" onblur="if (this.value=='') this.value='Từ khóa tìm kiếm';"
        onfocus="if (this.value=='Từ khóa tìm kiếm') this.value='';" value="Từ khóa tìm kiếm"
        onkeypress="if(event.which || event.keyCode || event.charCode){if ((event.charCode == 13) || (event.which == 13) || (event.keyCode == 13)) {document.getElementById('vi7_lbtnSearch').click();return false;}} else {return true}; "
        runat="server">
    <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" class="search_btn" OnClick="btnSearch_Click" />
</div>
