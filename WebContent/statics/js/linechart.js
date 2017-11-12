var Circle = function(x,y,r,msg,color){
    this.x = x;
    this.y = y;
    this.r = r;
    this.color = color;
    this.msg = msg;

    this.box = document.createElement('div');
    this.box.innerHTML = this.msg;
    $(this.box).addClass("tag").css('top',this.y).css('left',this.x).hide();
    var pa = document.getElementById('canvas');
    pa.appendChild(this.box);


};

Circle.prototype = {
    constructor : Circle,

    render : function(ctx){
        ctx.save();
        ctx.fillStyle = this.color;
        ctx.translate(this.x,this.y);
        ctx.beginPath();
        ctx.arc(0,0,this.r,0,Math.PI*2);
        ctx.fill();
        ctx.restore();
        return this;
    },

    hasPoint : function(x,y){
        var l = (this.x - x)*(this.x - x) + (this.y - y)*(this.y - y);
        if(l <= (this.r * this.r)){
            return true;
        }
        else{
            return false;
        }
    },

    showMsg : function(){
        $(this.box).show(); 
        return this;
    },

    removeMsg : function(){
        $(this.box).hide();
        return this;

    }
};


var getX = function(element){
    var left = element.offsetLeft;
    var op = element.offsetParent;
    while(op!=null){
        left += op.offsetLeft;
        op = op.offsetParent;
    }
    return left;
};

var getY = function(element){
    var top = element.offsetTop;
    var op = element.offsetParent;
    while(op!=null){
        top += op.offsetTop;
        op = op.offsetParent;
    }
    return top;
};


var LineChart = function(xValues,yValues,msg,padLeft,padBottom){
    this.circles = [],
    this.xValues = xValues || [],
    this.yValues = yValues || [],
    this.msg = msg || [],
    this.perX,
    this.perY,
    this.baseX,
    this.baseY,
    this.padLeft = padLeft || 30,
    this.padBottom = padBottom || 30,
    this.height;
    this.width;
};

LineChart.prototype = {
    constructor : LineChart,

    drawAxis : function(ctx){
        ctx.save();
        ctx.strokeStyle = "rgba(97,97,97,0.4)";
        ctx.beginPath();
        ctx.moveTo(this.padLeft,this.padBottom);
        ctx.lineTo(this.padLeft,this.padBottom+this.height);
        ctx.lineTo(this.padLeft+this.width , this.padBottom+this.height);
        ctx.stroke();

        var w = this.width / 5;
        var h = this.height /5;

        for(var i =1 ;i<=5 ;i++){
            ctx.fillStyle = "rgba(97,97,97,0.6)";
            ctx.textBaseline = 'middle';
            ctx.textAlign = 'end';
            ctx.fillText((h*this.perY*i+this.baseY).toFixed(2) , this.padLeft , this.padBottom + h*(5-i));
            ctx.textAlign="center";
            ctx.textBaseline="top";
            var date = new Date(w*i*this.perX+this.baseX.getTime());
            ctx.fillText( (date.getFullYear()+"-"+date.getMonth()+'-'+date.getDate() ), this.padLeft+w*i,this.padBottom+this.height);
            ctx.fillText(date.getHours()+":"+date.getMinutes()+":"+date.getSeconds() , this.padLeft+w*i,this.padBottom+this.height+10);

        }
        ctx.restore();

        return this;
    },

    drawLines : function(ctx){
        if(this.circles!=[]){
            ctx.save();
            ctx.strokeStyle = "rgba(64,198,222,1)";
            ctx.beginPath();
            ctx.moveTo(this.circles[0].x,this.circles[0].y);
            for(var i = 1 ; i < this.circles.length ; i++){
                ctx.lineTo(this.circles[i].x,this.circles[i].y);

            }
            ctx.stroke();
            ctx.restore();

        }
        return this;
    },

    createCircles : function(canvas){
        
        for(var i = 0;i<this.xValues.length;i++){
            var x = this.padLeft + (this.xValues[i].getTime()-this.baseX.getTime()) / this.perX;
            var y = canvas.height - (this.yValues[i]-this.baseY) / this.perY - this.padBottom;
            var date = this.xValues[i];
            var cir = new Circle(x,y,5,date.getFullYear()+"-"+date.getMonth()+'-'+date.getDate()+" "
                +date.getHours()+":"+date.getMinutes()+":"+date.getSeconds() +"<br/>"
                +"修改量："+this.yValues[i]+"行<br/>"
                +this.msg[i],"rgba(30,21,250 ,0.8)");

            this.circles.push(cir);
        }
        return this;

    },

    renderCircles : function(ctx){
        for(var i = 0 ; i < this.circles.length ; i++){
            this.circles[i].render(ctx);
        }
        return this;

    },

    setPer : function(canvas){
        this.baseX = this.xValues[0];
        this.baseY = 0;
        this.height = (canvas.height - this.padBottom *2);
        this.width = canvas.width-this.padLeft*2;
        this.perX = (this.xValues[this.xValues.length-1].getTime()-this.baseX.getTime()) / (canvas.width-this.padLeft*2) ;

        this.perY = (Math.max(...this.yValues)-this.baseY) / (canvas.height - this.padBottom *2);
        return this;
    }

    
};