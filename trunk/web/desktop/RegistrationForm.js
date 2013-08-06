Ext.define('MyDesktop.RegistrationForm', {
    extend: 'Ext.window.Window',
    requires: [
        'MyDesktop.SimpleReader',
        'Ext.layout.container.Fit',
        'Ext.form.Panel'
    ],
    singleton: true,
    title: (window.regformtitle || 'Реєстраційна форма'),
    width: 350,

    hidden: true,

    closable: false,
    border: false,
    layout:'fit',
    items: {
        xtype: 'form',
        bodyCls: 'x-window-body-default',
        // Fields will be arranged vertically, stretched to full width
        bodyPadding: 5,
        // The form will submit an AJAX request to this URL when submitted
        url: 'signup.php',
        
        layout: 'anchor',
        defaults: {
            anchor: '100%'
        },
        errorReader : MyDesktop.SimpleReader,

        // The fields
        defaultType: 'textfield',
        fieldDefaults: {
            labelWidth: 130,
            msgTarget : 'side'
        },
        items: [{
            fieldLabel: (window.usernamelabel || 'Юзернейм'),
            id:'run',
            name: 'rusername',
            allowBlank: false
        },{
            fieldLabel: (window.passwordlabel || 'Пароль'),
            id:'rpw',
            name: 'rpassword',
            inputType: 'password',
            allowBlank: false
        },{
            fieldLabel: (window.passverlabel || 'Пароль(перевірка)'),
            id:'rpv',
            name: 'passverif',
            inputType: 'password',
            allowBlank: false
        },{
            fieldLabel: (window.emaillabel || 'Електронна пошта'),
            id:'re',
            name: 'email',
            vtype: 'email',
            allowBlank: false
        }],

        // Reset and Submit buttons
        buttons: [{
            text: (window.backlabel || 'Назад'),
            id:'rbb',
            handler: function() {
                regForm.hide();
                loginForm.show();
            }
        }, {
            text: (window.resetlabel || 'Очистити'),
            id:'rrb',
            handler: function() {
                this.up('form').getForm().reset();
            }
        }, {
            text: (window.signuplabel || 'Зареєструватися'),
            id:'rsb',
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
                            regForm.hide();
                            Ext.Msg.alert((window.successtitle || 'Success'), window.resultMessage, function() {loginForm.show()}, loginForm);
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
        this.setTitle(window.regformtitle || 'Реєстраційна форма'),
        Ext.getCmp('run').setFieldLabel(window.usernamelabel || 'Юзернейм');
        Ext.getCmp('rpw').setFieldLabel(window.passwordlabel || 'Пароль');
        Ext.getCmp('rpv').setFieldLabel(window.passverlabel || 'Пароль(перевірка)');
        Ext.getCmp('re').setFieldLabel(window.emaillabel || 'Електронна пошта');
        Ext.getCmp('rbb').setText(window.backlabel || 'Назад');
        Ext.getCmp('rrb').setText(window.resetlabel || 'Очистити');
        Ext.getCmp('rsb').setText(window.signuplabel || 'Зареєструватися');
    }
});