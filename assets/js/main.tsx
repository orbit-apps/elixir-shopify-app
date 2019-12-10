import React from "react";

interface MainProps {
  name: string;
}

const Main: React.FC<MainProps> = ({ name }: MainProps) => {
  return (
    <div className="pxh-hero">
      <h1>Welcome to {name} with Typescript and React!</h1>
      <p>A productive web framework that does not compromise speed or maintainability.</p>
    </div>
  );
};

export default Main;
