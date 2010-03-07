class CheckRunsController < ApplicationController
  before_filter :find_site
  before_filter :find_health_check
  
  def index
    @check_runs = @health_check.check_runs
    respond_to do |format|
      format.png { send_data(CheckRunGraph.new(@check_runs).render, :disposition => 'inline', :type => 'image/png', :filename => "check_runs.png") }
    end
  end
  
  def show
    @check_run = @health_check.check_runs.find(params[:id])
  end
  
protected
  def find_site
    @site = Site.find(params[:site_id])
  end

  def find_health_check
    @health_check = @site.health_checks.find(params[:health_check_id])
  end
end