using Datos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Test
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "ICliente" in both code and config file together.
    [ServiceContract]
    public interface ICliente
    {


        [OperationContract]
        void Alta(string n_identificacion, string tipo_identificacion, string primer_nombre, string segundo_nombre, string primer_apellido, string segundo_apellido, int id_direccion);
        [OperationContract]
        void Modificar(int id, string n_identificacion, string tipo_identificacion, string primer_nombre, string segundo_nombre, string primer_apellido, string segundo_apellido, int id_direccion);
        [OperationContract]
        void Baja(int id);

        [OperationContract]
        Task<IEnumerable<vw_clientes>> ObtenerClientes();

        [OperationContract]
        Task<IEnumerable<vw_direccion>> ObtenerDireccion();

    }
}
