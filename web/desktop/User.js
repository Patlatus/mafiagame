Ext.define('MyDesktop.User', {
    singleton : true,
    
    setOnline : function () {
        Ext.Ajax.request({
            url: 'uu.php',
            params: {
                userid : window.userid,
                status : 1
            }
        });
    },
    
    setAway : function () {
        Ext.Ajax.request({
            url: 'uu.php',
            params: {
                userid : window.userid,
                status : 2
            }
        });
    },
    
    setOffline : function () {
        Ext.Ajax.request({
            url: 'uu.php',
            params: {
                userid : window.userid,
                status : 0
            }
        });
    }
});