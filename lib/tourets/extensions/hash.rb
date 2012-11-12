# This is only a temporary fix until it's patched in Rails
class Hash
  
  def recursive_symbolize_keys!
    symbolize_keys!
    
    values.each{|h| h.recursive_symbolize_keys! if h.is_a?(Hash)}
    values.select{|v| v.is_a?(Array)}.flatten.each{|h| h.recursive_symbolize_keys! if h.is_a?(Hash)}
    self
  end
  
  #In case for some reason this isn't picked up from Rails
  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    self
  end
  
end