
    var loadCanvas = document.getElementById("loading");
    var canvasContext = loadCanvas.getContext('2d');

    loadCanvas.height = window.innerHeight * 0.5;
    loadCanvas.width = window.innerWidth * 0.9;

    canvasContext.fillStyle="rgb(255, 255, 255)";
    canvasContext.fillRect(0,0,loadCanvas.width,loadCanvas.height);

    var loadBar = function(x,y,r,arc,w,h,color,opa){
      this.x = x;
      this.y = y;
      this.w = w;//width
      this.h = h;//height
      this.r = r;//半径
      this.color  =color;
      this.arc = arc;//旋转弧度
      this.opa = opa;//透明度

    };

    loadBar.prototype = {
      constructor:loadBar,
      update:function(){
        // this.opa = (this.opa + 0.199)%1;
        this.arc = (this.arc + Math.PI / 3) % (Math.PI * 2);

      },

      render: function(canvasContext){
        canvasContext.save();
        canvasContext.fillStyle = 'hsla('+this.color+',100%,50%,'+this.opa+')';
        canvasContext.translate(this.x,this.y);
        canvasContext.rotate(this.arc);
        canvasContext.fillRect(this.r,-this.h/2,this.w,this.h);
        canvasContext.restore();
      }
    }

    var barList = [];
    var bar;

    bar = new loadBar(loadCanvas.width/2,loadCanvas.height/2,
      20,Math.PI / 2,
      30 , 10,
      249,1 );


    function loop(){

      canvasContext.globalCompositeOperation = 'source-over';

      canvasContext.fillStyle = 'rgba(255,255, 255,0.4)';
      canvasContext.fillRect(0,0,loadCanvas.width , loadCanvas.height);
      // canvasContext.globalCompositeOperation = 'lighter';

      bar.update();
      bar.render(canvasContext);
      // var stop = requestAnimationFrame(loop);


    }
    // loop();
    var stop = setInterval(loop,120);
