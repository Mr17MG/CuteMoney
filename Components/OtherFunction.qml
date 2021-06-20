import QtQuick 2.12

QtObject {
    function getFontSize(a,window){
        return getWidthSize(a,window);
    }
    function getHeightMargin(window){
        var heightRatio = 667/window.height;
        var widthRatio = 375/window.width;
        if(heightRatio<widthRatio){
            return (window.height - 667 / widthRatio) /2
        }
        return 0;
    }
    function getWidthMargin(window){
        var heightRatio = 667/window.height;
        var widthRatio = 375/window.width;
        if(heightRatio>widthRatio){
            return (window.width - 375 / heightRatio) /2
        }
        return 0;
    }
    function getHeightSize(size,window){
        var newSize = size / (667 / (window.height-getHeightMargin(window)*2));
        return newSize;
    }
    function getWidthSize(size,window){
        var newSize = size / (375 / (window.width-getWidthMargin(window)*2));
        return newSize;
    }

    function findListModel(model, criteria,isData) {
        for(var i = 0; i < model.count; ++i)
            if (criteria(model.get(i)))
            {
                if(isData)
                    return model.get(i);
                else return i;
            }
        return null
    }
    function findUserName(username){
        var personIndex = findListModel(allPersonList,function(model){return username===model.UserName},false)
        return {index: personIndex,value:allPersonList.get(personIndex)};
    }
    function findPID(pId){
        var projectIndex = findListModel(projectListModel,function(model){return pId===model.Id},false)
        return {index: projectIndex,value:projectListModel.get(projectIndex)};
    }
    function findTaskID(taskId){
        var taskIndex = findListModel(taskListModel,function(model){return taskId===model.Id},false)
        return {index: taskIndex,value:taskListModel.get(taskIndex)};
    }
    function showMessageBox(message,msgTitle,callback) {
        var component = Qt.createComponent("qrc:/Components/MessageDialog.qml")
        if(component.status === Component.Ready) {
            var dialog = component.createObject(rootWindow)
            if(msgTitle)
                dialog.msgTitle = msgTitle
            dialog.text = message
            if(callback)
                dialog.callback = callback;
            dialog.open()
        } else
            console.error(component.errorString())
    }
    function showErrorLog(message,isError,parent,y) {
        var component = Qt.createComponent("qrc:/Components/ErrorLog.qml")
        if(component.status === Component.Ready) {
            var error = component.createObject(parent?parent:rootWindow)
            error.text = message
            error.isError = isError
            error.y = y?y:0
            error.show()
        } else
            console.error(component.errorString())
    }
    function faToEnNumber(num){
        num = num.replace(/۰/ig,'0')
        num = num.replace(/۱/ig,'1')
        num = num.replace(/۲/ig,'2')
        num = num.replace(/۳/ig,'3')
        num = num.replace(/۴/ig,'4')
        num = num.replace(/۵/ig,'5')
        num = num.replace(/۶/ig,'6')
        num = num.replace(/۷/ig,'7')
        num = num.replace(/۸/ig,'8')
        num = num.replace(/۹/ig,'9')
        return num
    }
    function getProfileImagePath(width,height,PersonId){
        if(PersonId)
            return (domain+"/MedicalService/resources/images/Profile/"+PersonId+"/"+Math.round( width)+"/"+Math.round(height));
        if(person.PersonId)
            return (domain+"/MedicalService/resources/images/Profile/"+person.PersonId+"/"+Math.round( width)+"/"+Math.round(height));
        return "";
    }
    function currencyFormat(price){
        return price.toFixed(1).replace(/\d(?=(\d{3})+\.)/g, '$&,').replace('.0','');
    }
}
