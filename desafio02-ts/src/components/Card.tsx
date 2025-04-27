import React from 'react';

interface ICard {
  id: number;
  paragraph: string;
  details: string;
}

const Card: React.FC<ICard> = ({ id, paragraph, details }) => {
  return (
    <div>
      <h1>Card {id}</h1>
      <p>{paragraph}</p>
      <p>{details}</p>
    </div>
  );
};

export default Card;
