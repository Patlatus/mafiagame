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
                        style : 'overflow:auto',
                        html : 'Chat: Loading...'
                    }, {
                        bodyCls : 'x-window-body-default',
                        layout : {
                            type : 'hbox',
                            align : 'stretch'
                        },
                        items : [{
                            flex : 1,
                            id : 'txt',
                            xtype : 'textfield'
                        }, {
                            xtype : 'button',
                            text : 'Say',
                            handler : this.onSay
                        }]
                    }]
                }, {
                    title : 'Online users',
                    bodyCls : 'x-window-body-default',
                    id : 'usersonline',
                    flex : 1, 
                    html :'Users: Loading...'
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
                        html : 'Games: Loading...'
                    }, {
                        bodyCls : 'x-window-body-default',
                        layout : {
                            type : 'hbox',
                            align : 'stretch',
                            pack : 'center'
                        },
                        items : [{
                            xtype : 'button',
                            text : 'Create new game',
                            scope : this,
                            handler : this.onCreateNewGame
                        }]
                    }]
                }]
            });
            var updateClock = function () {
                Ext.fly('clock').update(new Date().format('g:i:s A'));
            }

            this.runner = new Ext.util.TaskRunner();
            this.task = this.runner.newTask({
                run: this.updateInformation,
                interval: 2500
            });
            win.on('show', this.onShow, this);
            win.on('hide', this.onHide, this);
        }
        return win;
    },
    
    onShow : function () {
        MyDesktop.User.setOnline();
        //alert('Start polling... + set: User is online and active');
        this.task.start();
    },
    
    onHide : function () {
        if (!window.userLogged) {
            return;
        }
        MyDesktop.User.setAway();
        this.task.stop();
        //alert('Stop polling! + set: User is online but inactive');
    },
    
    onSay : function () {
        Ext.Ajax.request({
            url: 'abcl.php',
            params: {
                user : window.userid,
                username : window.username,
                text : Ext.getCmp('txt').getValue()
            },
            success: Ext.bind(function(response) {
                Ext.getCmp('txt').setValue('');
            })
        });
    },
    
    onCreateNewGame : function () {
        var desktop = myDesktopApp.getDesktop(),
            cg      = 'creategame',
            win     = desktop.getWindow(cg),
            parentw = desktop.getWindow(this.id);
        parentw.minimize();
        if (!win) {
            win = desktop.createWindow({
                id : cg,
                title : 'create new game',
                width : 425,
                maximized : true,
                minWidth : 330,
                height : 330,
                minHeight : 330,
                //iconCls : t.icon,
                animCollapse : false,
                constrainHeader : true,
                layout : {
                    type : 'hbox',
                    align : 'stretch'
                },
                items : [{
                    title : 'Select game options',
                    bodyCls : 'x-window-body-default',
                    flex : 2,
                    layout : {
                        type : 'vbox',
                        align : 'stretch'
                    },
                    items : [{
                        bodyCls : 'x-window-body-default',
                        layout : {
                            type : 'vbox',
                            align : 'stretch'
                        },
                        items : [{
                            xtype : 'checkbox',
                            name : 'custom',
                            id : 'customgame',
                            fieldLabel: 'Custom game',
                            //boxLabel : 'Custom game',
                            disabled : true
                        }, {
                            fieldLabel: 'predefined game',
                            id: 'predefinedgame',
                            name: 'predefinedgame',
                            xtype: 'combo',
                            store: {
                                fields:['code', 'name'],
                                data : [{'code':0,'name':'6 standard'}]
                            },
                            displayField: 'name',
                            valueField: 'code',
                            queryMode: 'local',
                            value : 0,
                            forceSelection: true,
                            allowBlank: false
                        }]
                    }, {
                        bodyCls : 'x-window-body-default',
                        layout : {
                            type : 'hbox',
                            align : 'stretch'
                        },
                        items : [{
                            xtype : 'button',
                            text : 'Create',
                            scope : this,
                            handler : this.onOptionsSelect
                        }, {
                            xtype : 'button',
                            text : 'Cancel',
                            scope : this,
                            handler : this.onOptionsSelectCancel
                        }]
                    }]
                }, {
                    title : 'Options',
                    disabled : true,
                    bodyCls : 'x-window-body-default',
                    flex : 3,
                    layout : {
                        type : 'vbox',
                        align : 'stretch'
                    },
                    items : [{
                        xtype: 'numberfield',
                        //anchor: '100%',
                        name: 'playerscount',
                        fieldLabel: 'Number of players',
                        value: 6,
                        maxValue: 6,
                        minValue: 0
                    }, {
                        xtype: 'numberfield',
                        //anchor: '100%',
                        name: 'mafiacount',
                        fieldLabel: 'Number of mafia',
                        value: 2,
                        maxValue: 2,
                        minValue: 0
                    }, {
                        xtype : 'checkbox',
                        name : 'commissar',
                        //boxLabel : 'Commissar present',
                        fieldLabel: 'Commissar present',
                        checked : true
                    }, {
                        xtype : 'checkbox',
                        name : 'doctor',
                        //boxLabel : 'Doctor present',
                        fieldLabel: 'Doctor present',
                        checked : true
                    }]
                }]    
            });
        };
        win.show();
    },
    
    onOptionsSelect : function () {
        if (Ext.getCmp('customgame').getValue()) {
            alert('Custom game feature is not implemented');
            return;
        }
        Ext.Ajax.request({
            url: 'anpg.php',
            params: {
                user : window.userid,
                username : window.username,
                gameid : Ext.getCmp('predefinedgame').getValue()
            },
            success: Ext.bind(function(response) {
                window.gameid = response.responseText;
                var desktop = myDesktopApp.getDesktop(),
                    cg      = 'creategame',
                    win     = desktop.getWindow(cg),
                    wp      = 'waitforotherplayers',
                    owin     = desktop.getWindow(wp);
                win.close();
                if (!owin) {
                    owin = desktop.createWindow({
                        id : wp,
                        title : 'Wait for other participants players',
                        width : 425,
                        maximized : true,
                        minWidth : 330,
                        height : 330,
                        minHeight : 330,
                        //iconCls : t.icon,
                        animCollapse : false,
                        constrainHeader : true,
                        layout : {
                            type : 'hbox',
                            align : 'stretch'
                        },
                        items : [{
                            //title : '---',
                            bodyCls : 'x-window-body-default',
                            flex : 2,
                            layout : {
                                type : 'vbox',
                                align : 'stretch'
                            },
                            items : [{
                                title : 'Players',
                                bodyCls : 'x-window-body-default',
                                id : 'players',
                                flex : 1,
                                html : 'players list'
                            }, {
                                bodyCls : 'x-window-body-default',
                                layout : {
                                    type : 'hbox',
                                    align : 'stretch'
                                },
                                items : [{
                                    xtype : 'button',
                                    text : 'Start',
                                    disabled : true,
                                    handler : this.onGameStart
                                }, {
                                    xtype : 'button',
                                    text : 'Start prematurely using bot players',
                                    handler : this.onGameStartBots
                                }, {
                                    xtype : 'button',
                                    text : 'Cancel',
                                    scope : this,
                                    handler : this.onGameStartCancel
                                }]
                            }]
                        }]    
                    });
                };
                owin.show();
                
                
                
            }, this)
        });
    },
    
    onOptionsSelectCancel : function () {
        var desktop = myDesktopApp.getDesktop(),
            cg      = 'creategame',
            win     = desktop.getWindow(cg),
            parentw = desktop.getWindow(this.id);
        win.close();
        parentw.show();
    },

    onGameStart : function () {
        alert('game start not implemented');
        /*Ext.Ajax.request({
            url: 'abcl.php',
            params: {
                user : window.userid,
                username : window.username,
                text : Ext.getCmp('txt').getValue()
            },
            success: Ext.bind(function(response) {
                Ext.getCmp('txt').setValue('');
            })
        });*/
    },
    
    onGameStartBots : function () {
        alert('game start with bots not implemented');
        /*Ext.Ajax.request({
            url: 'abcl.php',
            params: {
                user : window.userid,
                username : window.username,
                text : Ext.getCmp('txt').getValue()
            },
            success: Ext.bind(function(response) {
                Ext.getCmp('txt').setValue('');
            })
        });*/
    },
    
    onGameStartCancel : function () {
        Ext.Ajax.request({
            url: 'pgu.php',
            params: {
                userid : window.userid,
                username : window.username,
                gameid : window.gameid,
                status : 'cancelled'
            }
        });
        var desktop = myDesktopApp.getDesktop(),
            cg      = 'waitforotherplayers',
            win     = desktop.getWindow(cg),
            parentw = desktop.getWindow(this.id);
        win.close();
        parentw.show();
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
                    try {
                        var chatlines = Ext.decode(result.chatlines),
                            a = ['<div>'];
                        for (var i = 0; i < chatlines.length; i++) {
                            a = a.concat(['<div><span><b>', chatlines[i].username, '</b></span>&nbsp;<span>', chatlines[i].text, '</span></div>']);
                        }
                        a.push('</div>');
                        Ext.getCmp('chatlines').update(a.join(''));
                    }
                    catch (e) {
                        alert((window.alertmessage2 || 'Error during decoding userlist:') + '\n' + result.usersonline);
                    }
                    try {
                        var users = Ext.decode(result.usersonline),
                            a = ['<table>'];
                        for (var i = 0; i < users.length; i++) {
                            a = a.concat(['<tr><td><img src="desktop/images', ((users[i].status == 1) ? '/online.png' : '/away.png'), '"></td><td>&nbsp;</td><td><b>', users[i].name, '</b></td></tr>']);
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