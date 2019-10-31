#! /bin/env ruby
#

require 'yaml'
require 'json'
require 'vcardigan'
require 'rqrcode'

unless ARGV.length == 0
  @infile = ARGV[0]
  if ARGV[1] == 'v' 
    @verbose = true
  else
    @verbose = false
  end
else
  puts "no params set, using defaults"
  @infile = 'vcard.yaml'
end
def gen_vcard()
  data = YAML.load_file(@infile)['vcard']

  name = data['name'].split
  vcard = VCardigan.create
  vcard.name name[1], name[0]
  vcard.fullname data['name']
  vcard.email data['email'], :type => ['work', 'internet'], :preferred => 1
  vcard.adr data['address']
  vcard.org data['company'], data['department']
  vcard.title data['title']
  vcard.tel data['tel']['mobile'], :type =>['cell']
  puts vcard.to_s if @verbose
  return vcard.to_s
end

def gen_qr(vcard)
  qr = RQRCode::QRCode.new(vcard.to_s)

  png = qr.as_png(
    bit_depth: 1,
    border_modules: 4,
    color_mode: ChunkyPNG::COLOR_GRAYSCALE,
    color: 'black',
    file: nil,
    fill: 'white',
    module_px_size: 6,
    resize_exactly_to: false,
    resize_gte_to: false,
    size: 240
  )
  qrfile = @infile.split('.')[0]
  begin
    IO.write("#{qrfile}.png", png.to_s)
  rescue StandardError => e
    puts e.message
  end
end

a = gen_vcard
gen_qr a

