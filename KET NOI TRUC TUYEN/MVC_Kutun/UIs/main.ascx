<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="main.ascx.cs" Inherits="MVC_Kutun.UIs.main" %>
<%@ Register Src="proHighlights.ascx" TagName="proHighlights" TagPrefix="uc1" %>
<!--Tab Products 01-->
<div class="box" id="div_banchay">
    <uc1:proHighlights ID="proHighlights1" runat="server" />
</div>
<!--End Tab Products 01-->
<asp:HiddenField ID="Hdcountcate" runat="server" ClientIDMode="Static" />
<div id="ajaxmain">
    <div id="loadingmain">
    </div>
</div>
<!--Category Home-->
<script src="../vi-vn/Ajax/Ajax-scroll.js" type="text/javascript"></script>