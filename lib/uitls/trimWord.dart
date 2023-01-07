
String trimFirstWord (String bigSentence,String caractere) {
  int indexOfSpace;

  indexOfSpace = bigSentence.indexOf(caractere, 0);
  if(indexOfSpace == -1){ // -1 waqet mayal9ach l caractere
    return bigSentence;
  }

  return bigSentence.substring(0,indexOfSpace);
}