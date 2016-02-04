using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using Controller;

namespace MVC_Kutun.MOBILE.UIs
{
    public partial class header : System.Web.UI.UserControl
    {
        Controller.Cart_result cart = new Cart_result();
        protected void Page_Load(object sender, EventArgs e)
        {

           
        }
        public int totalCart()
        {
            if (Session["news_guid"] != null)
            {
                Guid _guid = (Guid)Session["news_guid"];
                return cart.Total_quantity(_guid);
            }
            Guid _guidnews = System.Guid.NewGuid();
            Session["news_guid"] = _guidnews;
            return 0;
        }
    }
}