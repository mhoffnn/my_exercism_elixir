defmodule DateParser do
  @day_names "[Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday]"
  @month_names "[January|February|March|April|May|June|July|August|September|October|November|December]"

  @start? "(?"
  @start "("
  @bar ")/("
  @space ") ("
  @comma "), ("
  @end_sentence ")"
  @end_sentence_all "*)"

  def day() do
    "[0-3]?[0-9]"
  end

  def month() do
    "[0-1]?[0-9]"
  end

  def year() do
    "[0-2][0-9][0-9][0-9]"
  end

  def day_names() do
    @day_names
  end

  def month_names() do
    @month_names
  end

  def capture_day() do
    @start? <>
      "<day>" <>
      day() <>
      @end_sentence
  end

  def capture_month() do
    @start? <>
      "<month>" <>
      month() <>
      @end_sentence
  end

  def capture_year() do
    @start? <>
      "<year>" <>
      year() <>
      @end_sentence
  end

  def capture_day_name() do
    @start? <>
      "<day_name>" <>
      day_names() <>
      @end_sentence_all
  end

  def capture_month_name() do
    @start? <>
      "<month_name>" <>
      month_names() <>
      @end_sentence_all
  end

  def capture_numeric_date() do
    @start <>
      capture_day() <>
      @bar <>
      capture_month() <>
      @bar <>
      capture_year() <>
      @end_sentence
  end

  def capture_month_name_date() do
    @start <>
      capture_month_name() <>
      @space <>
      capture_day() <>
      @comma <>
      capture_year() <>
      @end_sentence
  end

  def capture_day_month_name_date() do
    @start <>
      capture_day_name() <>
      @comma <>
      capture_month_name() <>
      @space <>
      capture_day() <>
      @comma <>
      capture_year() <>
      @end_sentence
  end

  def match_numeric_date() do
    ~r/^#{capture_numeric_date()}$/
  end

  def match_month_name_date() do
    ~r/^#{capture_month_name_date()}$/
  end

  def match_day_month_name_date() do
    ~r/^#{capture_day_month_name_date()}$/
  end
end
