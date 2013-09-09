Ext.define('MyDesktop.SelectGameOptionsPanel', {
    extend: 'Ext.panel.Panel',
    
    requires: [
        
    ],
    initComponent : function () {
        this.layout = {
            type : 'hbox',
            align : 'stretch'
        };
        this.items = [{
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
                    store: this.gamesStore,
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
                    
                    handler : this.onOptionsSelect
                }, {
                    xtype : 'button',
                    text : 'Cancel',
                    
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
        this.callParent(arguments);
    }

});
