using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProyectoTienda.Models
{
    public class Cart : List<ProductAndUnits>
    {
        public double GetTotal() { return this.Sum(p => p.product.Price*p.units); }
        public int GetItemAmount(int idProduct) { return this.Find(p => p.product.Id == idProduct).units; }
    }
}