using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Datos.Modelo;
namespace Logica
{
    public class Client
    {

        //Metodo para realizar las operaciones de agregar,modificar y dar de baja
        public void ClienteCrud(Cliente c, string accion)
        {

            try
            {
                using (var dbContext = new TestEntities())
                {
                    //Ejecutamos el procedimiento almacenado
                    dbContext.sp_cliente(c.Id, c.n_identificacion, c.tipo_identificacion, c.primer_nombre,c.segundo_nombre, c.primer_apellido, c.segundo_apellido, c.Id_direccion, c.estado, accion);

                }

            }catch (Exception ex)
            {
                throw new Exception("Error al ejecutar el procedimiento del cliente: " + ex.Message);
            }
            

           
        }

        //Proceso asincronico para mejorar el rendimeinto, al momento de obtener los registros de los clientes
        public async Task<IEnumerable<vw_clientes>> ObtenerClientes()
        {
            List<vw_clientes> list = null;

            try
            {
                using (var dbContext = new TestEntities())
                {
                    //Ejecutamos el procedimiento almacenado
                    list = await dbContext.vw_clientes.ToListAsync();
                }
            }catch (Exception ex)
            {
                throw new Exception("Error al obtener el listado de clientes: " + ex.Message);

            }

            return list;
        }
    }
}
