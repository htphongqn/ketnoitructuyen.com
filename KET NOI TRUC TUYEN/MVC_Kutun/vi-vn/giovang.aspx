<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Giovang.aspx.cs" Inherits="MVC_Kutun.vi_vn.Giovang" %>

<%@ Register Src="../UIs/List-product-deal.ascx" TagName="List" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:List ID="List1" runat="server" />
</asp:Content>
