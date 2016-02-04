using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;
using vpro.functions;

namespace MVC_Kutun.UIs
{
    public partial class left_menu_news : System.Web.UI.UserControl
    {
        #region Declare
        Propertity per = new Propertity();
        Function fun = new Function();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Load_menu();

            }
        }
        #region Loaddata
        private void Load_menu()
        {
            Rpmenu_news.DataSource = per.Load_danhmuc_position(0, 2);
            Rpmenu_news.DataBind();
        }
        protected IQueryable Load_Menu2(object cat_parent_id)
        {
            try
            {
                return per.Menu2(cat_parent_id);
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return null;
            }

        }
        #endregion
        #region function
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