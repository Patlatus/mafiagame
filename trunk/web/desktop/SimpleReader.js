Ext.define('MyDesktop.SimpleReader', {
    singleton: true,
    read : function (xhr) {
        var result = Ext.decode(xhr.responseText);
        window.userLogged = result.success;
        window.resultMessage = result.message;
        if (result.success) {
            window.username = result.username;
            window.userid = result.userid;
        }
        return {
            success : result.success,
            records: []
        }
    }
});