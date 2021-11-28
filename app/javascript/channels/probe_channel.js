import consumer from "./consumer"

document.addEventListener("DOMContentLoaded", function(e) {
  const container = document.getElementById('container');
  const probe_id = container.getAttribute('data-probe-id');

  consumer.subscriptions.create({ channel: "ProbeChannel", probe_id: probe_id, coordinates: coordinates, face: face }, {
    received(data) {
      var table = document.getElementById("table"),
          cells = table.getElementsByTagName("td");

      for (let i = 0; i < cells.length; i++) {
        cells[i].innerHTML = "";
      }

      var currentCell = document.getElementById(data.coordinates);
      currentCell.innerHTML = data.face;
    }
  });
});
