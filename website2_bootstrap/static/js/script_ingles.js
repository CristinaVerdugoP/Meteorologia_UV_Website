// Obtener todos los botones de colapso
var collapseButtons = document.querySelectorAll('.navbar-toggler');

// Usar el evento "click" para los botones de colapso
collapseButtons.forEach(function (button) {
  button.addEventListener('click', function () {
    var navbar2 = document.querySelector('.navbar2');
    var scrollPosition = window.scrollY;

    // Mostrar u ocultar navbar2 dependiendo del estado del botón de colapso
    if (scrollPosition >= 100 && button.getAttribute('aria-expanded') === 'true') {
      navbar2.classList.add('scroll-show');
    }
  });
});

// Usar el evento "scroll" para controlar la aparición del navbar2
window.addEventListener('scroll', function () {
  var navbar2 = document.querySelector('.navbar2');
  var scrollPosition = window.scrollY;

  // Mostrar u ocultar navbar2
  if (scrollPosition >= 100) {
    navbar2.classList.add('scroll-show');
  } else {
    navbar2.classList.remove('scroll-show');
  }
});



/**------------------CODIGO PARA LOS SELECTORES---------------------------------**/

let $region = document.querySelector('#region');
let $ciudad = document.querySelector('#ciudad');

let region = ["Valparaíso", 
              "OHiggins", 
              "Maule", 
              "Ñuble", 
              "Bío Bío", 
              "Araucanía",
              "Los Ríos",
              "Los Lagos"]

let ciudad = ["Valparaíso", "Quillota",
              "Rancagua", "Pichilemu",
              "Talca", "Constitución",
              "Chillán",
              "Concepción", "Los Angeles", "Lebu",
              "Temuco", "Angol", "Villarrica",
              "Valdivia", "Los Lagos",
              "Puerto Montt", "Osorno", "Castro", "Chaitén"] 

function mostrarLugares(arreglo, lugar, selectorVacio = true) {
  let elementos = "";
    if (selectorVacio) {
      elementos += '<option selected disabled>Select</option>';
    }
    for (let i = 0; i < arreglo.length; i++) {
      elementos +=
        '<option value="' + arreglo[i] + '">' + arreglo[i] + '</option>';
      }
              
                lugar.innerHTML = elementos;
              }
              

mostrarLugares(region, $region)

$region.addEventListener("change", function () {
  let valor = $region.value;
  switch (valor) {
    case "Valparaíso":
      let valparaiso = ciudad.slice(0, 2);
      mostrarLugares(valparaiso, $ciudad);
      break;
    case "OHiggins":
      let ohiggins = ciudad.slice(2,4)
      mostrarLugares(ohiggins, $ciudad)
    break
    case "Maule":
      let maule = ciudad.slice(4,6)
      mostrarLugares(maule, $ciudad)
    break
    case "Ñuble":
      let ñuble = ciudad.slice(6,7)
      mostrarLugares(ñuble, $ciudad)
    break
    case "Bío Bío":
      let biobio = ciudad.slice(7,10)
      mostrarLugares(biobio, $ciudad)
    break
    case "Araucanía":
      let araucania = ciudad.slice(10,13)
      mostrarLugares(araucania, $ciudad)
    break
    case "Los Ríos":
      let rios = ciudad.slice(13,15)
      mostrarLugares(rios, $ciudad)
    break
    case "Los Lagos":
      let lagos = ciudad.slice(15,19)
      mostrarLugares(lagos, $ciudad)
    break
  }
})

/**------------------------------ CODIGO PARA EL BOTON ---------------------------**/

