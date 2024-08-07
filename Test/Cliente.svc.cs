using Datos.Modelo;
using Logica;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.EntityClient;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Test
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Cliente" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Cliente.svc or Cliente.svc.cs at the Solution Explorer and start debugging.
    public class Cliente : ICliente
    {
        //Agregar un nuevo cliente
        public void Alta(string n_identificacion,string tipo_identificacion, string primer_nombre, string segundo_nombre, string primer_apellido, string segundo_apellido, int id_direccion )
        {
            Logica.Client ClientModel = new Logica.Client();
            ClientModel.ClienteCrud(new Datos.Modelo.Cliente { n_identificacion = n_identificacion, tipo_identificacion=tipo_identificacion, primer_nombre = primer_nombre, segundo_nombre= segundo_nombre, primer_apellido = primer_apellido, segundo_apellido = segundo_apellido, Id_direccion = id_direccion }, "I");
        }

        //Modificar un nuevo cliente
        public void Modificar(int id, string n_identificacion, string tipo_identificacion, string primer_nombre, string segundo_nombre, string primer_apellido, string segundo_apellido, int id_direccion)
        {
            Client CLientModel = new Client();
            CLientModel.ClienteCrud(new Datos.Modelo.Cliente { Id = id, n_identificacion = n_identificacion, tipo_identificacion = tipo_identificacion, primer_nombre = primer_nombre, segundo_nombre = segundo_nombre, primer_apellido = primer_apellido, segundo_apellido = segundo_apellido, Id_direccion = id_direccion }, "U");
        }

        //Cambiar el estado del cliente
        public void Baja(int id)
        {
            Client ClientModel = new Client();
            ClientModel.ClienteCrud(new Datos.Modelo.Cliente { Id = id, estado = "I" }, "D");
        }

        //Obtenemos los registros delos clientes
        public async Task<IEnumerable<vw_clientes>> ObtenerClientes()
        {
            Client ClientModel = new Client();
            return await ClientModel.ObtenerClientes();
        }

        //Obtenemos los registros de direcciones
        public async Task<IEnumerable<vw_direccion>> ObtenerDireccion()
        {
            Logica.Direccion d = new Logica.Direccion();
            return await d.ObtenerDireccion();
        }
    }
}
