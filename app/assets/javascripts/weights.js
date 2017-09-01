
$(function(){
  $('.weights.index').ready(function(){
    var ctx = document.getElementById("myChart");
    var data = fetch('/weights.json').then((res) => console.log(res));
    //doesn't correctly trigger only on weights index, also triggers on weights <anything>
    if(ctx) {
      var myChart = new Chart(ctx, {
          type: 'line',
          data: {
            //months
              labels: ["8/27","8/27","8/27","8/27","8/27","8/27"],
              datasets: [{
                  //unit of measure
                  label: 'lbs',
                  //data points - weights
                  data: [293.3, 296.4, 295.4, 295.5, 292.2, 292.1],
                  //need color to match number of bars if using bars
                  //line will use first color and background for fill
                  backgroundColor: [
                      //'rgba(255, 99, 132, 0.2)',
                      'rgba(255,255,255,0)',
                      'rgba(54, 162, 235, 0.2)',
                      'rgba(255, 206, 86, 0.2)',
                      'rgba(75, 192, 192, 0.2)',
                      'rgba(153, 102, 255, 0.2)',
                      'rgba(255, 159, 64, 0.2)'
                  ],
                  borderColor: [
                      'rgba(255,99,132,1)',
                      'rgba(54, 162, 235, 1)',
                      'rgba(255, 206, 86, 1)',
                      'rgba(75, 192, 192, 1)',
                      'rgba(153, 102, 255, 1)',
                      'rgba(255, 159, 64, 1)'
                  ],
                  borderWidth: 1
              }]
          }
      });
    }
  });
});
