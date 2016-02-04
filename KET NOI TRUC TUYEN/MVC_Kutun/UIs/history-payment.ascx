<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="History-payment.ascx.cs"
    Inherits="MVC_Kutun.UIs.History_payment" %>
<table style="width: 100%;" border="1">
    <tr>
        <td>
            &nbsp; Mã
        </td>
        <td>
            &nbsp; Khách hàng
        </td>
        <td>
            &nbsp; Điện thoại
        </td>
        <td>
            &nbsp; Địa chỉ
        </td>
        <td>
            &nbsp; Ngày đặt hàng
        </td>
        <td>
            &nbsp; Tổng tiền
        </td>
        <td>
            &nbsp; Ghi chú
        </td>
    </tr>
    <asp:Repeater ID="Rphistory" runat="server">
        <ItemTemplate>
            <tr style="text-align: center">
                <td>
                    <%# DataBinder.Eval(Container.DataItem, "ORDER_CODE")%>
                </td>
                <td>
                    <%# DataBinder.Eval(Container.DataItem, "ORDER_NAME")%>
                </td>
                <td>
                    <%# DataBinder.Eval(Container.DataItem, "ORDER_PHONE")%>
                </td>
                <td>
                    <%# DataBinder.Eval(Container.DataItem, "ORDER_ADDRESS")%>
                </td>
                <td>
                    <%# getPublishDate(DataBinder.Eval(Container.DataItem, "ORDER_PUBLISHDATE"))%>
                </td>
                <td>
                    <%# GetMoney(DataBinder.Eval(Container.DataItem, "ORDER_TOTAL_ALL"))%>
                </td>
                <td>
                    <%# DataBinder.Eval(Container.DataItem, "ORDER_FIELD1")%>
                </td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
</table>
