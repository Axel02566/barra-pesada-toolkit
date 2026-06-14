public class ManifestObjects {

    private String nome;
    private String tipo;
    private String aliases;
    private String sistema;
    private String categoria;

    public ManifestObjects(String aliases, String categoria, String nome, String sistema, String tipo) {
        this.aliases = aliases;
        this.categoria = categoria;
        this.nome = nome;
        this.sistema = sistema;
        this.tipo = tipo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getAliases() {
        return aliases;
    }

    public void setAliases(String aliases) {
        this.aliases = aliases;
    }

    public String getSistema() {
        return sistema;
    }

    public void setSistema(String sistema) {
        this.sistema = sistema;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

}