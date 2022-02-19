using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProyectoTienda.Models
{
    public class CartModels
    {
        public List<ProductOrdered> productsOrdered { get; set; }
        public decimal getSubTotal()
        {
            productsOrdered.
                Sum(po => po.Product.Price)
            return 0;
        }
    }
}