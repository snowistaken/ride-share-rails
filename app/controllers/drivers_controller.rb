class DriversController < ApplicationController

  def index
    @drivers = Driver.all
  end

  def show
    id = params[:id].to_i
    @driver = Driver.find_by(id: id)

    if @driver.nil?
      head :not_found
      return
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    elsif
      @driver.update(driver_params)
      redirect_to driver_path
      return
    else
      render :edit
      return
    end
  end

  def destroy

  end

  def new
    @driver = Driver.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path
      return
    else
      render :new
      return
    end
  end

end
