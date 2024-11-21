class calculoPorcentaje{
  double calcularPorcentaje(int cantidad, int total){
    if(total == 0){
      return 0.0;
    }
    double porcentajeTotal = (cantidad/total)*100;
    return porcentajeTotal;
  }
}