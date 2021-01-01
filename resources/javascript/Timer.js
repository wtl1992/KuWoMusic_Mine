//设置setTimeout函数
function setTimeout(callback,timeout){
    let timer = Qt.createQmlObject("import QtQuick 2.14; Timer {}", window);
    timer.interval = timeout;
    timer.repeat = false;
    timer.triggered.connect(callback);
    timer.start();
}

//设置setInterval函数
function setInterval(callback,timeout){
    let timer = Qt.createQmlObject("import QtQuick 2.14; Timer {}", window);
    timer.interval = timeout;
    timer.repeat = true;
    timer.triggered.connect(callback);
    timer.start();
}


// 秒转换分钟00:00格式
function timeToMinute(times){
    let t = "";
    if(times > -1){
        let min = Math.floor(times/ 1000 / 60);
        let sec = Math.ceil(Math.floor((times % (1000 * 60)) / 1000));

        if(min < 10){
            t += "0";
        }

        t += min + ":";

        if (sec < 10){
            t += "0";
        }

        t += sec;
    }
    return t;

}
