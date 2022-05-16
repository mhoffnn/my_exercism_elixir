defmodule Newsletter do
  def read_emails(path) do
    path
    |> File.read!()
    |> String.split()
  end

  def open_log(path) do
    path
    |> File.open!([:write])
  end

  def log_sent_email(pid, email) do
    pid
    |> IO.puts(email)
  end

  def close_log(pid) do
    pid
    |> File.close()
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    pid = open_log(log_path)

    emails_path
    |> read_emails()
    |> send_mail(pid, send_fun)

    close_log(pid)
  end

  defp send_mail([], _, _), do: nil
  defp send_mail([mail|tail], pid, send_fun) do
    if send_fun.(mail) == :ok do
      log_sent_email(pid, mail)
    end
    send_mail(tail, pid, send_fun)
  end

end
