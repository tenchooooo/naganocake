class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def edit

  end

  def create
    @address_new = Address.new(address_params)
    @address.save
    redirect_to addresses_path
  end

  def update

  end

  def destroy

  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