function obtenerRutaImagen(region, ciudad) {
  if (region === 'Valparaíso' && ciudad === 'Valparaíso') {
    return ['assets/series/ts_valparaiso.jpg', 'assets/skew-t/valparaiso/000.png'];
  } 

  else if (region === 'OHiggins' && ciudad === 'Rancagua') {
    return ['assets/series/ts_rancagua.jpg', 'assets/skew-t/rancagua/000.png'];
  }
  else if (region === 'OHiggins' && ciudad === 'Pichilemu') {
    return ['assets/series/ts_pichilemu.jpg', 'assets/skew-t/pichilemu/000.png'];
  }
  else if (region === 'Maule' && ciudad === 'Talca') {
    return ['assets/series/ts_talca.jpg', 'assets/skew-t/talca/000.png'];
  }
  else if (region === 'Maule' && ciudad === 'Constitución') {
    return ['assets/series/ts_constitucion.jpg', 'assets/skew-t/constitucion/000.png'];
  }
  else if (region === 'Ñuble' && ciudad === 'Chillán') {
    return ['assets/series/ts_chillan.jpg', 'assets/skew-t/chillan/000.png'];
  }
  else if (region === 'Bío Bío' && ciudad === 'Concepción') {
    return ['assets/series/ts_concepcion.jpg', 'assets/skew-t/concepcion/000.png'];
  }  
  else if (region === 'Bío Bío' && ciudad === 'Los Angeles') {
    return ['assets/series/ts_los_angeles.jpg', 'assets/skew-t/los_angeles/000.png'];
  }  
  else if (region === 'Bío Bío' && ciudad === 'Lebu') {
    return ['assets/series/ts_lebu.jpg', 'assets/skew-t/lebu/000.png'];
  }
  else if (region === 'Araucanía' && ciudad === 'Temuco') {
    return ['assets/series/ts_temuco.jpg', 'assets/skew-t/temuco/000.png'];
  }  
  else if (region === 'Araucanía' && ciudad === 'Angol') {
    return ['assets/series/ts_angol.jpg', 'assets/skew-t/angol/000.png'];
  }
  else if (region === 'Araucanía' && ciudad === 'Villarrica') {
    return ['assets/series/ts_villarrica.jpg', 'assets/skew-t/villarrica/000.png'];
  }
  else if (region === 'Los Ríos' && ciudad === 'Valdivia') {
    return ['assets/series/ts_valdivia.jpg', 'assets/skew-t/valdivia/000.png'];
  }
  else if (region === 'Los Ríos' && ciudad === 'Los Lagos') {
    return ['assets/series/ts_los_lagos.jpg', 'assets/skew-t/los_lagos/000.png'];
  }
  else if (region === 'Los Lagos' && ciudad === 'Puerto Montt') {
    return ['assets/series/ts_puerto_montt.jpg', 'assets/skew-t/puerto_monnt/000.png'];
  }
  else if (region === 'Los Lagos' && ciudad === 'Osorno') {
    return ['assets/series/ts_osorno.jpg', 'assets/skew-t/osorno/000.png'];
  }
  else if (region === 'Los Lagos' && ciudad === 'Castro') {
    return ['assets/series/ts_castro.jpg', 'assets/skew-t/castro/000.png'];
  }
  else if (region === 'Los Lagos' && ciudad === 'Chaitén') {
    return ['assets/series/ts_chaiten.jpg', 'assets/skew-t/chaiten/000.png'];
  }
  return ['', ''];
}
let $imagen1 = document.querySelector('#imagen1');
let $imagen2 = document.querySelector('#imagen2');

function buscarImagen() {
  let regionSeleccionada = $region.value;
  let ciudadSeleccionada = $ciudad.value;
  
  let rutasImagenes = obtenerRutaImagen(regionSeleccionada, ciudadSeleccionada);
  console.log("Rutas de las imágenes:", rutasImagenes);

  mostrarImagenes(rutasImagenes);
  mostrarListaImagenesSkewT(ciudadSeleccionada);

  document.querySelector(".images-container").style.display = "block";

  // Deseleccionar cualquier elemento previamente seleccionado
  if (indiceSeleccionado !== -1) {
    document.getElementById("lista_imagen_skewt")
      .children[indiceSeleccionado].classList.remove("active");
    indiceSeleccionado = -1;
  }

  // Actualizar la imagen en el lado derecho con la imagen 000.png
  actualizarImagenSkewT(0);
  
  // Resaltar el primer elemento de la lista como activo
  const listaImagenesElement = document.getElementById("lista_imagen_skewt");
  if (listaImagenesElement.children.length > 0) {
    listaImagenesElement.children[0].classList.add("active");
    indiceSeleccionado = 0;
  }
}

function mostrarImagenes(rutasImagenes) {
  $imagen1.src = rutasImagenes[0];
}


//-----------Botones-------------
let $botonBuscar = document.querySelector('#buscar');

$botonBuscar.addEventListener('click', function() {
  let regionSeleccionada = $region.value;
  let ciudadSeleccionada = $ciudad.value;

  if (regionSeleccionada !== 'Select' && ciudadSeleccionada !== 'Select') {
    buscarImagen();
  } else {
    alert('Select a region and city before searching.');
  }
});
$imagen1.addEventListener('click', function() {
  window.open($imagen1.src);
});

// Activa los tooltips de Bootstrap
document.addEventListener("DOMContentLoaded", function () {
  const tooltips = new bootstrap.Tooltip(document.body, {
    selector: '[data-bs-toggle="tooltip"]',
  });
});


// Array de nombres de archivo de imágenes
var imagenes_Skewt =
{"angol": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"castro": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"chaiten": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"chillan": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"concepcion": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"constitucion": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"lebu": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"los_angeles": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"los_lagos": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"osorno": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"pichilemu": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"puerto_montt": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"rancagua": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"talca": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"temuco": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"valdivia": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"valparaiso": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],

"villarrica": ["000.png", "003.png", "006.png",
"009.png", "012.png", "015.png",
"018.png", "021.png", "024.png",
"027.png", "030.png", "033.png",
"036.png", "039.png", "042.png",
"045.png", "048.png", "051.png",
"054.png", "057.png", "060.png",
"063.png", "066.png", "069.png", "072.png"],
};

