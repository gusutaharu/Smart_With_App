os_array = ['iOS(apple製のOS)', 'Android(Google製のOS)', 'その他のOS']
condition_array = ['App・アプリ','OSのアップデート', 'データ・バックアップ', '設定', '機能', '画面の映像', '画面タッチ', 'ボタン・スイッチ', 'カメラ', '本体が熱を持つ', '動きが遅い・フリーズする', '損傷・破損', '液体との接触・水没', '通信', '通話', 'パスワード', 'ロックの解除・指紋や顔での認証', 'バッテリー・充電', '再起動する・電源が入らない', 'その他' ]

smart_phone = Category.create(name: 'スマートフォン')
tablet = Category.create(name: 'タブレット')
Category.create(name: 'アクセサリー/その他')

os_array.each do |name|
  os = smart_phone.children.create(name: name)
  condition_array.each do |name|
    os.children.create(name: name)
  end
end

os_array.each do |name|
  os = tablet.children.create(name: name)
  condition_array.each do |name|
    os.children.create(name: name)
  end
end
