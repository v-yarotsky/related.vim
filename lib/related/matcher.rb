module Related

  class Matcher
    class WeightedMatch < Struct.new(:file, :weight); end

    def best_match(ideal_candidate, available_candidates)
      best_candidate = weighted_matches(ideal_candidate, available_candidates).reject { |c| c.weight.zero? }.max_by(&:weight)
      best_candidate.nil? ? nil : best_candidate.file
    end

    def weighted_matches(ideal_candidate, available_candidates)
      arraified_ideal = arraify(ideal_candidate)
      available_candidates.map do |candidate|
        arraified_candidate = arraify(candidate)
        matched = arraified_ideal.zip(arraified_candidate).take_while { |(a, b)| a == b }
        WeightedMatch.new(candidate, matched.count)
      end
    end

    private

    def arraify(candidate)
      candidate.split(File::SEPARATOR).reverse
    end
  end

end

