using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;
using MVC_Kutun.Components;

namespace MVC_Kutun.UIs
{
    public partial class Register_email : System.Web.UI.UserControl
    {
        Controller.Register_email rg = new Controller.Register_email();
        Config cf = new Config();
        SendMail semail = new SendMail();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
       
        protected void lbregisemail_Click(object sender, EventArgs e)
        {
            string email = txtemail.Value;
            if (rg.Add_email(email))
            {
                string _sMailBody = string.Empty;
                string _sEmailCC = string.Empty;
                _sMailBody += "Cám ơn bạn đã đặt đăng ký nhận tin từ email với chúng tôi.";
                var _ccMail = cf.Getemail(2);
                if (_ccMail.ToList().Count > 0)
                {
                    _sEmailCC = _ccMail.ToList()[0].EMAIL_TO;
                }
                semail.SendEmailSMTP("Thông báo: Bạn đã đăng ký nhận tin thành công", email, _sEmailCC, "", _sMailBody, true, false);
                Lberrors.Text = "Đăng ký thành công";
                txtemail.Value = "";
            }
            else
                Lberrors.Text = "Email này đã được đăng ký";
        }

        protected void hplClose_Click(object sender, EventArgs e)
        {
            mp1.Hide();
        }
    }
}