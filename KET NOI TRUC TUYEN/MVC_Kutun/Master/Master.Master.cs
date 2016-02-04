using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;

namespace MVC_Kutun.Master
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
                form1.Action = Request.RawUrl;
        }
        private bool checktype()
        {
            int _type = Utils.CIntDef(Request["type"]);
            if (_type != 0)
                return true;
            return false;
        }
        public string setID()
        {
            if (checktype())
                return "sticky_navigation";
            return "top_main";
        }
    }
}