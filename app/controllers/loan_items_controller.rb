class LoanItemsController < ApplicationController
  before_action :logged_in_member, except: [:show]
  before_action :correct_item_member, only: [:edit, :update]

  def new
    @loan_item = LoanItem.new
    #buildはcreateとほぼ同じ　loan_item_imageがない(nil)だとファイルをアップロードするdoが通らないので作成する
    @loan_item.build_loan_item_image
  end

  def create
    # @loan_item = LoanItem.new(params[:loan_item])
    @loan_item = LoanItem.new(loan_item_params)
    @loan_item.assign_attributes(loan_state_id: 1, member_id: current_member.id)
    if @loan_item.save
      redirect_to @loan_item, notice: "アイテムを登録しました"
    else
      render "new"
    end
  end

  def edit
    @loan_item = LoanItem.find(params[:id])
    @loan_item.build_loan_item_image unless @loan_item.loan_item_image
  end

  def update
    @loan_item = LoanItem.find(params[:id])
    # @loan_item.assign_attributes(params[:loan_item])

    if params[:update_item]
      @loan_item.assign_attributes(loan_item_params)
      msg = "アイテムを更新しました"
    elsif params[:return_item]
      @loan_item.assign_attributes(loan_state_id:  1)
      msg = "アイテムを返却しました"
    end

    if @loan_item.save
      redirect_to @loan_item, notice: msg
    else
      render "edit"
    end

  end

  def show
    @loan_item = LoanItem.find(params[:id])
    if params[:format].in?(["jpg", "png","gif"])
      send_image
    else
      render "show"
    end
  end

  def index
    # @loan_items = LoanItem.all
    @loan_items = LoanItem.where(member_id: current_member.id)
                    .order(:loan_state_id,updated_at: :DESC).page(params[:page]).per(5)
  end

  def destroy
    @loan_item = LoanItem.find(params[:id])
    @loan_item.destroy
    redirect_to :loan_items, notice: "アイテムを削除しました"
  end

  private
    def send_image
      if @loan_item.loan_item_image.present?
        send_data @loan_item.loan_item_image.image,
          type: @loan_item.loan_item_image.content_type, disposition: "inline"
      end
    end

    def loan_item_params
      attrs = [:item_name, :member_id, :category_id, :item_description,
              :fare, :term, :location, :loan_state_id]
      attrs << {loan_item_image_attributes: [:uploaded_image,  :id]}
      params.require(:loan_item).permit(attrs)
    end

    # テスト用にmember_idをsessionに追加
    def set_member_sesion
      session[:member_id] = 1
    end
end
