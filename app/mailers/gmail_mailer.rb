class GmailMailer < ApplicationMailer
	def send_mail(name)
		mail(to: name, from: 'akshitatiwari1110@gmail.com',subject: 'Welcome')
	end
end
