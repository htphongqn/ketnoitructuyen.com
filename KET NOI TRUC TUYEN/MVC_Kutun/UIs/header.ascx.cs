using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using Controller;
using System.Data;

namespace MVC_Kutun.UIs
{
    public partial class header : System.Web.UI.UserControl
    {
        #region Decclare
        Propertity per = new Propertity();
        Function fun = new Function();
        List_product list_pro = new List_product();
        Config cf = new Config();
        string _cat_seo_url = "";
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            _cat_seo_url = Request.QueryString["purl"];
            if (!IsPostBack) load_logo();
        }
        protected void load_logo()
        {
            var _logoSlogan = per.Load_logo_or_sologan("1", 1);
            if (_logoSlogan.ToList().Count > 0)
            {
                Rplogo.DataSource = _logoSlogan;
                Rplogo.DataBind();
            }
        }
        public string Getbanner(object Banner_type, object banner_field, object Banner_ID, object Banner_Image)
        {
            string title = list_pro.Loadtitle(_cat_seo_url);
            var _configs = cf.Config_meta();

            if (_configs != null && _configs.ToList().Count > 0)
            {
                if (title.Length == 0)
                    title =  _configs.ToList()[0].CONFIG_TITLE;
            }
            
            string s = "";
            if (Utils.CIntDef(Session["home"]) == 0)
                s += "<h1>";
            s += fun.Getbanner(Banner_type, banner_field, Banner_ID, Banner_Image, title);
            if (Utils.CIntDef(Session["home"]) == 0)
                s += "</h1>";
            return s;
        }
    }
}