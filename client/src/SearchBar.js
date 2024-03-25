import './SearchBar.css';
import React, { useState } from 'react';
import Autosuggest from 'react-autosuggest';
import { fetchAutocomplete } from "./utils/api";

function SearchBar({ onSearch }) {
  const [value, setValue] = useState('');
  const [suggestions, setSuggestions] = useState([]);
  const [selectedIngredients, setSelectedIngredients] = useState([]);

  const getSuggestions = async (value) => {
    try {
      const suggestions = await fetchAutocomplete(value);
      setSuggestions(suggestions);
    } catch (error) {
      console.error('Error:', error);
    }
  };

  const onSuggestionsFetchRequested = ({ value }) => {
    getSuggestions(value);
  };

  const onSuggestionsClearRequested = () => {
    setSuggestions([]);
  };

  const onChange = (event, { newValue }) => {
    setValue(newValue);
  };

  const onSuggestionSelected = (event, { suggestionValue }) => {
    setValue('');
    const updatedIngredients = [...selectedIngredients, suggestionValue];
    setSelectedIngredients(updatedIngredients);

    onSearch(updatedIngredients);
  };

  const removeIngredient = (index) => {
    const updatedIngredients = [...selectedIngredients];
    updatedIngredients.splice(index, 1);
    setSelectedIngredients(updatedIngredients);

    onSearch(updatedIngredients);
  };

  const inputProps = {
    placeholder: 'Choose ingredients',
    value,
    onChange,
  };

  return (
    <div className="search-bar-container">
      <div className="search-bar">
        <Autosuggest
          suggestions={suggestions}
          onSuggestionsFetchRequested={onSuggestionsFetchRequested}
          onSuggestionsClearRequested={onSuggestionsClearRequested}
          getSuggestionValue={(suggestion) => suggestion}
          renderSuggestion={(suggestion) => <div>{suggestion}</div>}
          inputProps={inputProps}
          onSuggestionSelected={onSuggestionSelected}
          renderInputComponent={renderInputComponent}
          renderSuggestionsContainer={renderSuggestionsContainer}
        />
      </div>
      <div className="selected-ingredients">
        {selectedIngredients.map((ingredient, index) => (
          <span key={index} className="tag" onClick={() => removeIngredient(index)}>
            {ingredient} &times;
          </span>
        ))}
      </div>
    </div>
  );
}

const renderInputComponent = (inputProps) => (
  <div className="search-container">
    <input {...inputProps} className="search-input" />
  </div>
);

const renderSuggestionsContainer = ({ containerProps, children }) => (
  <div {...containerProps} className="suggestions-container">
    {children}
  </div>
);

export default SearchBar;