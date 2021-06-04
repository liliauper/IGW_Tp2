package ar.org.centro8.java.web.repositories.list;


import ar.org.centro8.curso.java.web.entities.Cliente;
import ar.org.centro8.java.web.repositories.interfaces.I_ClienteRepository;
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author lilia
 */
public class ClienteRepository implements I_ClienteRepository {

    private List<Cliente>list=new ArrayList();

    @Override
    public void save(Cliente cliente) {
        list.add(cliente);
    }

    @Override
    public void remove(Cliente cliente) {
      list.remove(cliente);
    }

    @Override
    public void update(Cliente cliente) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<Cliente> getAll() {
      return list;
    }
    

  
}
