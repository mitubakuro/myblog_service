if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function(){
    const speech = new webkitSpeechRecognition();
    speech.lang = 'ja-JP';
    
    //使用する変数を用意
    const btn = document.getElementById('sound_btn');
    const content = document.getElementById('body');
    
    
    btn.addEventListener('click' , function() {
      // 音声認識をスタート
      speech.start();
    });
    //音声自動文字起こし機能
      speech.onresult = function(e) {
        speech.stop();
        if(e.results[0].isFinal){
            let autotext =  e.results[0][0].transcript
            console.log(e);
            console.log(autotext);
            content.innerHTML += '<div>'+ autotext +'</div>';
      }
    }

  speech.onend = () => { 
     speech.start() 
  };
      
  });
}
