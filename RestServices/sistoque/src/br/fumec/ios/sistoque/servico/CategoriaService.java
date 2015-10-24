package br.fumec.ios.sistoque.servico;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import br.fumec.ios.sistoque.modelo.Categoria;
import br.fumec.ios.sistoque.modelo.CategoriaDAO;

@Path("/categoria")
public class CategoriaService {

	CategoriaDAO dao = CategoriaDAO.get();

	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response create(Categoria categoria) throws Exception {
		dao.inserir(categoria);
		return Response.status(Response.Status.CREATED).entity(categoria)
				.build();

	}

	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response update(Categoria categoria) throws Exception {

		dao.atualizar(categoria);
		return Response.status(Response.Status.CREATED).entity(categoria)
				.build();
	}

	@DELETE
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response delete(Categoria categoria) throws Exception {

		dao.apagar(categoria);
		return Response.status(Response.Status.ACCEPTED).entity(categoria)
				.build();

	}

	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Path("list")
	public Categoria[] get() throws Exception {

		List<Categoria> cs;

		cs = dao.obterTodos();
		return cs.toArray(new Categoria[cs.size()]);
	}

	@GET
	@Path("{codigo}")
	@Produces(MediaType.APPLICATION_JSON)
	public Categoria get(@PathParam("codigo") String codigo) throws Exception {

		Categoria c = dao.obter(codigo);

		return c;
	}
}
