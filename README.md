# embulk-filter-script

Embulk filter plugin to external ruby script.

[![Gem](https://img.shields.io/gem/dt/embulk-filter-script.svg)](https://rubygems.org/gems/embulk-filter-script)

## Install

```
embulk gem install embulk-filter-script
```

## Configuration

* **path** external ruby script path (string, required)
* **drop_columns** drop column names (array)

external ruby script 
```ruby
def filter(record)
  # This method implements the filtering logic
  record
end
```

## Example

```
filters:
  - type: script
    path: ./script/example.rb
    drop_columns:
      - created_at
      - updated_at
```

example.rb
```ruby
def filter(record)
  case record["code"].to_i
  when 100..200
    level = "INFO"
  when 201..300
    level = "WARN"
  else
    level = "ERROR"
  end
  record['message'] = "[" + level + "]" + record['message']

  record
end
```
