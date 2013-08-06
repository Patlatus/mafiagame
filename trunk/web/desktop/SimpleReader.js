Ext.define('MyDesktop.SimpleReader', {
    singleton: true,
    read : function (xhr) {
        var result = Ext.decode(xhr.responseText);
        window.userLogged = result.success;
        if (result.success) {
            window.username = result.username;
            window.userid = result.userid;
            window.resultMessage = result.message;
        }
        return {
            success : result.success,
            records: []
        }
    }
});