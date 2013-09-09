Ext.define('MyDesktop.WaitForOtherPlayersPanel', {
    extend: 'Ext.panel.Panel',
    
    requires: [
        
        
    ],
    
    initComponent : function () {
        this.layout = {
            type : 'vbox',
            align : 'stretch'
        };
        this.bodyCls = 'x-window-body-default';
        this.items = [{
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
                
                handler : this.onGameStartCancel
            }]
        }];
        this.callParent(arguments);
    }
});