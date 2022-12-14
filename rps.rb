#!/usr/bin/env ruby

require 'colorize';

class RockPaperScissors
	
	def initialize 
	
		@winNum   = 3
		@totalNum = 5
	
		@rps     = %w|rock paper scissors|
	
		@player1 = {}
		@player2 = {}
		
		@round   = 1
		
		2.times do |n|
			
			n += 1
			player = %Q|@player#{n}|
					
			if    n == 2 then
			
				(instance_variable_get player)[:name] = %q|Computer|
			
			else
				
				print %q|> |
				print %q|Enter Nickname: |.green
				(instance_variable_get player)[:name] = gets.chomp!.sub(%r~^(?![[:alnum:]]+)$~,%q|User One|) 
			
			end
			
			(instance_variable_get player)[:wins]  = 0
		
		end
		
	end
	
	def play
	
		choice = %q||
	
		loop do
		
			if    @player1[:wins] >= @winNum
		
				self.victory(1)
			
			elsif @player2[:wins] >= @winNum
			
				self.victory(2)
			
			end
			
			puts %q|=|*25
			
			puts %q|Choice:|.yellow
			
			@rps.each_with_index do |v,k|
			
				puts  %Q|#{k.to_s.yellow + %q|:|.yellow} #{v}|
				
			end
			
			puts %q|=|*25
			
			print %q|> |
			
			ply_choice = gets.chomp!
			
			self.clear
			
			if    ply_choice.match(%r~^Q(?:uit)?$~i)
			
				print %q|> |
				puts  %q|Quitting!|.red
				exit 69
				
			elsif !ply_choice.match(%r~^[0-2]$~)
			
				print %q|> |
				puts  %q|Incorrect selection! Try again!|.red
				self.status
				next

			end

			ply_choice = ply_choice.to_i
			cpu_choice = rand(3)
			
			print %q|> |
			puts  %Q|#{@player1[:name]}: | + @rps[ply_choice].blue
			
			print %q|> |
			puts  %Q|#{@player2[:name]}: | + @rps[cpu_choice].blue
			
			
			case ply_choice
			
			when 0 # rock
				
				if    cpu_choice == 1
				
					self.loss(1,0)
					
				elsif cpu_choice == 2
				
					self.win(0,2)
					
				else 
				
					self.tie
					next
					
				end
				
			when 1 # paper
				
				if    cpu_choice == 0
				
					self.win(1,0)
				
				elsif cpu_choice == 2
				
					self.loss(2,1)
				
				else 
				
					self.tie
					next
				
				end
				
			when 2 # scissors
			
				if    cpu_choice == 0
				
					self.loss(0,2)
				
				elsif cpu_choice == 1
				
					self.win(2,1)
				
				else 
				
					self.tie
					next
				
				end
			
			end
			
		end
		
	end
	
	private
	
	def clear 
	
		print %Q|[J\033[H\033[J|
	
	end
	
	def tie 
		
		print %q|> |
		puts  %q|Tie Declared! No Winner This Round!|.red
		
		self.status
	
	end
	
	def win(this,that)
	
		text = %Q|#{@rps[this]} beats #{@rps[that]}, #{@player1[:name]} victorious.|.capitalize
	
		print %q|> |
		puts  text.green 
		
		@player1[:wins] += 1
		
		self.status
		
	end
	
	def loss(this,that)
	
		text = %Q|#{@rps[this]} beats #{@rps[that]}, #{@player1[:name]} crushed.|.capitalize
	
		print %q|> |
		puts  text.red 
		
		@player2[:wins] += 1
		
		self.status
		
	end
	
	def victory(n)
	
		player = %Q|@player#{n}|
	
		print %q|> |
		puts  %Q|#{(instance_variable_get player)[:name]} Wins!|.green
		
		exit 0
		
	end
	
	def status
	
		print %Q|> #{@player1[:name]}: |
		puts  %Q|#{@player1[:wins]} / #{@totalNum} wins|.yellow
		
		print %Q|> #{@player2[:name]}: |
		puts  %Q|#{@player2[:wins]} / #{@totalNum} wins|.yellow
	
	end

end 

play = RockPaperScissors.new 
play.play 