# encoding: cp932

# じゃんけんゲーム

class Player
  PAPER = 0
  SCISORS = 1
  STONE = 2
  POINTS_TO_WIN = 3
  WIN = {
    [PAPER, STONE] => true,
	[SCISORS, PAPER] => true,
	[STONE, SCISORS] => true
  }
  HANDS = ["Paper", "Scisors", "Rock"]
  
  def initialize(msg)
    @point = 0
	@choice = nil
	@name = msg
  end
  
  def fight(other)
    while !victory? && !other.victory?
	  decide()
	  other.decide()
	  puts("#{name}: #{HANDS[choice]}, #{other.name}: #{HANDS[other.choice]}")
	  judge(other)
	  other.judge(self)
	end
  end
  
  def victory_speech()
    if victory?
	  puts("#{@name} win!")
	end
  end
  
  # 以降のメソッドはPlayerクラスのオブジェクトのみ呼び出せる
  protected
  
  def decide()
    @choice = rand(3)
  end
  
  attr_reader :name, :choice
  
  def judge(other)
    if WIN[[choice, other.choice]]
	  @point += 1
	end
  end
  
  def victory?()
    @point == POINTS_TO_WIN
  end
end

class HumanPlayer < Player
  def decide() # override!
    puts("Paper: 0, Scisors: 1, Rock: 2")
	@choice = Integer(gets)
  end
end

computer = Player.new("Computer")
player = HumanPlayer.new("Player")

player.fight(computer)
computer.victory_speech()
player.victory_speech()

  