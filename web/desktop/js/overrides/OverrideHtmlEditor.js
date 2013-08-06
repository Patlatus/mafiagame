Ext.define('MyDesktop.overrides.OverrideHtmlEditor', {
    override : 'Ext.form.field.HtmlEditor',
   
    /*
     * Called when the editor creates its toolbar. Override this method if you need to
     * add custom toolbar buttons.
     * @param {Ext.form.field.HtmlEditor} editor
     * @protected
     */
    createToolbar : function(editor){
        var me = this,
            items = [], i,
            tipsEnabled = Ext.tip.QuickTipManager && Ext.tip.QuickTipManager.isEnabled(),
            baseCSSPrefix = Ext.baseCSSPrefix,
            fontSelectItem, toolbar, undef;

        function btn(id, toggle, handler, iconId){
            return {
                itemId : id,
                cls : baseCSSPrefix + 'btn-icon',
                iconCls: baseCSSPrefix + 'edit-'+ (iconId || id),
                enableToggle:toggle !== false,
                scope: editor,
                handler:handler||editor.relayBtnCmd,
                clickEvent: 'mousedown',
                tooltip: tipsEnabled ? editor.buttonTips[id] || undef : undef,
                overflowText: editor.buttonTips[id].title || undef,
                tabIndex: -1
            };
        }


        if (me.enableFont && !Ext.isSafari2) {
            fontSelectItem = Ext.widget('component', {
                renderTpl: [
                    '<select id="{id}-selectEl" class="{cls}">',
                        '<tpl for="fonts">',
                            '<option value="{[values.toLowerCase()]}" style="font-family:{.}"<tpl if="values.toLowerCase()==parent.defaultFont"> selected</tpl>>{.}</option>',
                        '</tpl>',
                    '</select>'
                ],
                renderData: {
                    cls: baseCSSPrefix + 'font-select',
                    fonts: me.fontFamilies,
                    defaultFont: me.defaultFont
                },
                childEls: ['selectEl'],
                afterRender: function() {
                    me.fontSelect = this.selectEl;
                    Ext.Component.prototype.afterRender.apply(this, arguments);
                },
                onDisable: function() {
                    var selectEl = this.selectEl;
                    if (selectEl) {
                        selectEl.dom.disabled = true;
                    }
                    Ext.Component.prototype.onDisable.apply(this, arguments);
                },
                onEnable: function() {
                    var selectEl = this.selectEl;
                    if (selectEl) {
                        selectEl.dom.disabled = false;
                    }
                    Ext.Component.prototype.onEnable.apply(this, arguments);
                },
                listeners: {
                    change: function() {
                        me.relayCmd('fontname', me.fontSelect.dom.value);
                        me.deferFocus();
                    },
                    element: 'selectEl'
                }
            });

            items.push(
                fontSelectItem,
                '-'
            );
        }

        if (me.enableFormat) {
            items.push(
                btn('bold'),
                btn('italic'),
                btn('underline')
            );
        }

        if (me.enableFontSize) {
            items.push(
                '-',
                btn('increasefontsize', false, me.adjustFont),
                btn('decreasefontsize', false, me.adjustFont)
            );
        }

        if (me.enableColors) {
            items.push(
                '-', {
                    itemId: 'forecolor',
                    cls: baseCSSPrefix + 'btn-icon',
                    iconCls: baseCSSPrefix + 'edit-forecolor',
                    overflowText: editor.buttonTips.forecolor.title,
                    tooltip: tipsEnabled ? editor.buttonTips.forecolor || undef : undef,
                    tabIndex:-1,
                    menu : Ext.widget('menu', {
                        plain: true,
                        items: [{
                            xtype: 'colorpicker',
                            allowReselect: true,
                            focus: Ext.emptyFn,
                            value: '000000',
                            plain: true,
                            clickEvent: 'mousedown',
                            handler: function(cp, color) {
                                me.execCmd('forecolor', Ext.isWebKit || Ext.isIE ? '#'+color : color);
                                me.deferFocus();
                                this.up('menu').hide();
                            }
                        }]
                    })
                }, {
                    itemId: 'backcolor',
                    cls: baseCSSPrefix + 'btn-icon',
                    iconCls: baseCSSPrefix + 'edit-backcolor',
                    overflowText: editor.buttonTips.backcolor.title,
                    tooltip: tipsEnabled ? editor.buttonTips.backcolor || undef : undef,
                    tabIndex:-1,
                    menu : Ext.widget('menu', {
                        plain: true,
                        items: [{
                            xtype: 'colorpicker',
                            focus: Ext.emptyFn,
                            value: 'FFFFFF',
                            plain: true,
                            allowReselect: true,
                            clickEvent: 'mousedown',
                            handler: function(cp, color) {
                                if (Ext.isGecko) {
                                    me.execCmd('useCSS', false);
                                    me.execCmd('hilitecolor', color);
                                    me.execCmd('useCSS', true);
                                    me.deferFocus();
                                } else {
                                    me.execCmd(Ext.isOpera ? 'hilitecolor' : 'backcolor', Ext.isWebKit || Ext.isIE ? '#'+color : color);
                                    me.deferFocus();
                                }
                                this.up('menu').hide();
                            }
                        }]
                    })
                }
            );
        }

        if (me.enableAlignments) {
            items.push(
                '-',
                btn('justifyleft'),
                btn('justifycenter'),
                btn('justifyright')
            );
        }

        if (!Ext.isSafari2) {
            if (me.enableLinks) {
                items.push(
                    '-',
                    btn('createlink', false, me.createLink),
                    btn('createlinktargetblank', false, me.createLinkTargetBlank,'createlink')
                );
            }

            if (me.enableLists) {
                items.push(
                    '-',
                    btn('insertorderedlist'),
                    btn('insertunorderedlist')
                );
            }
            if (me.enableSourceEdit) {
                items.push(
                    '-',
                    btn('sourceedit', true, function(btn){
                        me.toggleSourceEdit(!me.sourceEditMode);
                    })
                );
            }
        }
        
        // Everything starts disabled.
        for (i = 0; i < items.length; i++) {
            if (items[i].itemId !== 'sourceedit') {
                items[i].disabled = true;
            }
        }

        // build the toolbar
        // Automatically rendered in AbstractComponent.afterRender's renderChildren call
        toolbar = Ext.widget('toolbar', {
            id: me.id + '-toolbar',
            ownerCt: me,
            cls: Ext.baseCSSPrefix + 'html-editor-tb',
            enableOverflow: true,
            items: items,
            ownerLayout: me.getComponentLayout(),

            // stop form submits
            listeners: {
                click: function(e){
                    e.preventDefault();
                },
                element: 'el'
            }
        });

        me.toolbar = toolbar;
    },
    
    replaceSelection : function(html) {
        var sel, range, node;

        if (typeof window.getSelection != "undefined") {
            // IE 9 and other non-IE browsers
            sel = window.getSelection();

            // Test that the Selection object contains at least one Range
            if (sel.getRangeAt && sel.rangeCount) {
                // Get the first Range (only Firefox supports more than one)
                range = window.getSelection().getRangeAt(0);
                range.deleteContents();

                // Create a DocumentFragment to insert and populate it with HTML
                // Need to test for the existence of range.createContextualFragment
                // because it's non-standard and IE 9 does not support it
                if (range.createContextualFragment) {
                    node = range.createContextualFragment(html);
                } else {
                    // In IE 9 we need to use innerHTML of a temporary element
                    var div = document.createElement("div"), child;
                    div.innerHTML = html;
                    node = document.createDocumentFragment();
                    while ( (child = div.firstChild) ) {
                        node.appendChild(child);
                    }
                }
                range.insertNode(node);
            }
        } else if (document.selection && document.selection.type != "Control") {
            // IE 8 and below
            range = document.selection.createRange();
            range.pasteHTML(html);
        }
    },


    createLinkTargetBlank : function(cmd, value){
        var me = this,
            doc = me.getDoc(),
            url = prompt(this.createLinkText, this.defaultLinkValue),
            range,
            html,
            selection,
            undef;
        if (!url) {
            return;
        }
        me.focus();
            
        html = '<a href="' + url + '" target=_blank ">' + me.win.getSelection() +'</a>';
        selection = me.win.getSelection();
        if (selection.getRangeAt && selection.rangeCount) {
            // Get the first Range (only Firefox supports more than one)
            range = selection.getRangeAt(0);
            range.deleteContents();

            // Create a DocumentFragment to insert and populate it with HTML
            // Need to test for the existence of range.createContextualFragment
            // because it's non-standard and IE 9 does not support it
            if (range.createContextualFragment) {
                node = range.createContextualFragment(html);
            } else {
                // In IE 9 we need to use innerHTML of a temporary element
                var div = document.createElement("div"), child;
                div.innerHTML = html;
                node = document.createDocumentFragment();
                while ( (child = div.firstChild) ) {
                    node.appendChild(child);
                }
            }
            range.insertNode(node);
        }
        
        //this.replaceSelection(html);    
                /*range = selection.getRangeAt(0);
                range.pasteHTML(html);//selectNodeContents(me.getEditorBody());
                //range.collapse(true);
                //me.deferFocus();
            */
            
        //range = doc.selection.createRange();
        /*if (range) { 
            //range.pasteHTML(html)
        } else {
            doc.body.innerHTML += html;//'<a href="' + url + '" target=_blank ">' + me.win.getSelection() +'</a>';
        }*/
        //doc.execCommand(cmd, false, value === undef ? null : value);
        me.syncValue();
        me.updateToolbar();
    },

    buttonTips : {
        bold : {
            title: 'Bold (Ctrl+B)',
            text: 'Make the selected text bold.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        italic : {
            title: 'Italic (Ctrl+I)',
            text: 'Make the selected text italic.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        underline : {
            title: 'Underline (Ctrl+U)',
            text: 'Underline the selected text.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        increasefontsize : {
            title: 'Grow Text',
            text: 'Increase the font size.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        decreasefontsize : {
            title: 'Shrink Text',
            text: 'Decrease the font size.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        backcolor : {
            title: 'Text Highlight Color',
            text: 'Change the background color of the selected text.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        forecolor : {
            title: 'Font Color',
            text: 'Change the color of the selected text.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        justifyleft : {
            title: 'Align Text Left',
            text: 'Align text to the left.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        justifycenter : {
            title: 'Center Text',
            text: 'Center text in the editor.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        justifyright : {
            title: 'Align Text Right',
            text: 'Align text to the right.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        insertunorderedlist : {
            title: 'Bullet List',
            text: 'Start a bulleted list.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        insertorderedlist : {
            title: 'Numbered List',
            text: 'Start a numbered list.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        createlink : {
            title: 'Hyperlink',
            text: 'Make the selected text a hyperlink.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        createlinktargetblank : {
            title: 'Hyperlink in new window',
            text: 'Make the selected text a hyperlink.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        sourceedit : {
            title: 'Source Edit',
            text: 'Switch to source editing mode.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        }
    }
});