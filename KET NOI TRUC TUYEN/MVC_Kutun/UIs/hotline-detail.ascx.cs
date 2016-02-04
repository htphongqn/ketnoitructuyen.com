using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;

namespace MVC_Kutun.UIs
{
    public partial class hotline_detail : System.Web.UI.UserControl
    {
        Propertity per = new Propertity();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Loadhotline();
        }
        #region Hotline
        public void Loadhotline()
        {
            var list = per.Load_hotline().Take(1).ToList();
            if (list.Count > 0)
            {
                Rphotline.DataSource = list;
                Rphotline.DataBind();
            }
        }
        #endregion
    }
}