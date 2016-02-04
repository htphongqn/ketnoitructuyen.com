using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;
using vpro.functions;

namespace Controller
{
    public class Historypayment
    {
        #region Decclare
        dbVuonRauVietDataContext db = new dbVuonRauVietDataContext();
        #endregion
        public List<ESHOP_ORDER> loadHispayment(int userid)
        {
            var list = db.ESHOP_ORDERs.Where(n => n.CUSTOMER_ID == userid).ToList();
            return list;
        }
        #region Function
        public string getOrderStatus(object obj_status)
        {
            switch (Utils.CIntDef(obj_status))
            {
                case 0:
                    return "<font color='#FF0000'>Chưa xử lý</font>";
                case 1:
                    return "<font color='#0c5cd4'>Liên hệ khách hàng</font>";
                case 2:
                    return "<font color='#0c5cd4'>Giao hàng</font>";
                case 3:
                    return "<font color='#529214'>Thành công</font>";
                case 4:
                    return "<font color='#c4670c'>Thất bại</font>";
                default:
                    return "Chưa xử lý";
            }

        }
        public string getOrderPayment(object obj_payment)
        {
            switch (Utils.CIntDef(obj_payment))
            {
                case 1:
                    return "<font color='#0c5cd4'>Thu tiền tại cửa hàng</font>";
                case 2:
                    return "<font color='#529214'>Thu tiền tại nhà</font>";
                default:
                    return "Khác";
            }
        }

        public string GetMoney(object obj_value)
        {
            return string.Format("{0:#,#} đ", obj_value).Replace(',', '.');
        }
        public string getPublishDate(object obj_date)
        {
            return string.Format("{0:dd-MM-yyyy}", obj_date);
        }
        #endregion
    }
}
