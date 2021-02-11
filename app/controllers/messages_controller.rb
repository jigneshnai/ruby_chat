class MessagesController < ApplicationController
	
	def create		
		if params[:msg].present?
				message = current_user.messages.build(msg: params[:msg], user_id: current_user.id, msgtype: "text")					
		end		

		if params[:msgfile].present?
			uploaded_io = params[:msgfile]

			filename = uploaded_io.original_filename

			message = current_user.messages.build(msg: filename, user_id: current_user.id, msgtype: "file")	

			File.open(Rails.root.join('public', 'uploads', filename), 'wb') do |file|
	  		file.write(uploaded_io.read)
	  	end
		end	

		if message.present? && message.save
				ActionCable.server.broadcast "chatroom_channel",
																			mod_message: message_render(message)
		end
	end

	def message_render(message)
		render(partial: 'message', locals: {message: message})
	end

	def test_file_upload
		uploaded_io = params[:photo]
		filename = uploaded_io.original_filename

		File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
  		file.write(uploaded_io.read)
		end
	end
end