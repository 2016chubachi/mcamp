class BorrowItemsController < ApplicationController
    before_action :logged_in_member
    
    def index
        @borrow_Items = BorrowItem.current_member_borrow_items(current_member).order(:borrow_state_id,:updated_at)
    end

    def show
        @borrow_Item = BorrowItem.find(params[:id]) 
    end
    
    def new
        @borrow_Item = BorrowItem.new(category_id: 1,fare: 0,borrow_state_id: 1,delete_flg: false)
    end
    
    def create
        @borrow_Item = BorrowItem.new(create_item_params)
        @borrow_Item.member = current_member
        if @borrow_Item.save
            redirect_to @borrow_Item,notice: "借りたい情報を登録しました。"
        else
            render :new
        end
    end
    
    def edit
        @borrow_Item = BorrowItem.find(params[:id]) 
    end
    
    def update
        if params[:update]
            @borrow_Item = BorrowItem.find(params[:id]) 
            @borrow_Item.assign_attributes(update_item_params)
            if @borrow_Item.save
                redirect_to @borrow_Item,notice: "借りたい情報を更新しました。"
            else
                render :edit
            end
        elsif params[:delete]
            self.destroy
        end
            
    end
    
    def destroy
        BorrowItem.find(params[:id]).destroy
        redirect_to :borrow_items
    end
    
    
    
    private
    
    def create_item_params
        attrs = [:item_name,:member_id,:category_id,:item_description,:fare,:term,:location,:borrow_state_id,:delete_flg]
        params.require(:borrow_item).permit(attrs)
    end
    
    def update_item_params
        attrs = [:item_name,:category_id,:item_description,:fare,:term,:location]
        params.require(:borrow_item).permit(attrs)
    end
end
