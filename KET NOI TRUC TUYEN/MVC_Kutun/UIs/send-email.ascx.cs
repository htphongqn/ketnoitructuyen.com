using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;

namespace MVC_Kutun.UIs
{
    public partial class send_email : System.Web.UI.UserControl
    {
        Propertity per = new Propertity();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Loadface();
            }
        }
        #region Facebook
        public void Loadface()
        {
            var list = per.Load_face();
            if (list.Count > 0)
            {
                Rpfacebook.DataSource = list;
                Rpfacebook.DataBind();
            }
        }
        public string LoadOnline(object online_type, object ONLINE_DESC, object nick)
        {
            return per.LoadOnline(online_type, ONLINE_DESC, nick);
        }
        #endregion
    }
}