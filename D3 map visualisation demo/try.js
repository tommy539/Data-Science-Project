
function statusChange(dataset)
{

svgid = "#svg1"
d3.json(dataset, function(mydata) {
    console.log(mydata);
    
    var width = Math.max.apply(Math,mydata.nodes.map(function(o){return o.x;})) * 1.25;
    var height = Math.max.apply(Math,mydata.nodes.map(function(o){return o.y;})) * 1.2;

   d3.select('svg').remove()

    var svg = d3.select('body').append('svg')
        .attr("width", width)
        .attr("height", height)
        .style("border", "1px solid")
        .style("background-color", 'lightyellow')
        .attr("align","center")
    ;
    var i,j;
    

    
//calculate the total amount for each site
    var site = [];
    var total = [];
    
    for (i = 0; i < mydata.nodes.length; i++){
        site.push(mydata.nodes[i].id)
        total.push(0)
    }
    
    var num
    var id
    var idx
    for (i = 0; i<mydata.links.length; i++) {
        id = mydata.links[i].node01;
        idx = site.indexOf(id);        
        total[idx] += mydata.links[i].amount;
        
        id = mydata.links[i].node02;
        idx = site.indexOf(id);        
        total[idx] += mydata.links[i].amount;
//      
        }
    

//add radius to the nodes
    
    for (i = 0; i < mydata.nodes.length; i++){
        mydata.nodes[i].r = total[i]/100;
    }



//add coordinates

    for (i = 0; i < mydata.links.length; i++){
        for (j = 0; j < mydata.nodes.length; j++){
            if (mydata.links[i].node01 === mydata.nodes[j].id) {
                mydata.links[i].xfrom = mydata.nodes[j].x;
                mydata.links[i].yfrom = mydata.nodes[j].y;
            }
            if (mydata.links[i].node02 === mydata.nodes[j].id) {
                mydata.links[i].xto = mydata.nodes[j].x;
                mydata.links[i].yto = mydata.nodes[j].y;
            }
                
    }
    }

//draw lines    
    var line = svg.selectAll('line')
        .data(mydata.links)
        .enter()
        .append('line')
        .style('stroke','grey')
        .style("stroke-width", function(d){return d.amount/100})
        .attr('x1', function(d){return d.xfrom})
        .attr('y1', function(d){return d.yfrom})
        .attr('x2', function(d){return d.xto})
        .attr('y2', function(d){return d.yto})


//draw circle
    var point = svg.selectAll("circle")
        .data(mydata.nodes)
        .enter()
        .append("circle");
    
    var pointAttributes = point
        .attr("cx", function(d){return d.x})
        .attr("cy",function(d){return d.y})
        .attr("r", function(d){return d.r*2})
        .attr('id', function(d){return d.id})
        .style("fill","skyblue")
        .on("mouseover", handleMouseOver)
        .on("mouseout", handleMouseOut);

//text label
    var text = svg.selectAll("text") 
        .data(mydata.nodes).enter().append("text");
    
    var textLabels = text
        .attr("x", function(d){return d.x +5 })
        .attr("y",function(d){return d.y + d.r*3})
        .text(function(d){return d.id})
        .attr("font-family", "Comic Sans MS")
        .attr("font-size", "15px")
        .attr("fill", "red");
      
    function handleMouseOver(d, i) {  
        // Add interactivity
        d3.selectAll('Circle')
            .style('opacity',0);
        
        d3.selectAll('text')
            .style('opacity',0);
        
        d3.select(this)
            .attr('r', d.r*4)
            .style('fill','orange')
            .style('opacity',1);
        identifier = this.id
        
        d3.selectAll('line')
            .style("stroke", 
                function(d)
                {
                    if (d.node01 == identifier)
                    {return "red"}
                    else if (d.node02 == identifier)
                    {return "blue"}
                })
        d3.selectAll('text')
            .style("opacity", 
                function(d)
                {if (d.id == identifier) {return 1} else {return 0}})

    // Specify where to put label of text
        svg.append("text")
            .attr({
            id: "t" + Math.round(d.x) + "-" + Math.round(d.y) + "-" + i,  
            // Create an id for text
            x: function() { return d.x +15 },
            y: function() { return d.y + d.r*3 +10 }
            })
            .attr("font-size", "10px")
            .attr("font-family", "Comic Sans MS")
            .text(function() {
            return ['Location: '+'(' +d.x, d.y+')' +','+'\n Total amount: '+Math.round(d.r*100)];  
            // Value of the text
        });
        svg.append("text")
            .attr({id: 'legend1',x: width - 410,y: 20})
            .attr("font-size", "10px").attr("font-family", "Comic Sans MS").attr("fill", "black")
            .text(function() {return [
            'Legend:'
            ];});
        svg.append("text")
            .attr({id: 'legend2',x: width - 400,y: 30})
            .attr("font-size", "10px").attr("font-family", "Comic Sans MS").attr("fill", "red")
            .text(function() {return [
            'red line   : when the site is in nodes01'
            ];});
        svg.append("text")
            .attr({id: 'legend3',x: width - 400,y: 40})
            .attr("font-size", "10px").attr("font-family", "Comic Sans MS").attr("fill", "blue")
            .text(function() {return [
            'blue line   : when the site is in nodes02'
            ];});
    }    
    function handleMouseOut(d, i) {
    // select element, change color back to normal
        d3.selectAll('Circle') 
            .style('opacity',1);
        
        d3.selectAll('text')
            .style('opacity',1);
        
        d3.select(this)
            .attr('r', d.r*2)
            .style('fill','skyblue')
            .style('opacity',1)
        ;
        d3.selectAll('line')
            .style("stroke", 'grey');
        
        // Select text by id and then remove
        d3.select("#t" +  Math.round(d.x) + "-" + Math.round(d.y) + "-" + i).remove();  
        // Remove text location
        d3.select('#legend1').remove();
        d3.select('#legend2').remove();
        d3.select('#legend3').remove();
    }
    }); 

}