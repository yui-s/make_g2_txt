# README
保守_朝会メモお役立ちツールを使用するまえに一読してね  

## Dependency
ruby 2.6.1
* 参考
[Rubyの実行環境構築 on Windows](https://qiita.com/3no3_tw/items/8c0bcf258370d91bf6e0)

## Usage

### 使う前に
保守朝会前に、保守inspirXの案件一覧からCSV出力しよう！  
取得したCSVは /保守_朝会メモお役立ちツール/issueCsvExport 配下に格納するよ。  
顧客データとかモリモリだから、朝会メモ生成後は速やかに削除してね  

保守_朝会メモお役立ちツール  
├──README.md  
├── make_txt.rb  
├── issueCsvExport  
　　　└──**issueCsvExport_xxx_xxxx（取得したCSV）**  
└── 過去朝会メモ  


### 新規に保守朝会メモを作成する場合

1. make_txt.rbを実行する前に、issueCsvExportフォルダに案件csvが格納されていることを確認する  
2. make_txt.rbを実行する際に、コマンドライン引数に作成する朝会メモの日時を`YYYYMMDD new`の形式で渡す   
ex.) ruby make_txt.rb 20190403 new
3. /保守_朝会メモお役立ちツール 配下に`朝会メモ_YYYYMMDD.txt`が出力されていることを確認する  


### 前回の保守朝会メモが存在する場合

保守_朝会メモお役立ちツール  
├──README.md  
├── make_txt.rb  
├── issueCsvExport  
│ 　　 └── **issueCsvExport_xxx_xxxx（取得したCSV）**  
└── 過去朝会メモ  
　　　　└── **朝会メモ_yyyymmdd (前回の保守朝会メモ)**  

1. 前回の朝会メモを /保守_朝会メモお役立ちツール/過去朝会メモ 配下に格納する  
2. issueCsvExportフォルダに案件csvが格納されていることを確認する  
2. make_txt.rbを実行する際に、コマンドライン引数に作成する朝会メモの日時を`YYYYMMDD`の形式で渡す  
ex.) ruby make_txt.rb 20190403
3. /保守_朝会メモお役立ちツール 配下に`朝会メモ_YYYYMMDD.txt`が出力されていることを確認する


## Authors
y-sasaki@
