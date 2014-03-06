using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ForexBox.Models
{
    public class ResetPasswordModel
    {
        public string UserName { get; set; }
        public string NewPassword { get; set; }
        public string NewPasswordRepeat { get; set; }

        public string GeneratedPassword { get; set; }

        public string Status { get; set; }

        public ResetPasswordModel()
        {
            Status = "";
        }
    }
}