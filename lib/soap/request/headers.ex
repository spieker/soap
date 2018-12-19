defmodule Soap.Request.Headers do
  @doc """
  Headers generator by soap action and custom headers.

  ## Examples

  """
  @spec build(map(), String.t(), list()) :: list()
  def build(wsdl, operation, custom_headers) do
    wsdl
    |> extract_soap_action_by_operation(operation)
    |> extract_headers(custom_headers)
  end

  @spec extract_soap_action_by_operation(map(), String.t()) :: String.t()
  defp extract_soap_action_by_operation(wsdl, operation) do
    Enum.find(wsdl[:operations], fn x -> x[:name] == operation end)[:soap_action]
  end

  @spec extract_headers(String.t(), list()) :: list()
  defp extract_headers(soap_action, []), do: base_headers(soap_action)
  defp extract_headers(_, custom_headers), do: custom_headers

  @spec base_headers(String.t()) :: list()
  defp base_headers(soap_action) do
    [{"SOAPAction", soap_action}, {"Content-Type", "text/xml;charset=utf-8"}]
  end
end
