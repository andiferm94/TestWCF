//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Datos.Modelo
{
    using System;
    using System.Collections.Generic;
    
    public partial class Prestamo
    {
        public int n_prestamo { get; set; }
        public string tipo_prestamo { get; set; }
        public int id_cliente { get; set; }
        public System.DateTime fecha_inicio { get; set; }
        public System.DateTime fecha_fin { get; set; }
        public decimal monto_solicitado { get; set; }
        public string moneda { get; set; }
        public int plazo_financiamiento { get; set; }
        public string estado { get; set; }
    
        public virtual Cliente Cliente { get; set; }
    }
}
