Ext.define('MyDesktop.App', {
    extend: 'Ext.ux.desktop.App',
    requires: 
        ['Ext.window.MessageBox',
        'Ext.form.Panel',
        'Ext.data.reader.Json',
        'Ext.data.Store',
        'Ext.ux.desktop.ShortcutModel',
        'Ext.ux.desktop.Desktop',
        'MyDesktop.SystemStatus',
        'MyDesktop.VideoWindow',
        'MyDesktop.AboutTextWindow',
        'MyDesktop.Notepad',
        'MyDesktop.SimpleReader',
        'MyDesktop.RegistrationForm',
        'MyDesktop.LoginForm',
        'MyDesktop.Settings'],
    getModules : function(){
        return [
            new MyDesktop.Notepad()
        ];
    },
    
    getDesktopConfig:function () {
        var me = this,ret = me.callParent();
        return Ext.apply(ret, {
            contextMenuItems: [{
                text:window.changesettings || 'Змінити налаштування',
                handler:me.onSettings,
                scope:me
            }],
            shortcuts: Ext.create('Ext.data.Store', {
                model:'Ext.ux.desktop.ShortcutModel',
                data: []
            }),
            wallpaper: 'wallpapers/isus-wallpaper.jpg',
            wallpaperStretch:false
        });
    },
    
    getStartConfig :function() {
        var me  = this,
            ret = me.callParent();
        return Ext.apply(ret, {
            title: window.username,
            iconCls: 'user',
            height: 300,
            toolConfig: {
                width: 120,
                items: [{
                    text:window.settings || 'Налаштування',
                    iconCls:'settings',
                    handler:me.onSettings,
                    scope:me
                },
                '-',
                {
                    text:(window.logoutlabel || 'Вийти'),
                    iconCls:'logout',
                    handler:me.onLogout,
                    scope:me
                }]
            }
        });
    },
    
    getTaskbarConfig:function () {
        var ret = this.callParent();
        return Ext.apply(ret, {
            quickStart: [{
                name:window.addnote || 'Додати запис',
                iconCls:'notepad',
                module:'notepad'
            }],
            trayItems:[{ 
                xtype:'trayclock',
                flex:1
            }]
        });
    },
    
    write : function (text) {
        if (window.console) {
            console.log(text);
        }
    },
    
    updateUserLanguage : function () {
        if (window.languagesHash[window.currentLanguage] === 'present') {
            
        } else {
            if (window.languagesArray.length > 0) {
                this.write(["I'm sorry, but language '", window.currentLanguage, "' isn't present in configured languages collection. Try to configure it or don't use browser which has not configured language"].join(''));
                window.currentLanguage = window.languagesArray[0];
            } else {
                this.write("I'm sorry, but configured languages collection is empty. Try to configure it and add some languages nodes");
                delete window.currentLanguage;
                return;
            }
        }
        Ext.Ajax.request({
            url: window.currentLanguage + '.xml',
            params: {
                
            },
            success: Ext.bind(function(response) {
                if (response && response.responseXML && response.responseXML.childNodes) {
                    var root = response.responseXML.childNodes[Ext.isIE ? 1 : 0];
                    if (root && root.nodeName === 'root') {
                        var currentNode = Ext.isIE ? root.firstChild : root.firstElementChild;
                        while (currentNode) {
                            window[currentNode.nodeName] = Ext.isIE ? currentNode.text : currentNode.textContent;
                            currentNode = Ext.isIE ? currentNode.nextSibling : currentNode.nextElementSibling;
                        }
                    }
                }

                var isInitialized = window.regForm && window.loginForm;
                if (!isInitialized) {
                    window.regForm = MyDesktop.RegistrationForm;
                    window.regForm.update();
                    window.regForm.render(Ext.getBody());
                    
                    window.loginForm = MyDesktop.LoginForm;
                    window.loginForm.update();
                    window.loginForm.render(Ext.getBody());
                    if (window.userLogged) {
                        myDesktopApp.init();
                    } else {
                        window.loginForm.show();
                    }
                } else {
                    window.regForm.update();
                    window.loginForm.update();
                }
            })
        });
    },
        
    beforeinit : function () {
        window.settingsLoaded = false;
        window.userLoaded = false;
        window.WallpaperManager = {
            setWallpaper : function (url) {
                Ext.getBody().setStyle({
                    backgroundImage: ['url(',url,')'].join('')
                });
            }
        };
        WallpaperManager.setWallpaper('wallpapers/isus-wallpaper.jpg');
        Ext.Ajax.request({
            url: 'settings.xml',
            params: {
                
            },
            success: Ext.bind(function(response){
                window.languagesArray = [];
                window.languagesHash = {};
                window.languagesNames = {};
                if (response && response.responseXML && response.responseXML.childNodes) {
                    var root = response.responseXML.childNodes[Ext.isIE ? 1 : 0];
                    if (root && root.nodeName === 'root') {
                        var languages = Ext.isIE ? root.firstChild : root.firstElementChild;
                        if (languages && languages.nodeName === 'languages') {
                            currentLanguageNode = Ext.isIE ? languages.firstChild : languages.firstElementChild;
                            while (currentLanguageNode) {
                                window.languagesArray.push(currentLanguageNode.nodeName);
                                window.languagesHash[currentLanguageNode.nodeName] = 'present';
                                window.languagesNames[currentLanguageNode.nodeName] = Ext.isIE ? currentLanguageNode.text : currentLanguageNode.textContent;
                                currentLanguageNode = Ext.isIE ? currentLanguageNode.nextSibling : currentLanguageNode.nextElementSibling;
                            }
                        }
                    }
                }
                window.settingsLoaded = true;

                if (window.userLoaded) {
                    myDesktopApp.updateUserLanguage();
                }
            }, this)
        });
        
        Ext.Ajax.request({
            url: 'cl.php',
            params: {
                
            },
            success: Ext.bind(function(response){
                var text = response.responseText;
                try{
                var decodedText = Ext.decode(text)
                }
                catch (e) {
                    alert((window.alertmessage1 || 'Error during decoding text:') + '\n' + text);
                }
                window.userLoaded = true;
                window.userLogged = decodedText.success;
                window.currentLanguage = (window.navigator.userLanguage || window.navigator.systemLanguage || window.navigator.language || 'en').substr(0, 2);
                if (decodedText.success) {
                    window.username = decodedText.username;
                    window.userid = decodedText.userid;
                }
                if (window.settingsLoaded) {
                    myDesktopApp.updateUserLanguage();
                }
            }, this)
        });
    },
    
    init : function () {
        this.callParent(arguments);
        Ext.Msg.buttonText.yes = window.yes || 'Так';
        Ext.Msg.buttonText.no = window.no || 'Ні';
        
        this.loadStickers('gn.php', window.userid, 0, 50, 'background-color:yellow;', {
            showDuplicateButton : false,
            showEditButton      : true,
            showRemoveButton    : true
        });
        
        this.loadStickers('gn.php', 'default', 200, 100, 'background-color:00ff00;', {
            showDuplicateButton : true,
            showEditButton      : false,
            showRemoveButton    : false
        });
    },
    
    loadStickers : function (url, hashtag, defX, defYShift, bodyStyle, options) {
        var xStore = Ext.create('Ext.data.Store', {
            fields: [
                {name: 'id', type: 'int'},
                {name: 'text', type: 'string'},
                {name: 'title', type: 'string'},
                {name: 'x', type: 'int'},
                {name: 'y', type: 'int'},
                {name: 'hashtag', type: 'string'}
            ],
            autoLoad: true
        });
        Ext.Ajax.request({
            url: url,
            params: {
                hashtag: hashtag
            },
            success: Ext.bind(function(response){
                var text = response.responseText;
                try {
                    var decodedText = Ext.decode(text)
                }
                catch (e) {
                    alert((window.alertmessage1 || 'Error during decoding text:') + '\n' + text);
                }
                this.write('text:\n' + text);
                this.write('decodedText:\n' + decodedText);
                xStore.loadData(decodedText);
               
                
                for (var i = 0; i < xStore.data.items.length; i++) {
                    var data = xStore.data.items[i].data;
                    if (data.x === null || data.x === undefined) {
                        data.x = defX;
                    }
                    if (data.y === null || data.y === undefined) {
                        data.y = i * defYShift;
                    }
                    this.getModule("notepad").showPanel(data, bodyStyle, options);
                }
            }, this)
        });
    },
    
    onSettings:function () {
        var dlg = new MyDesktop.Settings({
            desktop:this.desktop
        });
        dlg.show();
    },
    
    onLogout : function () {
        Ext.Ajax.request({
            url: 'lo.php',
            params: {
                
            },
            success: Ext.bind(function(response){
                myDesktopApp.shutdown();
                loginForm.show();
            })
        });
    }
});