var techTree = (function(api){
    var initializeBorder = function initializeBorder(container) {
        container.append("rect")
            .attr("width", api.dimensions.nodeInnerWidth + 2*api.dimensions.nodeInnerBorder)
            .attr("height", api.dimensions.nodeInnerHeight + 2*api.dimensions.nodeInnerBorder)
            .style("filter",api.settings.useShadows? "url(#dropshadow)":"");
    };
    var initializeImages = function initializeImages(container){
        var offset;
        var image = container
            .append("svg")
            .attr("viewBox",function(d){
                if(api.settings.useSpriteSheet) {
                    offset = api.offsets[d.name] || api.offsets.default;
                    return "0 0 " + offset.w + " " + offset.h;
                }
                else{
                    return "0 0 " + api.dimensions.nodeInnerWidth + " " + api.dimensions.nodeInnerHeight;
                }
            })
            .attr("preserveAspectRatio","xMidYMid meet")
            .attr("x",api.dimensions.nodeInnerBorder)
            .attr("y",api.dimensions.nodeInnerBorder)
            .attr("width",api.dimensions.nodeInnerWidth)
            .attr("height",api.dimensions.nodeInnerHeight)
            .append("image")
            .attr("image-rendering",api.settings.imageRendering)
            .attr("xlink:href",function(d){
                if(api.settings.useSpriteSheet){
                    return api.settings.imageFolderName+"/"+api.settings.spriteSheetFileName;
                }
                else{
                    return d.image_url;
                }
            })
            .attr("x",0)
            .attr("y",0)
            .attr("width", api.settings.useSpriteSheet?
                api.dimensions.spriteSheetWidth: api.dimensions.nodeInnerWidth)
            .attr("height", api.settings.useSpriteSheet?
                api.dimensions.spriteSheetHeight: api.dimensions.nodeInnerHeight)
            .style("filter",function(pNode){
                return pNode.selected? "": "url(#desaturate)";
            });
        //if needed
        if(api.settings.useSpriteSheet){
            image
                .attr("clip-path", function(d){return "url(#clip-"+d.name+")";})
                .attr("transform", function(d){
                    offset = api.offsets[d.name] || api.offsets.default;
                    return "translate(-"+offset.x+",-"+offset.y+")";
                });
        }
    };
    api.initializeNodes = function initializeNodes(nodes, nodesByName){
        nodes.enter().append("g")
            .attr("class", "node")
            .attr("data-nodeUrl", function(d){
                return d.node_url
            })
            .attr("id",function(pNode,c){
                nodesByName[pNode.name] = d3.select(this);
                return c;
            })
            .attr('data-name', function(d){
                return d.name
            })
            .attr('data-completed', function(d){
                return d.completed
            })
            // Transition nodes to their new position.
            .attr("transform", function(d){
                return "translate(" + d.x + "," + d.y + ")";
            });

        initializeBorder(nodes);
        initializeImages(nodes);
    };
    api.clickNode = function clickNode(node_name){
        pNode = api.findNodeByName(node_name)
        return api.clickHandler(pNode, api.nodesByNameAccessor)
    }
    api.findNodeByName = function findNodeByName(node_name){
        return techTree.nodesData.find(function(nodeData){
            if (nodeData.name === node_name) {
                return true;
            }
            return false;
        });
    }
    api.updateNode = function updateNode(node) {
        node
            .transition()
            .duration(api.durations.activateNode)
            .select("rect").style("fill","#ffcf70").style("stroke","#FFBB33");
        node.select("image").style("filter", "");
    };
    api.activateAllNodes = function activateAllNodes() {
        for (var i = 0; i < api.nodesData.length; i++) {
            api.clickHandler(api.nodesData[i], api.nodesByNameAccessor);
        }
    }
    api.activateNodes = function activateNodes(node_names) {
        for (var i = 0; i < node_names.length; i++) {
            api.clickNode(node_names[i])
        }
    }
    return api;
}(techTree || {}));
