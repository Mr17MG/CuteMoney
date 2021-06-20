import QtQuick 2.12
QtObject {
    function getAllData()
    {
        dataBase.transaction(
                    function(tx){
                        try{
                            allData.clear()
                            outcomeData.clear()
                            incomeData.clear()
                            totalOutcome = 0
                            totalIncome = 0
                            var result = tx.executeSql('SELECT * FROM Datas' +" "+finder+" ORDER BY ModifyDate DESC");
                            for(var i=0;i<result.rows.length;i++){
                                var row = {
                                    "Id":result.rows.item(i).Id,
                                    "Amount":result.rows.item(i).Amount,
                                    "Title":result.rows.item(i).Title,
                                    "Type":result.rows.item(i).Type,
                                    "ModifyDate":result.rows.item(i).ModifyDate
                                }
                                allData.append(row);
                                if(row.Type === 1)
                                {
                                    totalIncome += Number(row.Amount)
                                    incomeData.append(row)
                                }
                                else
                                {
                                    totalOutcome += Number(row.Amount)
                                    outcomeData.append(row)
                                }
                            }

                        }
                        catch(e){
                            tx.executeSql('CREATE TABLE IF NOT EXISTS Datas
                                                (Id INTEGER PRIMARY KEY AUTOINCREMENT,
                                                 Amount TEXT DEFAULT "",
                                                 Title TEXT DEFAULT "",
                                                 Type INTEGER DEFAULT 0,
                                                 ModifyDate TEXT DEFAULT ""'
                                          +')');
                            console.log(e)
                        }
                    }
                    )
    }

    function insertData(amount,title,type,modifyDate){
        dataBase.transaction(
                    function(tx){
                        try{
                            tx.executeSql('INSERT INTO Datas(Amount,Title,Type,ModifyDate)VALUES(\''+amount+'\',\''+title+'\','+type+',\''+modifyDate+'\')');
                            getAllData()
                        }
                        catch(e){
                            console.log(e)
                        }
                    }
                    )
    }
    function updateData(id,amount,title,type,modifyDate)
    {
        dataBase.transaction(
                    function(tx){
                        try{
                            tx.executeSql('UPDATE Datas SET Amount =\''+amount+'\',Title=\''+title+'\',Type='+type+',ModifyDate=\''+modifyDate+'\' WHERE Id ='+id);
                            getAllData()
                        }
                        catch(e){
                            console.log(e)
                        }
                    }
                    )
    }
    function deleteData(id)
    {
        dataBase.transaction(
                    function(tx){
                        try{
                            tx.executeSql('DELETE FROM Datas WHERE id='+id);
                            getAllData()
                        }
                        catch(e){
                            console.log(e)
                        }
                    }
                    )
    }
}
