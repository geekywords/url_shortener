import React, { useCallback, useRef, useState } from "react";
import Form from "./form";
import Success from "./success";

function Main() {
  const [url, setURL] = useState("");
  const [hashedURL, setHashedURL] = useState(null);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);
  const inputRef = useRef();

  const submitURL = useCallback((url) => {
    async function submit(url) {
      const response = await fetch("/api/urls", {
        method: "POST",
        body: JSON.stringify({
          url,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      }).then((response) => {
        return response.json().then((data) => {
          if (response.ok) {
            return data;
          } else {
            return Promise.reject(data.errors);
          }
        });
      });

      return response;
    }

    setLoading(true);
    setHashedURL(null);
    setError(null);

    submit(url)
      .then((response) => {
        setHashedURL(response.data.hash);
      })
      .catch((err) => {
        setError(err.url[0]);
      })
      .finally(() => setLoading(false));
  }, []);

  const handleChange = useCallback((e) => {
    const { value } = e.target;
    setURL(value);
  }, []);

  const handleSubmit = useCallback(
    (e) => {
      e.preventDefault();
      if (inputRef.current.validity.valid) {
        submitURL(url);
      }
    },
    [url]
  );

  return (
    <div className="wrapper">
      <h1 className="title" data-test="title">
        Stordly
      </h1>
      <h2 className="subTitle" data-test="subTitle">
        Stop sharing long URLs, shorten them today!
      </h2>
      <Form
        onSubmit={handleSubmit}
        onChange={handleChange}
        isLoading={loading}
        inputRef={inputRef}
      />
      {hashedURL !== null && <Success url={hashedURL} />}
      {error !== null && (
        <div className="error" data-test="error">
          {error}
        </div>
      )}
    </div>
  );
}

export default Main;
