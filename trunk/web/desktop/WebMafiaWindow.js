Ext.define('MyDesktop.WebMafiaWindow', {
    extend: 'Ext.ux.desktop.Module',
    
    requires: [
        MyDesktop.User
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
                items : [{
                    title : 'Web Mafia baseline chat',
                    bodyCls : 'x-window-body-default',
                    flex : 2,
                    layout : {
                        type : 'vbox',
                        align : 'stretch'
                    },
                    items : [{
                        flex : 1,
                        id : 'chatlines',
                        bodyCls : 'x-window-body-default',
                        html : 'Chat lines'
                    }, {
                        bodyCls : 'x-window-body-default',
                        layout : {
                            type : 'hbox',
                            align : 'stretch'
                        },
                        items : [{
                            flex : 1,
                            xtype : 'textfield'
                        }, {
                            xtype : 'button',
                            text : 'Say'
                        }]
                    }]
                }, {
                    title : 'Online users',
                    bodyCls : 'x-window-body-default',
                    id : 'usersonline',
                    flex : 1, 
                    html :'second panel'
                }, {
                    title : 'Games',
                    bodyCls : 'x-window-body-default',
                    flex : 3,
                    layout : {
                        type : 'vbox',
                        align : 'stretch'
                    },
                    items : [{
                        id : 'gameslist',
                        flex : 1,
                        bodyCls : 'x-window-body-default',
                        html : 'Games list'
                    }, {
                        bodyCls : 'x-window-body-default',
                        layout : {
                            type : 'hbox',
                            align : 'stretch',
                            pack : 'center'
                        },
                        items : [{
                            xtype : 'button',
                            text : 'Create new game'
                        }]
                    }]
                }]//custom items
            });
            var updateClock = function () {
                Ext.fly('clock').update(new Date().format('g:i:s A'));
            }

            this.runner = new Ext.util.TaskRunner();
            this.task = this.runner.newTask({
                run: this.updateInformation,
                interval: 1000
            });
            win.on('show', this.onShow, this);
            win.on('hide', this.onHide, this);
            //custom after window create logic
        }
        return win;
    },
    
    onShow : function () {
        MyDesktop.User.setOnline();
        alert('Start polling... + set: User is online and active');
        this.task.start();
    },
    
    onHide : function () {
        MyDesktop.User.setAway();
        alert('Stop polling! + set: User is online but inactive');
        this.task.stop();
    },
    
    updateInformation : function () {
        Ext.Ajax.request({
            url: 'update.php',
            params: {
               user : window.userid
            },
            success: Ext.bind(function(response) {
                var text = response.responseText;
                try {
                    var result = Ext.decode(text);
                    Ext.getCmp('chatlines').update(result.chatlines);
                    try {
                        var users = Ext.decode(result.usersonline),
                            a = ['<table>'];
                        for (var i = 0; i < users.length; i++) {
                            a = a.concat(['<tr><td><img src="desktop/images', ((users[i].status == 1) ? '/online.png' : '/away.png'), '"></td><td><b>', users[i].name, '</b></td></tr>']);
                        }
                        a.push('</table>');
                        Ext.getCmp('usersonline').update(a.join(''));
                    }
                    catch (e) {
                        alert((window.alertmessage2 || 'Error during decoding userlist:') + '\n' + result.usersonline);
                    }
                    Ext.getCmp('gameslist').update(result.currentgames);
                }
                catch (e) {
                    alert((window.alertmessage1 || 'Error during decoding text:') + '\n' + text);
                }
            })
        });
    }
});