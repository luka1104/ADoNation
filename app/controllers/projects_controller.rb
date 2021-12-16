class ProjectsController < ApplicationController
  def project
  end

  def index
    @projects = Project.all.order(created_at: :desc)
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find_by(id: params[:id])
    @user = @project.user
    @project_pvs_count = ProjectPv.where(project_id: @project.id).count
    @project_donated = @project_pvs_count * 5
    @current_user_ip = remote_ip()
    @count_limit = ProjectPv.where(created_date: Date.today, user_ip: @current_user_ip).count
  end

  def preview
    @project = Project.find_by(id: params[:id])
    @user = @project.user
    @project_pvs_count = ProjectPv.where(project_id: @project.id).count
    @project_donated = @project_pvs_count * 5
  end
  
  def create
    @project = Project.new(
      title: params[:title],
      user_id: current_user.id,
      description: params[:description],
      mainbody: "<div><strong>はじめに・ご挨拶<br></strong><br></div><div>信頼性を高めるため、ご本人もしくは実行チームの簡単な自己紹介を書きましょう。<br><br></div><div><br></div><div><strong>このプロジェクトで実現したいこと<br></strong><br></div><div>企画内容と目的を具体的かつ論理的に書きましょう。<br><br></div><div><br></div><div><strong>プロジェクトをやろうと思った理由<br></strong><br></div><div>プロジェクト立ち上げの背景や経緯を具体的に書きましょう。<br><br></div><div><br></div><div><strong>これまでの活動<br></strong><br></div><div>プロジェクトにつながる過去の活動や体験を書きましょう。<br><br></div><div><br></div><div><strong>資金の使い道<br></strong><br></div><div>集めた支援金用途や内訳を書きましょう。<br>CAMPFIRE手数料に使用されることも必ず記載しましょう。<br><br></div><div><br></div><div><strong>リターンについて<br></strong><br></div><div>リターンに関する説明や画像を載せましょう。<br><br></div><div><br></div><div><strong>実施スケジュール<br></strong><br></div><div>プロジェクト実施の計画を時系列で書きましょう。<br><br></div><div><br></div><div><strong>最後に<br></strong><br></div><div>応援したくなるような熱いメッセージを書きましょう。<br><br></div><div><br></div><div>＜プロジェクトオーナーについて（特商法上の表記）＞<br>※プロジェクトオーナーとして資金を集めるにあたり、特商法に基づき次の表記をお願いしております（法人、個人を問いません）。以下の雛形をご利用ください。<br><br></div><div>■特定商取引法に関する記載<br>&nbsp;●販売事業者名：XXXXXXXXX<br>&nbsp;※省略の場合には以下の文言をご記載ください。<br>&nbsp;「請求があり次第提供致しますので、必要な方はメッセージ機能にてご連絡ください。」<br>&nbsp;●代表者または通信販売に関する業務の責任者の氏名：・・・<br>&nbsp;※法人としてプロジェクトを起案する場合にのみご記載ください。<br>&nbsp;※個人としてプロジェクトを起案する場合（販売事業者が個人）は不要となります。<br>&nbsp;※省略の場合には以下の文言をご記載ください。<br>&nbsp;「請求があり次第提供致しますので、必要な方はメッセージ機能にてご連絡ください。」<br>&nbsp;●事業者の住所/所在地：〒123-4567 XXXXXXXXXX 1-1-1<br>&nbsp;※省略の場合には以下の文言をご記載ください。<br>&nbsp;「請求があり次第提供致しますので、必要な方はメッセージ機能にてご連絡ください。」<br>&nbsp;●事業者の電話番号：Tel: 010-1234-XXXX<br>&nbsp;※省略の場合には以下の文言をご記載ください。<br>&nbsp;「請求があり次第提供致しますので、必要な方はメッセージ機能にてご連絡ください。」<br>&nbsp;●送料：送料込み（離島価格など例外がある場合には記載）<br>&nbsp;●対価以外に必要な費用：プロジェクトページ、リターンに記載のとおり。<br>&nbsp;●ソフトウェアに係る取引である場合のソフトウェアの動作環境：該当なし / XXXXXXXXX<br>&nbsp;●その他記載事項：プロジェクトページ、リターン記載欄、共通記載欄（<a href=\"https://camp-fire.jp/legal%EF%BC%89%E3%82%92%E3%81%94%E7%A2%BA%E8%AA%8D%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84%E3%80%82\">https://camp-fire.jp/legal）をご確認ください。</a><br>あ<br><br></div><div><br></div><div>＜募集方式について＞<br>本プロジェクトはAll-in方式で実施します。目標金額に満たない場合も、計画を実行し、リターンをお届けします。a<br><br></div>",
      asp_money: params[:asp_money],
      end_date: params[:end_date],
      category: params[:category],
      area: params[:area]
    )
    if @project.save
      session[:project_id] = @project.id
      flash[:notice] = "投稿を完了しました"
      redirect_to(project_path(id: @project.id))
    else
      @project.errors.full_messages.each do |message|
        flash[:notice] = "#{message}"
      end
      render(new_project_path)
    end
  end

  def update
    @project = Project.find_by(id: params[:id])
    @project.update(project_params)
    if @project.save
      flash[:notice] = "編集内容が送信されました"
      redirect_to(preview_project_path(id: @project.id))
    else
      @project.errors.full_messages.each do |message|
        flash[:notice] = "#{message}"
      end
      render(preview_project_path(id: @project.id))
    end
  end

  def destroy
    @project = Project.find_by(id: params[:id])
    @project.destroy
    flash[:notice] = "アカウントを削除しました"
    redirect_to("/")
  end
end

private

def project_params
  params.permit(:title, :description, :asp_money, :end_date, :mainbody, :main_photo, :user_id, :category, :area, :id, photos: [])
end
