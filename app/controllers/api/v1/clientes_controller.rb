require 'json_web_token'
class Api::V1::ClientesController < ApplicationController
  before_action :authenticate_user!

  def index
    gimnasio_id = @current_user.gimnasio_id
    @clientes = Cliente.where(gimnasio_id: gimnasio_id)
    render json: @clientes
  end

  def show
    render json: @cliente
  end

  def clientes_exp
    gimnasio_id = @current_user.gimnasio_id
    clientes = Cliente.where(gimnasio_id: gimnasio_id)
  
    dias_hasta_proximo_pago = 30
    fecha_actual = Time.now
  
    @clientes_proximo_pago = clientes.select do |cliente|
      fecha_pago_proximo = cliente.fecha_sub + dias_hasta_proximo_pago.days
    
      proximos_7_dias = fecha_actual..fecha_actual + 7.days
      proximos_7_dias.cover?(fecha_pago_proximo)
    end
    
  
    render json: @clientes_proximo_pago
  end
  # POST /api/v1/clientes
  def create
    @cliente = Cliente.new(cliente_params)

    if @cliente.save
      render json: @cliente, status: :created
    else
      render json: @cliente.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/clientes/:id
  def update
    if @cliente.update(cliente_params)
      render json: @cliente
    else
      render json: @cliente.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/clientes/:id
  def destroy
    @cliente = Cliente.find(params[:id])
    if @cliente
      @cliente.destroy
      head :no_content
    else
      render json: { error: 'Cliente no encontrado' }, status: :not_found
    end
  end

  private
  def cliente_params
    params.require(:cliente).permit(:nombre, :cedula, :apellido, :email, :fecha_sub, :gimnasio_id)
  end

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = JsonWebToken.decode(token) if token

    if decoded_token
      @current_user = User.find(decoded_token['user_id'])
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  end
end
