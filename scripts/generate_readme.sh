#!/bin/bash
echo -ne > README.md
echo "#Mozzn" >> README.md
echo "Command Line Interface for mozzn APIs" >> README.md
echo "##Installation" >> README.md
echo >> README.md
echo "Run the following command from your terminal:" >> README.md
echo >> README.md
echo "    $ gem install mozzn" >> README.md
echo >> README.md
echo "##Usage" >> README.md
echo "###Mozzn Commands" >> README.md
mozzn help | sed -e 's/mozzn /- mozzn /g' >> README.md
echo "Detailed command usage: ">> README.md
echo >> README.md
for i in `mozzn help | grep -e '^  mozzn' | awk '{print $2}'`;do echo "    $ mozzn $i" >> README.md; mozzn help $i >> README.md; echo '' >> README.md; done;
sed -i -e "s/^Primary help topics\(.*\)$//g" README.md
sed -i -e "s/^Version:\(.*\)$//g" README.md
sed -i "s/# \(.*\)$//g" README.md
sed -i "s/^$//g" README.md
sed -i -e "s/^Usage:\(.*\)$//g" README.md
sed -i -e "s/^  mozzn/####mozzn/g" README.md
sed -i -e "s/^Options:/#####Options:\r\r/g" README.md
echo "## Contributing" >> README.md
echo "1. Fork it ( http://github.com/mozzn/mozzn/fork )" >> README.md
echo "2. Create your feature branch ( git checkout -b my-new-feature)" >> README.md
echo "3. Commit your changes ( git commit -am 'Add some feature')" >> README.md
echo "4. Push to the branch ( git push origin my-new-feature)" >> README.md
echo "5. Create new Pull Request" >> README.md


