using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;
using vpro.functions;
using System.Data;
using System.Web.UI.HtmlControls;
using MVC_Kutun.Components;

namespace MVC_Kutun.vi_vn
{
    public partial class userinfo : System.Web.UI.Page
    {
        #region Declare
        Userinfo user = new Userinfo();
        Config cf = new Config();
        clsFormat fm = new clsFormat();
        int _iUserID = 0;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            _iUserID = Utils.CIntDef(Session["USER_ID"]);
            //if (_iUserID == 0) Response.Redirect("/");
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

            header.Title = "Thông tin cá nhân";
            if (!IsPostBack)
            {
                
                Loaduser_info();
            }
        }
        #region Area
      
        #endregion
        #region Loadinfo
        public void Loaduser_info()
        {
            var list = user.Loaduserinfo(_iUserID);
            if (list.Count > 0)
            {
                Lbemail.Text = list.First().CUSTOMER_EMAIL;
                Txtname.Text = list.First().CUSTOMER_FULLNAME;
                Txtphone.Text = list.First().CUSTOMER_PHONE1;
                pickbirth.returnDate = Utils.CDateDef(list[0].CUSTOMER_UPDATE, DateTime.Now);
                Rdsex.SelectedValue = list[0].CUSTOMER_FIELD3;
            }
        }
        #endregion
        #region Update user
        protected void Lblogins_Click(object sender, EventArgs e)
        {
            string name=Txtname.Text;
            string phone=Txtphone.Text;
            if (user.Updateuser(_iUserID, name, phone,Rdsex.SelectedValue,pickbirth.returnDate))
            {
                string strScript = "<script>";
                strScript += "alert(' Cập nhật thành công!');";
                strScript += "window.location='/thong-tin-ca-nhan.aspx';";
                strScript += "</script>";
                Page.RegisterClientScriptBlock("strScript", strScript);
            }
            else
            {
                string strScript = "<script>";
                strScript += "alert('Lỗi!');";
                strScript += "</script>";
                Page.RegisterClientScriptBlock("strScript", strScript);
            }
        }
        #endregion
        protected void Lbreset_Click(object sender, EventArgs e)
        {
            Response.Redirect("/");
        }
        
    }
}