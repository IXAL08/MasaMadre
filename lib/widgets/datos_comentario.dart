class Datos_Comentarios{
  String? id;
  String? nombre;
  String? comentario;
  String? imagen;

  Datos_Comentarios(this.id, this.nombre, this.comentario,this.imagen);

  Datos_Comentarios.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    nombre = json['nombre'];
    comentario = json['comentario'];
    imagen = json['imagen'];
  }
}