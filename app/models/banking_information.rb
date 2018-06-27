class BankingInformation < ApplicationRecord
  belongs_to :tour_store
  validates :account_type, :bank_cc, :bank_ag, :bank, :cc_digit,
  :holder_name, :holder_id, :holder_id_type, presence: true

  def account_type_options
    [['Corrente','CHECKING'],['Poupança','SAVING']]
  end

  def bank_options
    bancos.sort.map{|k,v| ["#{k} cod: #{v}", k]}
  end

  def bank_code
    bancos[bank]
  end

  def bancos
    {
      'BANCO DO BRASIL S.A. (Banco do Brasil)' => '001',
      'BANCO BRADESCO S.A. (Bradesco)' => '237',
      'BANCO ITAU S.A. (Itaú)' => '341',
      'BANCO ABN AMRO REAL S.A. (Real)' => '356',
      'UNIBANCO UNIAO DE BANCOS BRASILEIROS S.A. (Unibanco)' => '409',
      'BANCO DO ESTADO DO RIO GRANDE DO SUL S.A. (Banrisul)' => '041',
      'CAIXA ECONOMICA FEDERAL (Caixa Econômica Federal)' => '104' ,
      'BANCO SANTANDER S.A. (Santander Banespa)' => '033',
      'HSBC BANK BRASIL S.A.BANCO MULTIPLO (HSBC)' => '339',
      'BANCO CITIBANK S.A.' => '745',
      'BANCO NOSSA CAIXA S.A (Nossa Caixa)' => '151',
      'BANCO MERCANTIL DO BRASIL S.A. (Mercantil do Brasil)' => '389',
      'BANCO DO NORDESTE DO BRASIL S.A (Banco do Nordeste (BNB) )'=> '004',
      'BANESTES S.A BANCO DO ESTADO DO ESPIRITO SANTO (Banestes)' => '021',
      'BANCO SAFRA S.A. (Safra)' => '422',
      'BANCO DA AMAZONIA S.A. (Banco da Amazônia (Basa))' => '003',
      'Banco do Estado de Sergipe S.A (Banese)' => '047',
      'Banco de Brasília S.A. (BRB)' => '070',
      'Banco Votorantim S.A (Votorantim)' => '655',
      'Banco BBM S.A (BBM)' => '107',
      'Banco Alfa S.A (Alfa)' => '025',
      'Banco Cacique S. A. (Cacique)' => '263',
      'BANCO CRUZEIRO DO SUL S.A. (Cruzeiro do Sul)' => '229',
      'BANCO FININVEST S.A. (Fininvest)' => '252',
      'BANCO IBI S.A - BANCO MULTIPLO (Banco IBI)' => '063',
      'BANCO PANAMERICANO S.A. (PanAmericano)' => '623',
      'BANCO RENDIMENTO S.A. (Banco Rendimento)' => '633',
      'BANCO SIMPLES S.A. (Banco Simples)' => '479',
      'BANCO ACOMERCIAL E DE INVESTIMENTO SUDAMERIS S.A. (Sudameris)' => '215',
      'BANCO COOPERATIVO DO BRASIL S.A. - (BANCOOB)' => '756' ,
      'BANCO COOPERATIVO SICREDI S.A. (SICREDI)' => '748',
      'LEMON BANK BANCO MÚLTIPLO S..A (Lemon Bank)' => '065',
      'BPN BRASIL BANCO MÚLTIPLO S.A. (BPN)' => '069',
      'BANIF - BANCO INTERNACIONAL DO FUNCHAL (BRASIL), S.A. (Banif)' => '719',
      'BANCO BMG S.A. (BMG)' => '318',
      'BANCO DO ESTADO DE SANTA CATARINA S.A.' => '027',
      'BANCO UBS PACTUAL S.A.' => '208',
      'BANCO ITAUBANK S.A.' => '479',
      'BANCO INTERMEDIUM S.A.' => '077',
      'BANCO UNICRED' => '136',
      'BANCO BANPARÁ' => '037',
      'BANCO ORIGINAL' => '212',
      'CECRED-COOPERATIVA CENTRAL DE CREDITO URBANO' => '085',
      'BANCO NEON' => '735'
    }
  end

end
