import React from "react";

function Form(props) {
  const { onSubmit, isLoading, onChange, inputRef } = props;

  return (
    <form onSubmit={onSubmit}>
      <input
        className="url"
        type="url"
        data-test="url"
        required
        ref={inputRef}
        onChange={onChange}
        placeholder="https://example.com"
      />
      <input
        type="submit"
        data-test="submit"
        disabled={isLoading}
        value={isLoading ? "Working..." : "Shorten it!"}
      />
    </form>
  );
}

export default Form;
