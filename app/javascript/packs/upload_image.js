if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function(){
    const imageList = document.getElementById('image-list');
    // ファイル選択後にイベント発火
    document.getElementById('image-upload').addEventListener('change', function(e){
      // サムネ画像が表示されている場合、既にあるサムネを削除する
      const imageContent = document.getElementById('thumbnail');
      if (imageContent){
        imageContent.remove();
      }
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      // 画像表示用のdiv要素と、img要素を生成→img要素に画像URLをセット
      const imageElement = document.createElement('div');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('id', 'thumbnail');
      // 上記で生成した各要素を入れ子構造にしてブラウザに表示
      imageElement.appendChild(blobImage);
      imageList.appendChild(imageElement);
    });
  });
}