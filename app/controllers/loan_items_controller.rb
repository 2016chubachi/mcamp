class LoanItemsController < ApplicationController
  def new
    @loan_item = LoanItem.new
    #buildはcreateとほぼ同じ　loan_item_imageがない(nil)だとファイルをアップロードするdoが通らないので作成する
    @loan_item.build_loan_item_image
  end

  def create
    @loan_item = LoanItem.new(params[:loan_item])
    if @loan_item.save
      redirect_to @loan_item
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
    @loan_item.assign_attributes(params[:loan_item])
    if @loan_item.save
      redirect_to @loan_item, notice: "アイテムを更新しました"
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
    @loan_items = LoanItem.all
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
end
