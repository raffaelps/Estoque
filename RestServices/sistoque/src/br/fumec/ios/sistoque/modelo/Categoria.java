package br.fumec.ios.sistoque.modelo;

public class Categoria {

	private String codigo;
	private String nome;

	public Categoria() {

	}

	public Categoria(final String codigo, final String nome) {
		this();
		this.codigo = codigo;
		this.nome = nome;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

}
