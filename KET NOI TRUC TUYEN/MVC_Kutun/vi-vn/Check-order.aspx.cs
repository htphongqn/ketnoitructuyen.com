using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;
using vpro.functions;
using System.Web.UI.HtmlControls;
using MVC_Kutun.Components;

namespace MVC_Kutun.vi_vn
{
    public partial class Check_order : System.Web.UI.Page
    {
        #region Declare
        Config cf = new Config();
        Order_now order = new Order_now();
        clsFormat fm = new clsFormat();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            var _configs = cf.Config_meta();

            if (_configs.ToList().Count > 0)
            {
                if (!string.IsNullOrEmpty(_configs.ToList()[0].CONFIG_FAVICON))
                    ltrFavicon.Text = "<link rel='shortcut icon' href='" + PathFiles.GetPathConfigs() + _configs.ToList()[0].CONFIG_FAVICON + "' />";
            }

            HtmlHead header = base.Header;
            HtmlMeta headerDes = new HtmlMeta();
            HtmlMeta headerKey = new HtmlMeta();
            headerDes.Name = "Description";
            headerKey.Name = "Keywords";

            header.Title = "Kiểm tra đơn hàng";
            if (!IsPostBack) div_order.Visible = false;
            
        }
        private void loadOrder()
        {
            var list = order.checkOrder(txtcode.Value.Trim(), txtemail.Value.Trim());
            if (list.Count > 0)
            {
                Rporder.DataSource = list;
                Rporder.DataBind();
                div_order.Visible = true;
                Lberror.Visible = false;
            }
            else
            {
                div_order.Visible = false;
                Lberror.Visible = true;
                Lberror.Text = "Mã đơn hàng hoặc email không chính xác";
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            loadOrder();
        }
        public string getDate(object date)
        {
            return string.Format("{0:dd/MM/yyyy}", date);
        }
        public string getMoney(object money)
        {
            return fm.FormatMoney(money);
        }
        public string getOrderStatus(object obj_status)
        {
            switch (Utils.CIntDef(obj_status))
            {
                case 0:
                    return "<font color='#FF0000'>Chưa xử lý</font>";
                case 1:
                    return "<font color='#0c5cd4'>Liên hệ khách hàng</font>";
                case 2:
                    return "<font color='#0c5cd4'>Giao hàng</font>";
                case 3:
                    return "<font color='#529214'>Thành công</font>";
                case 4:
                    return "<font color='#c4670c'>Thất bại</font>";
                default:
                    return "Chưa xử lý";
            }
        }
    }
}