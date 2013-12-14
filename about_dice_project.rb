require File.expand_path(File.dirname(__FILE__) + '/neo')

# Implement a DiceSet Class here:
#
class DiceSet
  attr_accessor :values, :rng

  def initialize
    @rng = Random.new # Used solely to allow for testing :-/
  end

  def roll(num_dice)
    @values = (1..6).to_a.sample(num_dice, random: rng)
    self # allow method chaining
  end
end

class AboutDiceProject < Neo::Koan
  def test_can_create_a_dice_set
    dice = DiceSet.new
    assert_not_nil dice
  end

  def test_rolling_the_dice_returns_a_set_of_integers_between_1_and_6
    dice = DiceSet.new

    dice.roll(5)
    assert dice.values.is_a?(Array), "should be an array"
    assert_equal 5, dice.values.size
    # dice.values.each do |value|
    #   assert value >= 1 && value <= 6, "value #{value} must be between 1 and 6"
    # end
    assert dice.values.all? { |die| die.between?(1, 6) }
  end

  def test_dice_values_do_not_change_unless_explicitly_rolled
    dice = DiceSet.new
    first_time = dice.roll(5).values
    second_time = dice.values
    # first_time = dice.values
    # second_time = dice.values
    assert_equal first_time, second_time
  end

  def test_dice_values_should_change_between_rolls
    dice = DiceSet.new

    # dice.roll(5)
    # first_time = dice.roll(5).values

    # dice.roll(5)
    # second_time = dice.roll(5).values

    # assert_not_equal first_time, second_time,
    #   "Two rolls should not be equal"

    # THINK ABOUT IT:
    #
    # If the rolls are random, then it is possible (although not
    # likely) that two consecutive rolls are equal.  What would be a
    # better way to test this?

    # Use your own random number generator to guarantee the two sequences are unique
    rng1 = Class.new { def rand(*) 1 end }.new
    rng2 = Class.new { def rand(*) 0 end }.new
    dice.rng = rng1
    first_time = dice.roll(5).values
    dice.rng = rng2
    second_time = dice.roll(5).values
    assert_not_equal first_time, second_time,
      "Two rolls should not be equal"
  end

  def test_you_can_roll_different_numbers_of_dice
    dice = DiceSet.new

    assert_equal 3, dice.roll(3).values.size
    assert_equal 1, dice.roll(1).values.size
  end

end
