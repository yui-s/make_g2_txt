# encoding : utf-8
# coding: utf-8
#! ruby -EUTF-8
require 'csv'
require 'kconv'

HEADER_TO_SYM_MAP = {
  '案件ID' => :id,
  '登録日時' => :regist_date,
  '更新日時' => :update_date,
  '担当者' => :operator,

  '状態' => :status,
  '顧客>外部システムキー' => :customer,
  'プロジェクト' => :project,
  'コンタクト履歴' => :contact,
}

def make_data(*issue)
  new_data = ""

  #csvを読みこんで朝会議事メモ用に情報整形していく
  Dir.glob('./issueCsvExport/*.csv').each do |csv_file_name|
    header_converter = lambda { |h| HEADER_TO_SYM_MAP[h] }
    csv = CSV.read(csv_file_name, headers: :first_row, header_converters: header_converter, converters: :integer, skip_blanks: true, encoding: "CP932:UTF-8")
    new_data << "<"+ARGV[0]+">の共通保守朝会内容を共有致します。（新着順）\n書記担当：\n"
    csv.each do |data|
      new_data << "--------------------------------------------------------------------------\n"
      project_code = ("#{data[:project]}").split(":")
      header_line = "案件ID: #{data[:id]} ("+project_code[0]+")  #{data[:status]} : #{data[:update_date]} \n\n"
      new_data <<  header_line
      new_data << "◆議事メモ:\n"
      new_data << ARGV[0]+":\n"

      #前回の朝会議事メモと照合して案件IDが既に記されているなら過去の議事メモを新議事メモに移す
      issue.each do |line|
        if line.include?("#{data[:id]}") then
          last_memo = line.split("◆議事メモ:\n")
          unless last_memo[1].nil?
            new_data << last_memo[1].to_s
          end
          break
        end
      end
      new_data << "\n"
    end
    new_data << "--------------------------------------------------------------------------\n"
  end
  return new_data
end

if ARGV.one? then
  # 過去朝会メモフォルダ配下の生成日が最新のテキスト＝前回の朝会議事メモ＝LAST_FILE_NAME
  files = Dir.glob('./過去朝会メモ/*.txt').sort_by { |fn| File.birthtime(fn) }
  LAST_FILE_NAME = files[files.size-1]
  #前回の朝会議事メモを読み込んでissueに格納する
  last_file = open(LAST_FILE_NAME, 'r:BOM|UTF-8')
    issue = last_file.read.split("\n--------------------------------------------------------------------------\n")
    data = make_data(*issue)
  last_file.close
else
  # 新規作成の場合
  issue = []
  data = make_data(issue)
end

NEW_FILE_NAME = "朝会メモ_"+ARGV[0]+".txt"
File.open(NEW_FILE_NAME,'w',encoding:'UTF-8') do |txt|
  txt.puts data
end
