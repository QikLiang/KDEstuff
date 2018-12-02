//when a window is activated, raise Tab Outliner to foreground if it's a chrome window
workspace.clientActivated.connect(function(client) {
    if (!client) {
        return;
    }
    var clients = workspace.clientList();
    for (var i=0; i<clients.length; i++) {
        if (clients[i].resourceName == "crx_eggkanocgddhmamlbiijnphhppkpkmkl")  {
            clients[i].keepAbove = client.resourceClass == "google-chrome";
            clients[i].skipSwitcher=true;
            clients[i].skipTaskbar=true;
            clients[i].skipPager=true;
        }
    }
});

//Close Tab Outliner when all other chrome windows are closed
workspace.clientRemoved.connect(function(client) {
    //only activate when closing a chrome window
    if (client.resourceName == "crx_eggkanocgddhmamlbiijnphhppkpkmkl" || client.resourceClass != "google-chrome"){
        return;
    }
    //count number of windows that is chrome and not OT
    var clients = workspace.clientList();
    var numChrome = 0;
    for (var i=0; i<clients.length; i++) {
        if (clients[i].resourceClass == "google-chrome" && clients[i].resourceName != "crx_eggkanocgddhmamlbiijnphhppkpkmkl") {
            numChrome++;
        }
    }
    //if no more windows left, 1 instead of zero because the about-to-be-deleted window is still in the list
    if (numChrome<=1){
        for (var i=0; i<clients.length; i++) {
            if (clients[i].resourceName == "crx_eggkanocgddhmamlbiijnphhppkpkmkl")  {
                clients[i].closeWindow();
                return;
            }
        }
    }
});
