using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;

namespace MVC_Kutun.MOBILE.vi_vn
{
    public partial class User_manager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int _iUserID = Utils.CIntDef(Session["USER_ID"]);
                if (_iUserID == 0) Response.Redirect("/");
            Lbname.Text = Utils.CStrDef(Session["User_Name"]);
        }

        protected void Lblogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("/");
        }
    }
}