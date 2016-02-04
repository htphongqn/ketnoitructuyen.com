using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using Controller;

namespace MVC_Kutun.UIs
{
    public partial class top_page : System.Web.UI.UserControl
    {
        #region Declare
        Propertity per = new Propertity();
        Function fun = new Function();
        Cart_result cart = new Cart_result();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Utils.CStrDef(Session["User_ID"])))
            {
                lbthanhvien.Text = Utils.CStrDef(Session["User_Name"]);
                div_login.Visible = false;
                div_logout.Visible = true;
            }
            else
            {
                div_login.Visible = true;
                div_logout.Visible = false;
            }
            if (!IsPostBack)
            {
                Load_Menu1();
            }
        }
        #region Logout

        protected void lbtnDangXuat_Click(object sender, EventArgs e)
        {
            try
            {
                //sau khi đăng xuất, xóa hết sản phẩm trong giỏ hàng của người đó
                LogOut();
                Session["Login_Email"] = null;
                Session["User_ID"] = null;
                //Response.Redirect(Request.RawUrl);
                Response.Redirect("/");
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }
        private void LogOut()
        {
            try
            {
                Session.Abandon();
                Response.Redirect("/");

            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }

        #endregion
        #region Load data

        protected void Load_Menu1()
        {
            try
            {
                Rpmenutop.DataSource = per.Loadmenu(1, 20, 1);
                Rpmenutop.DataBind();
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }

        }
       
        #endregion

        #region Function
        public string GetLink(object Cat_Url, object Cat_Seo_Url)
        {
            try
            {
                return fun.Getlink_Cat(Cat_Url, Cat_Seo_Url);
            }
            catch (Exception)
            {

                throw;
            }
        }
        #endregion
    }
}