using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;
using System.Data;
using vpro.functions;

namespace MVC_Kutun.UIs
{
    public partial class header_search : System.Web.UI.UserControl
    {
        #region Decclare
        Cart_result cart = new Cart_result();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            getQuanCart();
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["keyword"]))
                {
                    txtsearch.Value = Utils.CStrDef(Request.QueryString["keyword"]).Replace("+", " ");
                }
            }

            
        }
        public void getQuanCart()
        {
            try
            {
                if (Session["news_guid"] != null)
                {
                    Guid _guid = (Guid)Session["news_guid"];
                    Lbquancart.Text = cart.Total_quantity(_guid).ToString();
                }
                else
                    Lbquancart.Text = "0";

            }
            catch (Exception ex)
            {

                clsVproErrorHandler.HandlerError(ex);
            }
        }
        protected void btnsearch_Click(object sender, EventArgs e)
        {
            Response.Redirect("/tim-kiem.aspx?page=0&keyword=" + txtsearch.Value.Replace(" ", "+"));
        }
    }
}