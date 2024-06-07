class Datos_Comentarios{
  String? id;
  String? nombre;
  String? comentario;

  Datos_Comentarios(this.id, this.nombre, this.comentario);

  Datos_Comentarios.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    nombre = json['nombre'];
    comentario = json['comentario'];
  }
}