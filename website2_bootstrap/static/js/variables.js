document.addEventListener('DOMContentLoaded', function() {
  const titulo = document.getElementById('titulo');

  const cardTitle = localStorage.getItem('selectedCardTitle');
  
  // Verifica si el título de la tarjeta está presente y estás en la página de los parámetros
  if (cardTitle && window.location.pathname.endsWith('/index_parametros.html')) {
    document.title = cardTitle;
    titulo.textContent = cardTitle;
  } else {
    // Si no estás en la página de los parámetros, no cambia el título
  }
});


//--------------IMAGENES------------------------

document.addEventListener('DOMContentLoaded', function() {
  const tabla = document.getElementById('tabla');
  
  const urlParams = new URLSearchParams(window.location.search);
  const variable = urlParams.get('variable');

  fetch('assets/variables/Parametros.json')
    .then(response => response.json())
    .then(data => {
      const imagenes = data[variable];
      if (imagenes) {
        const celdas = tabla.querySelectorAll('td');
        
        celdas.forEach((celda, index) => {
          if (index < imagenes.length) {
            const aImagen = document.createElement('a');
            aImagen.href = `/assets/variables/${variable}${imagenes[index]}`;
            aImagen.target = '_blank';
            const imgImagen = document.createElement('img');
            imgImagen.className = 'imagen';
            imgImagen.src = `/assets/variables/${variable}${imagenes[index]}`;
            imgImagen.alt = `Imagen ${index + 1}`;
            aImagen.appendChild(imgImagen);

            const h5Hora = document.createElement('h5');
            h5Hora.className = 'text-center';
            h5Hora.textContent = index === 0 ? 'Hora de Análisis 00' : `+${index * 3} Horas`;
            
            celda.innerHTML = ''; // Limpiamos el contenido actual
            celda.appendChild(h5Hora);
            celda.appendChild(aImagen);
          }
        });
      }
    })
    .catch(error => console.error('Error al cargar el archivo JSON:', error));
});








