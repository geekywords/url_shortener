import React, { useEffect, useState, useCallback } from "react";
import { CopyIcon } from "./icons";

function Copy(props) {
  const { content } = props;
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    setTimeout(() => {
      if (copied) {
        setCopied(false);
      }
    }, 1500);
  }, [copied]);

  const handleCopy = useCallback(() => {
    navigator.clipboard
      .writeText(content)
      .then(() => setCopied(true))
      .catch((err) => console.error(err));
  }, [content]);

  return (
    <div className="copy" data-test="copy" onClick={handleCopy}>
      <CopyIcon />
      {copied ? "Copied" : "Copy"}
    </div>
  );
}

export default Copy;
