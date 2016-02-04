using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using vpro.functions;
using System.Data;
using vpro.eshop.cpanel.ucControls;
using System.IO;
using System.Web.UI.HtmlControls;

namespace vpro.eshop.cpanel.page
{
    public partial class brand : System.Web.UI.Page
    {
        #region Declare

        private int m_news_id = 0;
        eshopdbDataContext DB = new eshopdbDataContext();

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}