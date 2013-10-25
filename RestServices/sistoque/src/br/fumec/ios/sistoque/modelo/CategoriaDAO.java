package br.fumec.ios.sistoque.modelo;

import java.util.ArrayList;
import java.util.List;

import br.fumec.ios.sistoque.prop.Prop;

public class CategoriaDAO {

	private static CategoriaDAO instancia;

	private CategoriaDAO() {

	}

	public static CategoriaDAO get() {

		if (instancia == null) {
			instancia = new CategoriaDAO();
		}
		return instancia;
	}

	public void inserir(Categoria c) throws Exception {

		Categoria cat = obter(c.getCodigo());
		if (cat != null) {
			throw new Exception(String.format(
					"Categoria com codigo (%s) j\u00E1 existe.", c.getCodigo()));
		} else {
			Prop.get().getProperties().put(c.getCodigo(), c.getNome());
		}
	}

	public void atualizar(Categoria c) throws Exception {

		Categoria cat = obter(c.getCodigo());
		if (cat != null) {
			Prop.get().getProperties().put(c.getCodigo(), c.getNome());
		} else {
			throw new Exception(String.format(
					"Categoria com codigo (%s) j\u00E1 AINDA n\u00E3o existe.",
					c.getCodigo()));
		}
	}

	public void apagar(Categoria c) throws Exception {

		Categoria cat = obter(c.getCodigo());
		if (cat != null) {
			Prop.get().getProperties().remove(c.getCodigo());
		}
	}

	public Categoria obter(String codigo) throws Exception {
		String nome = Prop.get().getProperties().getProperty(codigo);
		Categoria retorno = null;
		if (nome != null) {
			retorno = new Categoria();
			retorno.setCodigo(codigo);
			retorno.setNome(nome);
		}
		return retorno;

	}

	public List<Categoria> obterTodos() throws Exception {
		List<Categoria> cs = new ArrayList<Categoria>();
		String codigo = null;
		String nome = null;

		for (Object c : Prop.get().getProperties().keySet()) {

			codigo = c.toString();
			nome = Prop.get().getProperties().get(c).toString();
			cs.add(new Categoria(codigo, nome));
		}
		return cs;
	}

}
