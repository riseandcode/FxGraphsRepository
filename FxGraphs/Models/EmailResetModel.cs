using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace ForexBox.Models
{
    public class EmailResetModel
    {
        [Required]
        public string Email { get; set; }
        public string Message { get; set; }
    }
}