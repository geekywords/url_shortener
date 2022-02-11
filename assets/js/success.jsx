import React from "react";
import Copy from "./components/copy";
import { ExternalLinkIcon } from "./components/icons";

function Success(props) {
  const { url } = props;

  return (
    <div className="success" data-test="success">
      <a
        href={url}
        className="hashedURL"
        rel="noopener noreferrer nofollow"
        target="_blank"
      >
        {url}
        <ExternalLinkIcon />
      </a>
      <Copy content={url} />
    </div>
  );
}
export default Success;
