module ControllersHelper
  def setup_ability
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(@controller).to receive(:current_ability) { @ability }
  end
end
