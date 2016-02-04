<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="cart.ascx.cs" Inherits="MVC_Kutun.UIs.cart" %>
<div class="tt_payment_step">
    Thông tin đơn hàng
</div>
<div class="order_sum">
    <table width="100%">
        <tbody>
            <tr>
                <th class="left_align">
                    Sản phẩm
                </th>
                <th class="qty">
                    Số lượng
                </th>
                <th class="right_align">
                    Giá
                </th>
            </tr>
        </tbody>
    </table>
    <div class="order_scrollable">
        <table class="order_scroll_table" width="100%">
            <tbody>
                <asp:Repeater ID="Rpgiohang" runat="server">
                    <ItemTemplate>
                        <tr>
                            <asp:HiddenField ID="Hdnews_id" runat="server" Value='<%#Eval("NEWS_ID") %>' />
                            <td class="left_align">
                                <%# Eval("NEWS_TITLE") %>
                            </td>
                            <td class="qty">
                              <%--  <asp:DropDownList ID="Drquan" runat="server" AutoPostBack="True" OnSelectedIndexChanged="drSoLuong_SelectedIndexChanged">
                                    <asp:ListItem Selected="True" Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                    <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                    <asp:ListItem Text="13" Value="13"></asp:ListItem>
                                    <asp:ListItem Text="14" Value="14"></asp:ListItem>
                                    <asp:ListItem Text="15" Value="15"></asp:ListItem>
                                    <asp:ListItem Text="16" Value="16"></asp:ListItem>
                                    <asp:ListItem Text="17" Value="17"></asp:ListItem>
                                    <asp:ListItem Text="18" Value="18"></asp:ListItem>
                                    <asp:ListItem Text="19" Value="19"></asp:ListItem>
                                    <asp:ListItem Text="20" Value="20"></asp:ListItem>
                                </asp:DropDownList>--%>
                                <asp:TextBox ID="txtQuantity" runat="server" AutoPostBack="true" OnTextChanged="txtQuantity_TextChanged" onkeyup="this.value=formatNumeric(this.value);" onblur="this.value=formatNumeric(this.value);"  Width="35" Style="text-align: center; border: 1px solid;"></asp:TextBox>
                            </td>
                            <td class="right_align">
                                <%# String.Format("{0:0,0 VNĐ}", Eval("Basket_Price")).Replace(",",".")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
    <table class="total_item" width="100%">
        <tbody>
            <tr class="total_item">
                <td class="total">
                    Tổng tiền
                </td>
                <td class="total right_align" colspan="2">
                    <asp:Label ID="lbtotalmoney" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr class="total_item" id="div_ship" runat="server">
                <td class="total">
                    Phí vận chuyển
                </td>
                <td class="total right_align" colspan="2">
                    <asp:Label ID="Lbship" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr class="total_item">
                <td class="total">
                    Thành tiền
                </td>
                <td class="total right_align" colspan="2">
                    <asp:Label ID="Lbtotal" runat="server" Text=""></asp:Label>
                </td>
            </tr>
        </tbody>
    </table>
</div>
<script>
    function formatNumeric(num) {
        num = repStr(num.toString());
        if (isNaN(num)) {
            num = "1";
        }
        return (num);
    }
    function repStr(str) {
        var strResult = "";
        for (i = 0; i < str.length; i++)
            if ((str.charAt(i) != "$") && (str.charAt(i) != ",")) {
                strResult = strResult + str.charAt(i)
            }
        return strResult;
    }
</script>
