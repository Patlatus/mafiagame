Ext.define('MyDesktop.WebMafiaWindow', {
    extend: 'Ext.ux.desktop.Module',
    
    requires: [
    ],
    
    id    : 'mafia-win',
    title : 'Mafia game',
    icon  : 'icon-mafia',

    
    init : function() {
        this.launcher = {
            text : this.title,
            iconCls : this.icon
        };
        //custom logic
    },
    
    createWindow : function() {
        var t       = this,
            desktop = myDesktopApp.getDesktop();
            win     = desktop.getWindow(t.id);
        if (!win) {
            win = desktop.createWindow({
                id : t.id,
                title : t.title,
                width : 425,
                maximized : true,
                minWidth : 330,
                height : 330,
                minHeight : 330,
                iconCls : t.icon,
                animCollapse : false,
                constrainHeader : true,
                layout : {
                    type : 'hbox',
                    align : 'stretch'
                },
                items:[{
                    title : 'Web Mafia baseline chat',
                    bodyCls : 'x-window-body-default',
                    flex : 2,
                    html : 'first panel'
                }, {
                    title : 'Online users',
                    bodyCls : 'x-window-body-default',
                    flex : 1, 
                    html :'second panel'
                }, {
                    title : 'Games',
                    bodyCls : 'x-window-body-default',
                    flex : 3,
                    html :'third panel'
                }]//custom items
            });
            //custom after window create logic
        }
        return win;
    }
});