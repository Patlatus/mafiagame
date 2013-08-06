Ext.define('MyDesktop.LoginForm', {
    extend: 'Ext.window.Window',
    requires: [
        'MyDesktop.SimpleReader',
        'Ext.layout.container.Fit',
        'Ext.form.Panel',
        'Ext.form.field.ComboBox',
        'Ext.data.AbstractStore'
    ],
    singleton: true,
    title: (window.logformtitle || 'Форма логування'),
    width: 250,

    hidden: true,
    closable: false,
    border: false,
    layout:'fit',

    items: {
        xtype: 'form',
        bodyCls : 'x-window-body-default',
        bodyPadding: 5,
        // The form will submit an AJAX request to this URL when submitted
        url: 'login.php',
        // Fields will be arranged vertically, stretched to full width
        layout: 'anchor',
        defaults: {
            anchor: '100%'
        },
        errorReader : MyDesktop.SimpleReader,

        defaultType: 'textfield',
        fieldDefaults: {
            labelWidth: 80,
            msgTarget : 'side'
        },
        items: [{
            fieldLabel: (window.usernamelabel || 'Юзернейм'),
            id: 'username',
            name: 'username',
            allowBlank: false
        },{
            fieldLabel: (window.passwordlabel || 'Пароль'),
            id: 'password',
            name: 'password',
            inputType: 'password',
            allowBlank: false
        },{
            fieldLabel: (window.languagelabel || 'Мова'),
            id: 'language',
            name: 'language',
            xtype: 'combo',
            store: {
                fields:['code', 'name']
            },
            displayField: 'name',
            valueField: 'code',
            queryMode: 'local',
            forceSelection: true,
            allowBlank: false
        }],
        // Reset and Submit buttons
        buttons: [{
            text: (window.reglabel || 'Зареєструватися'),
            id: 'regbutton',
            handler: function() {
                loginForm.hide();
                regForm.show();
            }
        }, {
            text: (window.loglabel || 'Залогуватися'),
            id: 'logbutton',
            formBind: true, //only enabled once the form is valid
            disabled: true,
            handler: function() {
                var form = this.up('form').getForm();
                if (form.isValid()) {
                    form.submit({
                        params: {
                            language: window.currentLanguage
                        },
                        success: function(form, action) {
                            loginForm.hide();
                            Ext.Msg.alert((window.successtitle || 'Success'), window.resultMessage);
                            myDesktopApp.init();
                        },
                        failure: function(form, action) {
                            Ext.Msg.alert((window.failedtitle || 'Failed'), window.resultMessage);
                        }
                    });
                }
            }
        }]
    },
    
    update : function () {
        this.setTitle(window.logformtitle || 'Форма логування'),
        Ext.getCmp('username').setFieldLabel(window.usernamelabel || 'Юзернейм');
        Ext.getCmp('password').setFieldLabel(window.passwordlabel || 'Пароль');
        Ext.getCmp('regbutton').setText(window.reglabel || 'Зареєструватися');
        Ext.getCmp('logbutton').setText(window.loglabel || 'Залогуватися');
        this.languageCombo = Ext.getCmp('language');
        this.languageCombo.setFieldLabel(window.languagelabel || 'Мова');
        var data = [];
        for (var i = 0; i < languagesArray.length; i++) {
            var languageCode = languagesArray[i];
            var languageName = languagesNames[languageCode];
            data.push({'code':languageCode,'name':languageName});
        }
        if (!this.languageComboLoaded) {
            this.languageCombo.getStore().loadData(data);
            this.languageComboLoaded = true;
            this.languageCombo.setValue(currentLanguage);
            this.languageCombo.on('change', this.languageChange, this);
        }
    },
    
    languageChange : function (field, newValue, oldValue, opts) {
        window.currentLanguage = newValue;
        myDesktopApp.updateUserLanguage();
    }
});