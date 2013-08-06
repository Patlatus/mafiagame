/*!
 * Ext JS Library 4.0
 * Copyright(c) 2006-2011 Sencha Inc.
 * licensing@sencha.com
 * http://www.sencha.com/license
 */

Ext.define('MyDesktop.Notepad', {
    extend: 'Ext.ux.desktop.Module',

    requires: [
        'Ext.form.field.HtmlEditor'
    ],

    id:'notepad',

    init : function(){
        this.launcher = {
            text: window.addnote || 'Додати запис',
            iconCls:'notepad'
        }
    },
    
    ps : function (s) {
        return s.replace(/\n/igm, '<br>').replace(/'/igm, '&#39;');
    },

    createWindow : function(){
        var desktop = this.app.getDesktop();
        var win = desktop.getWindow('notepad');
        if (!win){
            win = desktop.createWindow({
                id: 'notepad',
                title:window.addnewnote || 'Додати новий запис',//'Add new note',
                width:600,
                height:400,
                iconCls: 'notepad',
                animCollapse:false,
                border: false,
                //defaultFocus: 'notepad-editor', EXTJSIV-1300

                // IE has a bug where it will keep the iframe's background visible when the window
                // is set to visibility:hidden. Hiding the window via position offsets instead gets
                // around this bug.
                hideMode: 'offsets',
                bbar: [
                    { 
                        xtype: 'button',
                        text: window.addnewnote || 'Додати новий запис',
                        listeners: {
                            click: {
                                scope: this,
                                fn: function() {
                                    var data = {
                                        title : this.ps(Ext.getCmp('title-editor').getValue()),
                                        x     : this.app.getDesktop().getWindow('notepad').x,
                                        y     : this.app.getDesktop().getWindow('notepad').y,
                                        text  : this.ps(Ext.getCmp('notepad-editor').getValue())
                                    };
                                    Ext.Ajax.request({
                                        url: 'as.php',
                                        params: {
                                            hashtag: window.userid,
                                            text: this.ps(Ext.getCmp('notepad-editor').getValue()),
                                            title:this.ps(Ext.getCmp('title-editor').getValue()),
                                            x:this.app.getDesktop().getWindow('notepad').x,
                                            y:this.app.getDesktop().getWindow('notepad').y
                                        },
                                        scope: this.app,
                                        success: function(response){
                                            data.id = response.responseText;
                                            this.getModule("notepad").showPanel(data, 'background-color:yellow;', {
                                                showDuplicateButton : false,
                                                showEditButton      : true,
                                                showRemoveButton    : true
                                            });
                                        }
                                    });
                                    this.app.getDesktop().getWindow('notepad').close();
                                }
                            }
                        }
                    }
                ],
                layout: {
                    type: 'vbox',
                    align: 'stretch'
                },
                items: [
                    {
                        xtype: 'panel',
                        
                        layout: {
                            type: 'hbox',
                            align: 'stretch'
                        },
                        items: [
                            {
                                html: window.titletext || 'Заголовок:'
                            },
                            {
                                xtype: 'textfield',
                                id: 'title-editor'
                            }
                        ]
                    },
                    {
                        xtype: 'htmleditor',
                        flex: 1,
                        id: 'notepad-editor',
                        value: [
                            'Some <b>rich</b> <font color="red">text</font> goes <u>here</u><br>',
                            'Give it a try!'
                        ].join('')
                    }
                ]
            });
        }
        return win;
    },
    
    duplicate : function (idn) {
        var desktop = this.app.getDesktop();
        panelWin = desktop.getWindow(idn);
        win = desktop.createWindow({
            id: 'notepad',
            title:window.editnote || 'Редагувати запис',//'Add new note',
            width:600,
            height:400,
            x: panelWin.x,
            y: panelWin.y,
            iconCls: 'notepad',
            animCollapse:false,
            border: false,
            //defaultFocus: 'notepad-editor', EXTJSIV-1300

            // IE has a bug where it will keep the iframe's background visible when the window
            // is set to visibility:hidden. Hiding the window via position offsets instead gets
            // around this bug.
            hideMode: 'offsets',
            bbar: [
                { 
                    xtype: 'button',
                    text: window.applychanges || 'Застосувати зміни',
                    listeners: {
                        click: {
                            scope: this,
                            fn: function() {
                                var data = {
                                    title : this.ps(Ext.getCmp('title-editor').getValue()),
                                    x     : this.app.getDesktop().getWindow('notepad').x,
                                    y     : this.app.getDesktop().getWindow('notepad').y,
                                    text  : this.ps(Ext.getCmp('notepad-editor').getValue())
                                };
                                Ext.Ajax.request({
                                    url: 'as.php',
                                    params: {
                                        id: idn,
                                        hashtag: window.userid,
                                        text: this.ps(Ext.getCmp('notepad-editor').getValue()),
                                        title:this.ps(Ext.getCmp('title-editor').getValue()),
                                        x:this.app.getDesktop().getWindow('notepad').x,
                                        y:this.app.getDesktop().getWindow('notepad').y
                                    },
                                    scope: this.app,
                                    success: function (response){
                                        data.id = response.responseText;
                                        this.getModule("notepad").showPanel(data, 'background-color:yellow;', {
                                            showDuplicateButton : false,
                                            showEditButton      : true,
                                            showRemoveButton    : true
                                        });
                                    }
                                });
                                this.app.getDesktop().getWindow('notepad').close();
                            }
                        }
                    }
                }
            ],
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            items: [
                {
                    xtype: 'panel',
                    
                    layout: {
                        type: 'hbox',
                        align: 'stretch'
                    },
                    items: [
                        {
                            html: window.titletext || 'Заголовок:'
                        },
                        {
                            xtype: 'textfield',
                            id: 'title-editor',
                            value: panelWin.title//getTitle()
                        }
                    ]
                },
                {
                    xtype: 'htmleditor',
                    flex: 1,
                    id: 'notepad-editor',
                    value: panelWin.items.items[0].getEl().dom.firstChild.innerHTML//getItemAt(0).getHtml()
                }
            ]
        });
        win.show();
    },
    
    edit : function (idn) {
        var desktop = this.app.getDesktop();
        panelWin = desktop.getWindow(idn);
        win = desktop.createWindow({
            id: 'notepad',
            title:window.editnote || 'Редагувати запис',//'Add new note',
            width:600,
            height:400,
            x: panelWin.x,
            y: panelWin.y,
            iconCls: 'notepad',
            animCollapse:false,
            border: false,
            //defaultFocus: 'notepad-editor', EXTJSIV-1300

            // IE has a bug where it will keep the iframe's background visible when the window
            // is set to visibility:hidden. Hiding the window via position offsets instead gets
            // around this bug.
            hideMode: 'offsets',
            bbar: [
                { 
                    xtype: 'button',
                    text: window.applychanges || 'Застосувати зміни',
                    listeners: {
                        click: {
                            scope: this,
                            fn: function() {
                                var data = {
                                    id    : idn,
                                    title : this.ps(Ext.getCmp('title-editor').getValue()),
                                    x     : this.app.getDesktop().getWindow('notepad').x,
                                    y     : this.app.getDesktop().getWindow('notepad').y,
                                    text  : this.ps(Ext.getCmp('notepad-editor').getValue())
                                };
                                Ext.Ajax.request({
                                    url: 'es.php',
                                    params: {
                                        id: idn,
                                        hashtag: window.userid,
                                        text: this.ps(Ext.getCmp('notepad-editor').getValue()),
                                        title:this.ps(Ext.getCmp('title-editor').getValue()),
                                        x:this.app.getDesktop().getWindow('notepad').x,
                                        y:this.app.getDesktop().getWindow('notepad').y
                                    },
                                    scope: this.app,
                                    success: function (response){
                                        var destinationWin = this.getDesktop().getWindow(idn);
                                        if (destinationWin && !destinationWin.destroyed) {
                                            destinationWin.destroy();
                                        }
                                        this.getModule("notepad").showPanel(data, 'background-color:yellow;', {
                                            showDuplicateButton : false,
                                            showEditButton      : true,
                                            showRemoveButton    : true
                                        });
                                    }
                                });
                                this.app.getDesktop().getWindow('notepad').close();
                            }
                        }
                    }
                }
            ],
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            items: [
                {
                    xtype: 'panel',
                    
                    layout: {
                        type: 'hbox',
                        align: 'stretch'
                    },
                    items: [
                        {
                            html: window.titletext || 'Заголовок:'
                        },
                        {
                            xtype: 'textfield',
                            id: 'title-editor',
                            value: panelWin.title//getTitle()
                        }
                    ]
                },
                {
                    xtype: 'htmleditor',
                    flex: 1,
                    id: 'notepad-editor',
                    value: panelWin.items.items[0].getEl().dom.firstChild.innerHTML//getItemAt(0).getHtml()
                }
            ]
        });
        win.show();
    },
    
    remove : function (idn) {
        Ext.Msg.confirm(window.removenotetitle || "Агов!", window.removenotetext || "Чи Ви справді бажаєте видалити цей милий і прекрасний запис? Цю дію не можна скасувати.", function(button) {
            if (button === 'yes') {
                Ext.Ajax.request({
                    url: 'rs.php',
                    params: {
                        id: idn
                    },
                    scope: this.app,
                    success: function(response){
                        var destinationWin = this.getDesktop().getWindow(idn);
                        if (destinationWin && !destinationWin.destroyed) {
                            destinationWin.destroy();
                        }
                    }
                });
            }
        }, this);
        
    },
    
    showPanel : function (data, bodyStyle, options) {
        var toolsConfig = [];
        if (options) {
            if (options.showDuplicateButton) {
                toolsConfig.push({
                    type:'plus',
                    tooltip: window.duplicate || 'Дублювати',//'Редагувати',
                    scope:this.app,
                    handler: function(event, toolEl, panel){
                        this.getModule("notepad").duplicate(panel.ownerCt.id);// refresh logic
                    }
                });
            }
            if (options.showEditButton) {
                toolsConfig.push({
                    type:'gear',
                    tooltip: window.edit || 'Редагувати',
                    scope:this.app,
                    handler: function(event, toolEl, panel){
                        this.getModule("notepad").edit(panel.ownerCt.id);// refresh logic
                    }
                });
            }
            if (options.showRemoveButton) {
                toolsConfig.push({
                    type:'minus',
                    tooltip: window.remove || 'Видалити',
                    scope:this.app,
                    handler: function(event, toolEl, panel){
                        this.getModule("notepad").remove(panel.ownerCt.id);// show help here
                    }
                });
            }
        }
        var ww = this.app.getDesktop().createWindow({
            id:data.id,
            title:data.title,
            x:data.x,
            y:data.y,
            minWidth: 100,
            minHeight: 40,
            iconCls:null,
            animCollapse:false,
            constrainHeader:true,
            layout:'fit',
            tools:toolsConfig,
            items:{
                bodyStyle: bodyStyle,
                html:data.text,
                autoScroll:true
            }
        });
        ww.show();
    }
});
