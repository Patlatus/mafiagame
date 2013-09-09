Ext.define('MyDesktop.WebMafiaWindow', {
    extend: 'Ext.ux.desktop.Module',
    
    requires: [
        MyDesktop.User,
        MyDesktop.SelectGameOptionsPanel,
        MyDesktop.WaitForOtherPlayersPanel
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
    
    getGameNameById : function (gameId) {
        return this.gamesStore.findRecord('code', gameId).get('name')
    },
    
    createWindow : function() {
        var t       = this,
            desktop = myDesktopApp.getDesktop();
            win     = desktop.getWindow(t.id);
        if (!win) {
            this.gamesStore = Ext.create('Ext.data.Store', {
                fields:['code', 'name'],
                data : [{'code':0,'name':'6 standard'}]
            });
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
                        flex : 1,
                        bodyCls : 'x-window-body-default',
                        layout : {
                            type : 'hbox',
                            align : 'stretch'
                        },
                        items : [{
                            id : 'gameslistparent',
                            flex : 1,
                            layout : {
                                type : 'vbox',
                                align : 'stretch'
                            },
                            items : [{
                                id : 'gameslist',
                                flex : 1,
                                bodyCls : 'x-window-body-default',
                                border : false,
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
                        }, Ext.create('MyDesktop.SelectGameOptionsPanel', {
                            hidden : true,
                            id : 'creategame',
                            flex : 1,
                            border : false,
                            gamesStore: this.gamesStore,
                            onOptionsSelect: Ext.bind(this.onOptionsSelect, this),
                            onOptionsSelectCancel: Ext.bind( this.onOptionsSelectCancel, this)
                        }), Ext.create('MyDesktop.WaitForOtherPlayersPanel', {
                            hidden : true,
                            id : 'waitforotherplayers',
                            flex : 1,
                            border : false,
                            onGameStart : Ext.bind(this.onGameStart, this),
                            onGameStartBots : Ext.bind(this.onGameStartBots, this),
                            onGameStartCancel : Ext.bind(this.onGameStartCancel, this)
                        })]
                    }]
                }]
            });
            var updateClock = function () {
                Ext.fly('clock').update(new Date().format('g:i:s A'));
            }

            this.runner = new Ext.util.TaskRunner();
            this.task = this.runner.newTask({
                run: this.updateInformation,
                scope : this,
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
        Ext.getCmp('gameslistparent').hide();
        Ext.getCmp('creategame').show();
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
                
                Ext.getCmp('creategame').hide();
                Ext.getCmp('waitforotherplayers').show();
            
                
                
                
            }, this)
        });
    },
    
    onOptionsSelectCancel : function () {
        
        Ext.getCmp('creategame').hide();
        
        Ext.getCmp('gameslistparent').show();
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
        Ext.getCmp('waitforotherplayers').hide();
        Ext.getCmp('gameslistparent').show();
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
                    
                    try {
                    
                        var gameslist        = Ext.decode(result.currentgames),
                            items            = [],
                            a                = [],
                            gamespanelparent = Ext.getCmp('gameslist'),
                            gamespanel,
                            i;
                        
                        
                            
                        for (i = 0; i < gameslist.length; i++) {
                            a = ['<div><span><b>', gameslist[i].username, '</b></span>&nbsp;<span>', this.getGameNameById(gameslist[i].gameid), '</span><span><i>', gameslist[i].PlayersCount, '/6</i></span>'+
                            
                            
                            '</div>'];
                            
                            
                            
                            
                            items.push({
                                xtype:'panel',
                                layout:'hbox',
                                bodyCls : 'x-window-body-default',
                                border: false,
                                items: [{
                                    bodyCls : 'x-window-body-default',
                                    border: false,
                                    html : a.join('')
                                }, {
                                    xtype: 'button',
                                    text : 'Join'
                                }]
                            })
                        };
                        
                        gamespanelparent.items.clear();
                        gamespanelparent.update('');
                        gamespanel = Ext.create('Ext.panel.Panel', {
                            layout : 'vbox',
                            bodyCls : 'x-window-body-default',
                            border: false,
                            items : items
                        });
                        
                        
                        gamespanelparent.add(gamespanel);
                    }
                    catch (e) {
                        alert(('Error during decoding gameslist:') + '\n' + result.usersonline);
                    }
                    
                    
                }
                catch (e) {
                    alert((window.alertmessage1 || 'Error during decoding text:') + '\n' + text);
                }
            }, this)
        });
    }
});