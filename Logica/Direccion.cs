using Datos.Modelo;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Logica
{
    public class Direccion
    {
        public async Task<IEnumerable<vw_direccion>> ObtenerDireccion()
        {
            List<vw_direccion> list = null;

            try
            {
                using (var dbContext = new TestEntities())
                {
                    list = await dbContext.vw_direccion.ToListAsync();
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el listado de direcciones: " + ex.Message);

            }

            return list;
        }
    }
}
