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
    public partial class footer : System.Web.UI.UserControl
    {
        #region Declare
        Config cf = new Config();
        Propertity per = new Propertity();
        Function fun = new Function();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Show_File_HTML();
                Loadmenu(3, ref Rpmenufoot);
                Loadface();
            }
        }
        private void Show_File_HTML()
        {
            Literal1.Text = cf.Show_File_HTML("footer-vi.htm", "/Data/footer/");
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
        #region Loadmenu
        public void Loadmenu(int pos, ref Repeater rp)
        {
            rp.DataSource = per.Loadmenu_footer(pos);
            rp.DataBind();
        }
        public IQueryable Load_caterank2(object catid)
        {
            return per.Menu2(catid);
        }
        #endregion
        #region function
        public string GetLink_Cat(object Cat_Url, object Cat_Seo_Url)
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


        public string GetLink(object News_Url, object News_Seo_Url, object cat_seo)
        {
            try
            {
                return fun.Getlink_News(News_Url, News_Seo_Url, cat_seo);
            }
            catch (Exception ex)
            {
                vpro.functions.clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }

        #endregion
    }
}