// Array de títulos personalizados
var titulos = ["000","003", "006", "009",
"012", "015", "018",
"021", "024", "027",
"030", "033", "036",
"039", "042", "045",
"048", "051", "054",
"057", "060", "063",
"066", "069", "072"];

function mostrarListaImagenesSkewT(ciudadMayusc) {
  indiceImagenActual = 0;
  indiceSeleccionado = -1;

  const ciudad = ciudadMayusc
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/ /g, "_");

  const listaImagenes = imagenes_Skewt[ciudad];
  const listaImagenesElement = document.getElementById("lista_imagen_skewt");

  if (listaImagenes) {
    listaImagenesElement.innerHTML = "";

    for (let i = 0; i < listaImagenes.length; i++) {
      const imagenElement = document.createElement("li");
      imagenElement.className = "list-group-item";
      const imagenLink = document.createElement("a");
      const imagenTexto = document.createTextNode(titulos[i]);

      imagenLink.appendChild(imagenTexto);
      imagenElement.appendChild(imagenLink);
      listaImagenesElement.appendChild(imagenElement);

      // Agrega un evento click para resaltar y deseleccionar elementos
      imagenLink.addEventListener("click", function () {
        actualizarImagenSkewT(i);
        if (indiceSeleccionado !== -1) {
          listaImagenesElement.children[indiceSeleccionado].classList.remove("active");
        }
        imagenElement.classList.add("active");
        indiceSeleccionado = i;
      });
    }
  } else {
    console.error("No se encontraron imágenes para la ciudad seleccionada.");
  }
}

// Agregar una función para actualizar la imagen en el contenedor de imágenes
let indiceImagenActual = 0;
let indiceSeleccionado = -1;

function resaltarElementoLista(indice) {
  const listaImagenesElement = document.getElementById("lista_imagen_skewt");
  
  // Deseleccionar cualquier elemento previamente seleccionado
  if (indiceSeleccionado !== -1) {
    listaImagenesElement.children[indiceSeleccionado].classList.remove("active");
  }
  
  // Resaltar el elemento actual
  listaImagenesElement.children[indice].classList.add("active");
  indiceSeleccionado = indice;
}

function actualizarImagenSkewT(indice) {
  const ciudadMayusc = $ciudad.value;
  const ciudadSeleccionada = ciudadMayusc
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/ /g, "_");

  const listaImagenes = imagenes_Skewt[ciudadSeleccionada];
  const rutaImagen = "assets/skew-t/" + ciudadSeleccionada + "/" + listaImagenes[indice];
  const $skewtImagen = document.getElementById("skewt_imagen");

  if ($skewtImagen) {
    $skewtImagen.src = rutaImagen;
    resaltarElementoLista(indice); // Resaltar el elemento de la lista
  } else {
    console.error("Elemento 'skewt_imagen' no encontrado en el DOM.");
  }
}


//En esta parte del codigo se presentan las funciones que se utilizarán para los botones de avance y retroceso de las imagenes Skew-T.
document.getElementById("anterior").addEventListener("click", function() {
  if (indiceImagenActual > 0) {
    indiceImagenActual--;
    actualizarImagenSkewT(indiceImagenActual);
  }
});

document.getElementById("siguiente").addEventListener("click", function() {
  const ciudadMayuscula = $ciudad.value;
  const ciudadSeleccionada = ciudadMayuscula
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/ /g, "_");

  console.log("Estoy en el botón de siguiente e imprimo:", $ciudad.value)

  const listaImagenes = imagenes_Skewt[ciudadSeleccionada];
  if (indiceImagenActual < listaImagenes.length - 1) {
    indiceImagenActual++;
    actualizarImagenSkewT(indiceImagenActual);
  }
});

document.getElementById("anterior-dos").addEventListener("click", function() {
  avanzarImagen(-4);
});

document.getElementById("siguiente-dos").addEventListener("click", function() {
  avanzarImagen(4);
});

function avanzarImagen(incremento) {
  const ciudadMayusc = $ciudad.value;
  const ciudadSeleccionada = ciudadMayusc
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/ /g, "_");
    
  const listaImagenes = imagenes_Skewt[ciudadSeleccionada];

  const nuevaPosicion = indiceImagenActual + incremento;

  if (nuevaPosicion >= 0 && nuevaPosicion < listaImagenes.length) {
    indiceImagenActual = nuevaPosicion;
    actualizarImagenSkewT(indiceImagenActual);
  }
}

//----------------Variables-------------
document.addEventListener('DOMContentLoaded', function() {
  const links = document.querySelectorAll('.descripcion');
  
  links.forEach(link => {
    link.addEventListener('click', function(event) {
      const variable = this.getAttribute('data-variable');
      const cardTitle = this.closest('.card').querySelector('.card-title').textContent; // Cambio aquí
      localStorage.setItem('selectedVariable', variable);
      localStorage.setItem('selectedCardTitle', cardTitle);
    });
  });
});