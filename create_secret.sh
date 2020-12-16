#!/bin/bash

oc project > one.txt
while read -ra line;
do
    for word in "${line[2]}";
    do
         echo "${word:1:${#word}-2}" > two.txt
    done;
done < one.txt
NS=`cat two.txt`
rm one.txt two.txt


FILE=./ingress-ca-ca-dec-key.pem
if test -f "$FILE";then
  #Get rid of the headers and footers
  sed 1d ingress-ca-ca-dec-key.pem > key.txt 
  sed -i '' -e '$ d' key.txt
  tr -d '\n'<key.txt>key2.txt

  sed 1d ingress-ca-ca.cert > cert.txt
  sed -i '' -e '$ d' cert.txt
  tr -d '\n'<cert.txt>cert2.txt

  sed 1d ../ingress-ca/ingress-ca-ca.cert > root.txt
  sed -i '' -e '$ d' root.txt
  tr -d '\n'<root.txt>root2.txt

  #get the name  
  NAME=ingress.ca

else

  #Get rid of the headers and footers
  sed 1d *.pem > key.txt 
  sed -i '' -e '$ d' key.txt
  tr -d '\n'<key.txt>key2.txt

  sed 1d *.cert > cert.txt
  sed -i '' -e '$ d' cert.txt
  tr -d '\n'<cert.txt>cert2.txt

  sed 1d ../ingress-ca/ingress-ca-ca.cert > root.txt
  sed -i '' -e '$ d' root.txt
  tr -d '\n'<root.txt>root2.txt

  #get the name
  NAME=$(ls -1 *.csr | sed -e 's/\..*$//')
fi


echo "Building out $NAME.yaml"

#build out the yaml
echo -n "apiVersion: v1
data:
  ca.crt: " > $NAME.yaml
cat root2.txt >> $NAME.yaml

echo -n "
  tls.crt: " >>$NAME.yaml
cat cert2.txt >>$NAME.yaml

echo -n "
  tls.key: " >>$NAME.yaml
cat key2.txt >>$NAME.yaml

echo "
kind: Secret
metadata:
  name: "$NAME >> $NAME.yaml
echo "
  namespace: "$NS >> $NAME.yaml

#UPDATE THE NAMESPACE BELOW
echo "  type: Kubernetes.io/tls" >>$NAME.yaml

oc apply -f $NAME.yaml

# remove the temp files
rm root.txt key.txt cert.txt key2.txt root2.txt cert2.txt #!/bin/bash

oc project > one.txt
while read -ra line;
do
    for word in "${line[2]}";
    do
         echo "${word:1:${#word}-2}" > two.txt
    done;
done < one.txt
NS=`cat two.txt`
rm one.txt two.txt


FILE=./ingress-ca-ca-dec-key.pem
if test -f "$FILE";then
  #Get rid of the headers and footers
  sed 1d ingress-ca-ca-dec-key.pem > key.txt 
  sed -i '' -e '$ d' key.txt
  tr -d '\n'<key.txt>key2.txt

  sed 1d ingress-ca-ca.cert > cert.txt
  sed -i '' -e '$ d' cert.txt
  tr -d '\n'<cert.txt>cert2.txt

  sed 1d ../ingress-ca/ingress-ca-ca.cert > root.txt
  sed -i '' -e '$ d' root.txt
  tr -d '\n'<root.txt>root2.txt

  #get the name  
  NAME=ingress.ca

else

  #Get rid of the headers and footers
  sed 1d *.pem > key.txt 
  sed -i '' -e '$ d' key.txt
  tr -d '\n'<key.txt>key2.txt

  sed 1d *.cert > cert.txt
  sed -i '' -e '$ d' cert.txt
  tr -d '\n'<cert.txt>cert2.txt

  sed 1d ../ingress-ca/ingress-ca-ca.cert > root.txt
  sed -i '' -e '$ d' root.txt
  tr -d '\n'<root.txt>root2.txt

  #get the name
  NAME=$(ls -1 *.csr | sed -e 's/\..*$//')
fi


echo "Building out $NAME.yaml"

#build out the yaml
echo -n "apiVersion: v1
data:
  ca.crt: " > $NAME.yaml
cat root2.txt >> $NAME.yaml

echo -n "
  tls.crt: " >>$NAME.yaml
cat cert2.txt >>$NAME.yaml

echo -n "
  tls.key: " >>$NAME.yaml
cat key2.txt >>$NAME.yaml

echo "
kind: Secret
metadata:
  name: "$NAME >> $NAME.yaml

#Put in the namspace based on your current project
echo "  namespace: "$NS >> $NAME.yaml

#UPDATE THE NAMESPACE BELOW
echo "  type: Kubernetes.io/tls" >>$NAME.yaml

oc apply -f $NAME.yaml

# remove the temp files
rm root.txt key.txt cert.txt key2.txt root2.txt cert2.txt
