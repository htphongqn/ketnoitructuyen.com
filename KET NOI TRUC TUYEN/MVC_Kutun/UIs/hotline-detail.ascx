<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="hotline-detail.ascx.cs"
    Inherits="MVC_Kutun.UIs.hotline_detail" %>
<asp:Repeater ID="Rphotline" runat="server">
    <ItemTemplate>
        <%# Eval("ONLINE_DESC")%>
    </ItemTemplate>
</asp:Repeater>
