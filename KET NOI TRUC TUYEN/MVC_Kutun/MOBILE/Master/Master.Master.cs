using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using MVC_Kutun.Components;

namespace MVC_Kutun.MOBILE.Master
{
    public partial class Master : System.Web.UI.MasterPage
    {
        setCookieDevice setckdv = new setCookieDevice();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) form1.Action = Request.RawUrl;
            if (Check_type())
                div_slider.Visible = false;
        }
        private bool Check_type()
        {
            int _type = Utils.CIntDef(Request["type"]);
            return _type != 0 ? true : false;
        }

        protected void Lbdevice_Click(object sender, EventArgs e)
        {
            setckdv.Removecookie("itemmobile");
            Response.Redirect("/");
        }
    }
}