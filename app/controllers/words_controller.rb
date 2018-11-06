class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  # GET /words
  # GET /words.json
  def index
    @words = Word.all.order("word ASC")
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
    @words = Word.all.order("created_at DESC")
    @new_word = Word.last.word
    @definition = "You did it!"

    parameters = {
      headers: {
        "Accept": "application/json",
        "app_id": "#{ENV['oed_app_id']}",
        "app_key": "#{ENV['oed_app_key']}",
        }
      }
    
        response = HTTParty.get("https://od-api.oxforddictionaries.com:443/api/v1/entries/en/#{@new_word}", parameters)
        @definition = response['results'][0]['lexicalEntries'][0]['entries'][0]['senses'][0]['definitions'][0]

        
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to root_path, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
        
      parameters = {
      headers: {
        "Accept": "application/json",
        "app_id": "#{ENV['oed_app_id']}",
        "app_key": "#{ENV['oed_app_key']}",
        }
      }
    
        # response = HTTParty.get("https://od-api.oxforddictionaries.com:443/api/v1/entries/en/#{params[:word]}", parameters)
        
        
        # @definition = response['results'][0]['lexicalEntries'][0]['entries'][0]['senses'][0]['definitions'][0]

      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  def wordwall
    @words = Word.all.order("created_at DESC")
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.require(:word).permit(:word)
    end
end
