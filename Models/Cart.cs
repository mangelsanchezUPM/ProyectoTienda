using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProyectoTienda.Models
{
    public class Cart : List<Product>
    {
        public double getTotalPrice() { return this.Sum(p => p.Price); }
        public int getItemAmount(int idProduct) { return this.Where(p => p.Id == idProduct).Count(); }
    }
}