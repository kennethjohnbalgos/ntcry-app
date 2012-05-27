class ImportController < ApplicationController
  def reader
    @contacts = request.env['omnicontacts.contacts']
    puts "List of contacts obtained from #{params[:importer]}:"
    @contacts.each do |contact|
      puts "Contact found: name => #{contact[:name]}, email => #{contact[:email]}"
    end
  end
end
