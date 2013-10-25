package br.fumec.ios.sistoque.prop;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Prop {

	private static Prop instance;
	private Properties properties;

	public static Prop get() throws Exception {
		if (instance == null) {
			instance = new Prop();
		}

		return instance;
	}

	private Prop() throws Exception {
		load();
	}

	/**
	 * Carrega as propriedades de configuracao oriundas do arquivo
	 * 
	 * @return
	 * @throws IOException
	 */
	public void load() throws Exception {
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		InputStream input = null;

		try {
			input = cl.getResourceAsStream("categoria.properties");
			properties = new Properties();
			properties.load(input);

		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					throw new Exception(e);
				}
			}
		}
	}

	public Properties getProperties() {
		return this.properties;
	}

}
