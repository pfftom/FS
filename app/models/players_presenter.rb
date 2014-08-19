class PlayersPresenter
  def initialize(league)
    @league = league
  end

  def qbs
    if @league
      paginate(@league.available_qbs)
    else
      NFLPlayer.quarterbacks
    end
  end

  def rbs
    if @league
      paginate(@league.available_rbs)
    else
      NFLPlayer.backs
    end
  end

  def wrs
    if @league
      paginate(@league.available_wrs)
    else
      NFLPlayer.receivers
    end
  end

  def tes
    if @league
      paginate(@league.available_tes)
    else
      NFLPlayer.tight_ends
    end
  end

  def defs
    if @league
      paginate(@league.available_defs)
    else
      NFLPlayer.defenses
    end
  end

  def ks
    if @league
      paginate(@league.available_ks)
    else
      NFLPlayer.kickers
    end
  end

  private

  def paginate(position)
    Kaminari.paginate_array(position)
  end
end
