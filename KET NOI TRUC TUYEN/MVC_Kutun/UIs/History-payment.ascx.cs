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
    public partial class History_payment : System.Web.UI.UserControl
    {
        Historypayment his = new Historypayment();
        int _count=1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) Loadhist_pay();
        }
        #region Loaddata
        private void Loadhist_pay()
        {
            int _iUserID = Utils.CIntDef(Session["User_ID"]);
            Rphistory.DataSource = his.loadHispayment(_iUserID);
            Rphistory.DataBind();
        }
        #endregion
        #region function
        public int getOrder()
        {
            return _count++;
        }
        public string getOrderStatus(object obj_status)
        {
            return his.getOrderStatus(obj_status);
        }
        public string getOrderPayment(object obj_payment)
        {
            return his.getOrderPayment(obj_payment);
        }
        public string GetMoney(object obj_value)
        {
            return his.GetMoney(obj_value);
        }
        public string getPublishDate(object obj_date)
        {
            return his.getPublishDate(obj_date);
        }
        #endregion
    }
}