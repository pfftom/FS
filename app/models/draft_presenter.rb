class DraftPresenter
  def initialize(league)
    @league = league
  end

  def team(user)
    @team ||= @league.find_team(user)
  end

  def qbs
    @league.available_qbs
  end

  def rbs
    @league.available_rbs
  end

  def wrs
    @league.available_wrs
  end

  def tes
    @league.available_tes
  end

  def defs
    @league.available_defs
  end

  def ks
    @league.available_ks
  end
end
