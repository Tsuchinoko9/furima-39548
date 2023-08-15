const pay = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey)
  const elements = payjp.elements();
  // elements.create()メソッドで入力フォームを作成
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // mountメソッドの引数で要素のid属性を指定し、指定した要素とelementインスタンスが情報を持つフォームとを置き換える
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    // createToken(element: Element, options?: object)メソッドでトークン化の処理を実装
    // then以降に、レスポンスを受け取ったあとの処理を記述
    // 変数responseには、PAY.JP側からのレスポンスとステータスコードが含まれる
    // response.idとすることでトークンの値を取得することができる
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        // JavaScriptでinput要素を生成しフォームに加え、その値としてトークンをセット
        const renderDom = document.getElementById("charge-form");
        // type="hidden"とすることでトークンの値を非表示にする
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        // insertAdjacentHTMLメソッド(JavaScriptのDOM操作用メソッド)で、フォームの中に作成したinput要素を追加
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // クレジットカードの情報を削除
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      // フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
    });
    // 通常のRuby on Railsにおけるフォーム送信処理をキャンセル
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);