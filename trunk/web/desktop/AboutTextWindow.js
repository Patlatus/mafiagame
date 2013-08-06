Ext.define('MyDesktop.AboutTextWindow', {
   extend:'Ext.ux.desktop.Module',
   requires:['Ext.panel.Panel'],
   id:'abouttext-win',
   t:'Text information about',
   ic:'icon-abouttext',
   win:null,
   init:function(){
		this.launcher={
			text:this.t,
			iconCls:this.ic
		};
	},
	createWindow:function(){
		var desktop=this.app.getDesktop();
		var win=desktop.getWindow(this.id);
		if(!win){
			win=desktop.createWindow({
				id:this.id,
				title:this.t,
				width:710,
				minWidth:330,
				height:500,
				minHeight:330,
				iconCls:this.ic,
				animCollapse:false,
				constrainHeader:true,
				layout:'fit',
				items:{
					html:"Hello! My name is Bohdan. This is my personal website, this implies I'm the author of it.<br>So, wellcome to my site. You probably wonder why did I choose default wallpaper with Eliza Dushku.<br> Well, I just like this actress and I had for a long time wallpaper with her on my real desktop.<br>About this site. It is nothing special, just a slightly modified example of Web Desktop Sample by Sencha.<br>About myself. I live in Lviv, Ukraine, but I don't mind moving to USA.<br>I am mathematician and programmer, developer. Also I am Ph.D. student.<br>Currently I'm finishing my Ph.D. studies and would like to defend my Ph.D. thesis as soon as possible<br>to dedicate myself completely to programming and developing applications.<br>I have been writing programs from my childhood. My first programs were quite simple, written on Pascal for DOS.<br>Later on I started writing programs on Delphi for Windows operating system <br>and I wrote many non-profitable and non-commercial applications.<br>During my study at the university I was helping to write applications and explaining how to write programs <br>to every student, both older and younger than me.<br>Then I was employed at my first IT company where I was taught to copypaste code and not to invent a bicycle.<br>This was my first commercial experience. I used there Delphi as programming language, <br>MS SQL Server as  relational database management system and SVN as Subversion client System.<br>Later on I moved to another company  where we were developing a lot of optimization algorythms for Ukrainian Railway<br>and for Ukrainian Gas and Oil System.<br>After that  I entered postgraduate studies.<br>Recently I was employed at another IT company, where I received commercial experience of developing web applications<br>on Java as server language of IBM WebSphere server, JavaScript as client language using jQuery and Ext JS frameworks.<br>Also I developed numerous non-profitable and non-commercial sites using simple primitive HTML, CSS, somewhere I used PHP<br>as server language and MySQL as relational database management system.<br>I have a dream to adapt all my old Delphi applications to both mobile and web platforms. <br>By mobile platforms I mean Android, Windows Phone 7, maybe iPhone.<br>And by web platforms I mean client JS frameworks like jQuery and Ext JS.<br>By the way, if you noticed, this site has actually one of my old Delphi applications adapted for a web called Matches.<br>Also I supervise work of two my friends, I teach one of them to develop applications on Java and  Android SDK Tools,<br>and I teach another one how to write applications on C++, C# and Windows Phone 7 SDK.<br>Also I won a lot of competitions and olympiads, for example I received this gold medal from Ariel University of Samaria.<br>Have you seen it? I won it in Fifth Internet Olympiad. Full list of my achievements is provided in my CV.<br>Ok, I think that's enough. Thank you for your time and your attention. Best regards. Bye.",
					autoScroll:true
				}
			});
		}
		return win;
	}
});