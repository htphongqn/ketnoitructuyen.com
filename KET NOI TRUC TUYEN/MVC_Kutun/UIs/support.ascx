<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="support.ascx.cs" Inherits="MVC_Kutun.UIs.support" %>
<span class="title_support"></span>
<div class="support_bg">
    <p class="optionSupport">
        <a href="/lien-he.html">Liên hệ với Ketnoitructuyen.com</a>
    </p>
    <div class="infoSupport">
        <span class="icoSupport"></span>
        <p class="hotLine">
            <asp:Repeater ID="Rphotline" runat="server">
                <ItemTemplate>
                    <span>
                        <%# Eval("ONLINE_DESC")%></span><br />
                </ItemTemplate>
            </asp:Repeater>
        </p>
        <p class="timeSupport">
            <strong>Thời gian làm việc:</strong></p>
        <p class="timeSupport">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thứ 2 - 7: từ 8h-18h</p>
        <p class="timeSupport">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chủ Nhật vui lòng gọi</p>
        <span class="icoMail"></span>
        <p class="mailSupport">
            <asp:HyperLink ID="Hpemail" runat="server"></asp:HyperLink>
        </p>
        <div class="yahoo">
            <asp:Repeater ID="Rphotro" runat="server">
                <ItemTemplate>
                    <%# Bind_Online(Eval("ONLINE_TYPE"), Eval("ONLINE_DESC"), Eval("ONLINE_NICKNAME"))%>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</div>
