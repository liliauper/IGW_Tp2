


<%@page import="ar.org.centro8.curso.java.web.connectors.Connector"%>
<%@page import="ar.org.centro8.curso.java.web.repositories.jdbc.ClienteRepository"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ar.org.centro8.curso.java.web.utils.TableHtml"%>
<%@page import="ar.org.centro8.java.web.repositories.list.ClienteRepositoryFactory"%>
<%@page import="ar.org.centro8.java.web.repositories.interfaces.I_ClienteRepository"%>
<%@page import="ar.org.centro8.curso.java.web.entities.Cliente"%>
<%@page import="ar.org.centro8.java.web.enums.TipoDocumento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%I_ClienteRepository cr= new ClienteRepository(Connector.getConnection()); %>


<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/style_1.css"/>
        <title>Clientes</title>
    </head>
    <body>
        <div class="grid-container">
            <div class="buscar">
                <h1>MANTENIMIENTO DE CLIENTES</h1>
                <form>
                    <table id="busqueda">
                        <tr>
                            <td class="label">
                                <h3>BUSCAR CLIENTES:  </h3>
                            </td>
                            <td>Por Apellido:</td>
                            <td><input type="text" name="buscarApellido" value="" /></td>
                            <td>Por Número Documento </td>
                            <td> <input type="text" name="buscarNumeroDocumento" value="" /></td>
                            <td><input type="submit" value="Buscar"/></td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="ingresar">
                <h3>INGRESAR NUEVO CLIENTE:</h3>
                <form >
                    <table>
                        <tr>
                            <td>Nombre:                 </td>
                            <td><input type="text"  name="nombre" minlength="3" maxlength="20" required /></td>
                        </tr>
                        <tr>
                            <td>Apellido:               </td>
                            <td><input type="text"  name="apellido" minlength="3" maxlength="20" required /></td>
                        </tr>
                        <tr>
                            <td>Edad:                   </td>
                            <td><input type="number" name="edad" min="18" max="120"/></td>
                        </tr>
                        <tr>
                            <td>Dirección:              </td>
                            <td><input type="text"  name="direccion" minlength="6" maxlength="50" required/></td>
                        </tr>
                        <tr>
                            <td>Email:                  </td>
                            <td><input type="email" name="email" minlength="3" maxlength="30"/></td>
                        </tr>
                        <tr>
                            <td>Telefono:               </td>
                            <td><input type="text"  name="telefono" minlength="3" maxlength="25" required/></td>
                        </tr>
                        <tr>
                            <td>Tipo de Documento:      </td>
                            <td>
                                <select name="tipoDocumento">
                                    <%
                                       for(TipoDocumento t: TipoDocumento.values()){
                                           out.println("<option value='"+t.toString()+"' selected >"+t.toString().toUpperCase()+"</option>");
                                       }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Número de Documento:    </td>
                            <td><input type="text" name="numeroDocumento" minlength="6" maxlength="8"/></td>
                        </tr>
                        <tr>
                            <td><input type="reset" value="Borrar"/></td>
                            <td><input type="submit" value="Enviar"/></td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="salida">
                <%
                   try {
                        String nombre=request.getParameter("nombre");
                        String apellido=request.getParameter("apellido");
                        int edad=Integer.parseInt(request.getParameter("edad"));
                        String direccion=request.getParameter("direccion");
                        String email=request.getParameter("email");
                        String telefono=request.getParameter("telefono");
                        TipoDocumento tipoDocumento= TipoDocumento.valueOf(request.getParameter("tipoDocumento"));
                        String numeroDocumento=request.getParameter("numeroDocumento");
               
                        Cliente cliente = new Cliente(nombre,apellido,edad,direccion,email,telefono,tipoDocumento,numeroDocumento);
                        cr.save(cliente);
                    
                       if(cliente.getId() == 0){
                           out.println("<h3>No se pudo dar de alta el cliente</h3>");
                       }else{
                           out.println("<h3>Se guardo el cliente id: "+ cliente.getId()+"</h3>");
                       }
               
                   } catch (Exception e) {
                       out.println("<h3>Falta ingresar parametros</h3>");
                   }
               
                %>
            </div>

            <div class="tabla"> 

                <% 
                   String apellido=request.getParameter("buscarApellido");
                   String numeroDocumento=request.getParameter("buscarNumeroDocumento");
                  
                   if(apellido==null) apellido="";
                   if(numeroDocumento==null) numeroDocumento="";
              
                   out.println(
                   new TableHtml<Cliente>().getTable(cr.getBuscar(apellido, numeroDocumento)));
                              
                %>


            </div>
        </div>
    </body>
</html>
