require 'spec_helper'
require 'mozzn'

def unique_name
  uuid = SecureRandom.uuid
  "APP#{uuid}"
end

def unique_email
  uuid = SecureRandom.uuid
  "rania#{uuid}@gmail.com"
end

def long_string
  string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc hendrerit ultricies tortor eu posuere. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vivamus suscipit lacinia tellus, id aliquam metus commodo quis. In eget mauris felis. Integer lobortis justo id mauris ullamcorper, et scelerisque elit lobortis. Integer non iaculis tortor, nec placerat est. Donec sed urna ac augue placerat pellentesque. Aliquam placerat, leo ac mollis pharetra, libero sem dictum augue, eu imperdiet quam elit eu mi. Vestibulum imperdiet elit ligula, nec congue diam lobortis quis. Quisque sit amet pellentesque erat, at vulputate neque. Donec viverra velit non dignissim aliquet. Integer porta, augue non porttitor tincidunt, enim erat dignissim velit, quis dictum metus arcu non mauris. Duis venenatis massa et sapien tristique, ac hendrerit odio venenatis. Integer eleifend arcu dapibus, volutpat mauris ut, lacinia ante.  Quisque congue, nisi eu fringilla ullamcorper, felis tortor sodales sem, euismod ullamcorper enim ligula ac ligula. Quisque eget sapien pellentesque, fringilla est sed, auctor ligula. Donec scelerisque, velit at pellentesque auctor, urna massa aliquam massa, sit amet rutrum nulla ipsum at lorem. Aenean scelerisque ante arcu, et scelerisque tellus eleifend eu. Sed sodales purus eu sodales egestas. Phasellus rhoncus nibh lacus, non tempor enim malesuada in. Nunc cursus nunc ante, ac bibendum erat pulvinar quis.  Pellentesque porta gravida nulla. Etiam lobortis laoreet cursus. Sed nisi neque, pretium a consectetur ut, euismod eget est. Aenean blandit erat ante, tristique ullamcorper purus fermentum in. Fusce rhoncus dapibus mi, a auctor dolor dictum sodales. Donec elementum varius nisl a mollis. Phasellus eu metus ipsum. Nulla vel est sagittis, hendrerit mi eu, sollicitudin purus. Curabitur non ipsum pulvinar, cursus tortor a, ultrices eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;  Sed aliquet molestie turpis vitae pretium. Cras dictum luctus enim, sed gravida leo dictum vel. Vestibulum a tortor erat. Nullam sit amet nulla vel odio porta luctus hendrerit dapibus ante. Mauris venenatis turpis non viverra sagittis. Aenean ligula lacus, eleifend nec tincidunt et, venenatis sed metus. Donec tempor sollicitudin congue. Vivamus nec enim vitae elit dapibus rhoncus. Praesent commodo tempor tortor, vitae congue justo gravida ut. Integer eget scelerisque purus. Aliquam vulputate porttitor neque, quis tempus urna consectetur quis. Sed sagittis vel nibh sit amet tempus. Maecenas vel velit arcu.  Quisque in erat condimentum, commodo ante consequat, placerat lacus. Duis et enim in est dictum sagittis vel eu purus. Fusce vestibulum lorem adipiscing augue accumsan, id mollis est tempor. Vivamus ultrices quam non augue gravida, quis venenatis orci tincidunt. In euismod cursus scelerisque. Curabitur dignissim dapibus nibh. Maecenas sodales non eros at lacinia. Nulla blandit at sapien vel sodales. Vivamus a tempor est. Aliquam erat volutpat. Curabitur semper, purus a cursus porta, sem augue pharetra risus, eu volutpat orci massa id tortor. Maecenas varius commodo dui vel viverra. Fusce ac posuere diam. Nulla non porta sapien. Nullam magna urna, faucibus quis mauris in, convallis mollis urna.  Proin id elementum felis. Suspendisse potenti. Quisque vel blandit sapien. Proin eu velit mi. Nam vestibulum pharetra nisl sit amet molestie. Praesent ut lorem est. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Duis at sollicitudin justo. Vivamus varius, arcu quis dictum facilisis, mi lectus consequat velit, a ullamcorper mi est quis tellus. Nam tortor turpis, vestibulum eu lacus a, tristique mattis dui.  Mauris sodales felis non justo vestibulum ornare. Quisque vel metus ac ipsum viverra aliquet eu placerat lacus. Aenean porttitor, arcu a hendrerit aliquet, mauris turpis pretium purus, eget commodo augue mauris eget nulla. Nunc blandit lobortis metus, ut ultricies dolor egestas a. Nullam ultricies sit amet lorem nec congue. Sed condimentum lectus adipiscing tortor mattis ullamcorper. Sed ut neque porttitor sem convallis scelerisque fermentum non quam. Nam ut rutrum tellus. Curabitur fermentum facilisis erat, id tincidunt felis blandit vel. Proin eu libero eu leo scelerisque feugiat. Donec a posuere eros. Morbi nibh leo, tristique egestas est non, tincidunt euismod est.  Phasellus ut ornare erat, et placerat elit. Cras pellentesque malesuada dignissim. Pellentesque bibendum lacus neque, nec commodo mi vestibulum quis. Proin vel ultrices odio. Praesent ultrices, magna in cursus luctus, nulla nibh pellentesque elit, vitae sollicitudin turpis quam quis sapien. Nullam vitae turpis a arcu laoreet interdum. Fusce a imperdiet nulla. Donec sed nisl adipiscing, convallis diam molestie, condimentum nisi. Nunc blandit mollis tellus, sit amet fringilla urna tempor id. Sed aliquam vulputate est quis fermentum. Cras eget varius nisl. Curabitur erat tellus, tincidunt ut nisl a, iaculis aliquam urna. Proin blandit lacus neque, at viverra ipsum malesuada ut. Vestibulum vel dui vestibulum, sollicitudin enim fermentum, gravida quam. Ut felis massa, elementum eget nibh ac, ornare adipiscing quam. Nunc molestie nec dui eu mollis.  Nam tincidunt dapibus lobortis. Ut posuere elit augue, et feugiat elit volutpat vitae. Cras eleifend sodales enim, in vehicula velit sodales non. Aenean a quam et libero ornare vehicula ut vitae diam. Aenean vel sem et nunc pharetra laoreet eget a neque. Fusce nibh magna, dapibus tempus nibh et, viverra imperdiet elit. Phasellus bibendum scelerisque erat, in aliquam ipsum scelerisque id. Praesent condimentum, tortor ut sagittis suscipit, eros dolor pellentesque massa, eget egestas magna turpis aliquam risus.  Morbi gravida tortor eget arcu dapibus pretium. Aliquam accumsan sollicitudin vulputate. Donec dictum blandit dui nec dictum. Fusce eget rhoncus mi. Aliquam ornare rhoncus cursus. Nam quis massa massa. Phasellus nec dui sapien. Cras tempus lorem justo, quis rhoncus urna pellentesque sed. Pellentesque nisi diam, congue ut libero at, tempus ornare enim. Vestibulum nec odio ac urna facilisis porta. Quisque sed pulvinar justo. Proin pulvinar libero nec tincidunt ullamcorper. Morbi quis magna quis elit laoreet adipiscing nec quis neque. Suspendisse potenti. Suspendisse potenti.  Curabitur nunc turpis, porta consequat consectetur sit amet, varius vitae erat. Morbi ac ante ultrices, aliquet felis sagittis, interdum nibh. In nulla nisi, interdum id congue sed, facilisis eu quam. Vestibulum pretium ullamcorper convallis. Pellentesque lobortis neque eu est bibendum rhoncus. Cras bibendum imperdiet nibh non dignissim. Donec porta in libero a feugiat.  Duis suscipit semper interdum. Nulla quis pulvinar magna. Fusce lectus dolor, hendrerit volutpat tempus vel, malesuada non enim. Praesent consequat egestas condimentum. Vestibulum aliquam a felis non congue. Duis fringilla ultrices sapien lobortis lobortis. Etiam dui quam, interdum ut mattis et, pellentesque non dui. Praesent blandit, tortor a convallis suscipit, massa lacus lacinia lacus, a elementum augue ante eu justo. Curabitur eget nisi quis neque lacinia sollicitudin.  Donec quis tincidunt augue. Sed tincidunt id elit nec fermentum. In tempor libero sit amet felis bibendum blandit. Nullam rhoncus dolor id dapibus vulputate. Etiam et suscipit arcu. Suspendisse suscipit lectus in mauris laoreet, dapibus aliquam ligula faucibus. In elit risus, venenatis a dignissim vel, congue quis sem. Proin tincidunt orci quis est facilisis, id ultricies ipsum facilisis. Sed hendrerit auctor eleifend. Cras fermentum sollicitudin enim ac molestie. Morbi ut mattis sem. Integer varius porttitor turpis. Sed lobortis rutrum velit ut feugiat. Vestibulum luctus a neque quis laoreet.  Sed at purus dui. Pellentesque ac enim imperdiet diam tempus fermentum in congue diam. Nulla facilisi. Cras interdum ipsum at metus fringilla faucibus. Maecenas commodo luctus tempor. Duis at ligula lorem. Proin adipiscing urna sed dui euismod convallis. Sed eget leo ullamcorper, vulputate justo iaculis, elementum dolor. Sed vel scelerisque neque. Phasellus a laoreet mauris, nec interdum felis.  Sed rhoncus massa quis velit mattis ornare. Vestibulum congue ante sed est interdum ornare. Sed accumsan nisl in enim aliquam cursus sit amet a urna. Phasellus vitae elementum nisl. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Interdum et malesuada fames ac ante ipsum primis in faucibus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque non orci dictum, egestas neque a, vestibulum neque.  Aliquam et lorem vitae enim condimentum luctus at sed arcu. Aenean sit amet tortor posuere, consectetur eros at, accumsan risus. Donec iaculis ultrices nisl, et fermentum leo mollis in. Cras massa neque, cursus eu dignissim sed, vulputate hendrerit lectus. Quisque venenatis libero in justo varius eleifend. Cras malesuada iaculis nisl, a dignissim arcu elementum id. Ut bibendum, tellus vitae laoreet semper, risus augue accumsan massa, at suscipit massa justo sed nisl. Praesent gravida, orci sed lobortis pellentesque, purus neque vehicula turpis, sed molestie leo ante sit amet nibh. Aliquam vehicula odio metus, non cursus erat pretium fringilla. Suspendisse ut mattis ipsum, id luctus libero. Donec sit amet dolor a erat laoreet laoreet. Ut pharetra neque non lorem molestie, in elementum nisi lobortis. Curabitur a augue lorem. Integer at arcu orci.  Mauris eget libero id odio gravida vehicula ac at magna. Vestibulum ac metus venenatis, aliquet erat vel, pharetra eros. Pellentesque quis diam tellus. Maecenas non viverra sem. Aenean quis varius nisi, vitae ultricies risus. Fusce congue nisl nisi, id lacinia augue molestie id. Cras mattis, libero ut egestas accumsan, velit ipsum dictum risus, eget eleifend dolor massa pharetra nunc. Morbi euismod enim vitae metus mattis semper. Sed ante magna, convallis sollicitudin magna vel, molestie scelerisque dui. Nam in quam quis magna interdum semper. In pellentesque, arcu sit amet aliquet congue, nisi est rhoncus elit, at pharetra enim lacus gravida urna. Praesent feugiat nisl vel accumsan aliquam. Etiam velit nisl, adipiscing non metus et, viverra fringilla mauris. Morbi ornare velit in odio volutpat venenatis.  Aliquam erat volutpat. Nam sodales dictum velit consequat venenatis. Aliquam in convallis velit. Donec vitae enim tortor. Phasellus posuere dolor diam, euismod tincidunt purus elementum sed. Mauris at justo eu justo euismod dictum vel in libero. Proin ac magna eu odio ultrices ornare ac quis felis. Vivamus laoreet magna at ultrices imperdiet. Ut malesuada sodales odio sit amet mollis. Maecenas id facilisis ligula. Cras vehicula consectetur augue, eu vulputate nisi facilisis a. Aenean quis dolor sed lacus tincidunt varius sed id velit. Quisque sodales nisi at metus sagittis, id tempor orci pretium.  Vivamus dapibus porttitor orci. Nulla volutpat imperdiet purus eu imperdiet. Ut laoreet dui eget purus tempor, eu blandit neque mattis. Ut eget justo gravida, mattis sapien vel, mattis magna. Aliquam fringilla iaculis erat sed eleifend. Etiam consectetur scelerisque est et euismod. Vestibulum suscipit id elit at blandit.  Duis lobortis eleifend diam, ac aliquet ligula porttitor in. Fusce vitae justo metus. Etiam in condimentum est. Nullam porttitor fermentum rhoncus. Donec quis magna at enim semper facilisis. Fusce mollis a ante eu mattis. Nullam gravida lorem ut vestibulum feugiat. Duis interdum tincidunt massa quis condimentum.  Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Quisque purus quam, molestie vitae tempus dignissim, consectetur ut tortor. Integer non consectetur dolor. Aliquam quam purus, suscipit in libero eu, pellentesque pretium quam. In consequat et arcu sed auctor. Nulla ac mi turpis. Vestibulum imperdiet lectus turpis, at commodo tortor rutrum ut. Proin nec lorem lobortis, elementum purus ut, laoreet magna. Sed condimentum sem eget malesuada semper. In sem dui, bibendum eu nisi ac, semper commodo urna. Cras molestie nisi vel massa sodales, at aliquam leo ultricies. Curabitur sagittis quis tellus a tristique. Aenean blandit malesuada ornare.  Ut ultricies tortor consectetur accumsan lobortis. Curabitur interdum enim feugiat, viverra velit vehicula, fermentum nisl. Nunc lobortis vel dui id bibendum. Suspendisse ornare diam neque, in iaculis sapien tempus at. Aenean varius laoreet interdum. Integer semper nulla lacus, eget rutrum felis hendrerit vestibulum. Nam sed vehicula diam, at porta ipsum.  Pellentesque pretium orci id orci congue, nec pellentesque nulla dictum. Quisque hendrerit cursus mi. Nam non eros feugiat, vulputate nisi id, cursus tellus. Aenean facilisis est enim, et ultricies quam congue quis. Sed consectetur varius sem, sit amet pulvinar orci semper eget. Ut feugiat tincidunt sem, non dictum felis volutpat eget. Morbi imperdiet tortor a justo fringilla rutrum. Sed quis turpis ac lorem scelerisque dignissim. Ut pulvinar iaculis rutrum.  Nullam sed dignissim risus, suscipit vehicula lectus. Aliquam dui enim, tincidunt ut mi in, varius imperdiet libero. Proin blandit at nibh eu pharetra. Integer ultrices nec augue sit amet fringilla. Sed sollicitudin erat eu luctus luctus. Nullam semper aliquet rutrum. Aliquam nec pretium diam. Aliquam venenatis consectetur dignissim. Sed egestas, velit et commodo dictum, neque urna aliquet tortor, nec dignissim orci sem quis felis. Aenean pharetra quis risus quis elementum. Proin ac blandit eros, at ultrices enim. Donec at turpis est. Mauris eget leo mi.  Quisque aliquam ornare lacinia. Sed sed risus non urna mollis posuere quis a odio. Donec eleifend, mi ac dictum accumsan, elit neque molestie urna, et malesuada tellus arcu vel risus. Praesent placerat vel mauris sagittis venenatis. Integer massa elit, tempor fermentum sem vel, porta commodo mauris. Quisque tincidunt nulla ut nulla ornare molestie. In quis nunc pellentesque, mollis eros a, auctor ante. Aenean eros nibh, luctus ut dui et, vehicula pharetra leo.  Donec velit purus, volutpat a aliquam ut, convallis quis nisi. Nunc a tellus augue. Vestibulum ante sem, tempor eu consequat eu, ultrices at sem. Aenean nec tellus mi. Donec at ante vitae odio lobortis lobortis sit amet nec dolor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nunc tellus erat, euismod vel fringilla ac, tempor a ipsum. Nulla enim purus, feugiat sed urna in, consectetur condimentum urna. Maecenas faucibus tincidunt ligula, at tincidunt sem sollicitudin a. In pharetra ante sed quam accumsan consequat. Suspendisse egestas nunc vel facilisis faucibus. Vestibulum varius semper velit vel convallis. Donec dapibus auctor ipsum vitae hendrerit. Aliquam sed placerat ligula. Nunc eu mauris tellus.  Vivamus augue massa, fermentum eget ultricies ac, lacinia nec nisl. Aenean justo eros, elementum egestas tellus non, placerat tincidunt quam. Nulla facilisi. Quisque quam ante, commodo in tempus quis, fermentum nec arcu. Nunc sed lacus felis. Praesent diam lorem, consequat sed libero quis, tempor vehicula mauris. Donec imperdiet congue lacus at consectetur.  Ut massa tellus, euismod quis laoreet nec, fringilla vel augue. Vestibulum sodales ligula sit amet rhoncus hendrerit. Cras tempor ante ac arcu faucibus, aliquet venenatis magna interdum. Suspendisse et felis ac mi sagittis pellentesque ut sed risus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Morbi bibendum diam non erat dictum pellentesque. Suspendisse imperdiet gravida vestibulum. Fusce eros elit, vulputate et eleifend in, condimentum et purus. Pellentesque fermentum sapien nec ultrices rhoncus. Sed quis pulvinar nisl, nec porta ligula. Mauris sed consectetur lorem, nec eleifend urna. Etiam mollis, quam in tempor vestibulum, libero odio mollis est, vehicula lobortis lectus ligula ac urna. Curabitur placerat lacinia nunc, vitae aliquam sem commodo ac. Sed congue magna a odio dapibus, eget tristique eros mattis.  Praesent tempus quis tellus eleifend facilisis. Maecenas id imperdiet nunc, et tempor odio. Cras nec dignissim augue, aliquam vehicula quam. Aenean at laoreet libero, vitae dignissim massa. Duis sed lectus ut odio viverra aliquet et nec elit. Sed viverra enim vulputate adipiscing ornare. In sit amet interdum metus, id commodo erat. Nunc ac mi ut metus ornare aliquam non quis sem. Integer vitae pulvinar enim. Fusce sed purus vehicula, scelerisque dolor in, mattis quam. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed blandit arcu sit amet nisl varius condimentum id eu neque. Praesent convallis lacinia fringilla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec vitae enim tortor. Suspendisse dolor arcu, mollis sit amet cursus quis, consequat ut lectus.  Duis ullamcorper ante quam, a viverra magna convallis et. Cras in luctus lectus, at porta felis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam viverra dui sit amet justo fermentum, ac mollis velit convallis. Sed et risus dui. Aenean vel felis sodales, luctus ipsum id, aliquam dui. Curabitur a ante suscipit, auctor elit ut, tempus lacus. Sed ullamcorper vulputate purus, at commodo arcu feugiat a. Ut placerat hendrerit orci, in dignissim ipsum pharetra vel.  Nam fermentum leo vitae massa facilisis tincidunt. Proin varius nibh risus, ut varius metus convallis in. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ultricies id mi vitae volutpat. Donec tempus elit orci, ac commodo nibh porta id. Suspendisse nec magna varius leo eleifend tempor. Integer iaculis odio in mi posuere aliquam.  Nunc velit enim, sollicitudin vel libero sed, commodo pulvinar purus. Morbi condimentum at sem non volutpat. Praesent eget dolor non sem luctus volutpat. Maecenas a convallis quam. Donec consequat at velit ut imperdiet. Morbi vulputate felis et orci mattis, sit amet congue tellus egestas. Nulla nec orci mi. Vestibulum aliquam dolor augue.  Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Cras congue purus diam, non interdum nibh hendrerit et. In dignissim in mauris in viverra. Etiam sollicitudin mi sed scelerisque facilisis. Sed consequat adipiscing commodo. Fusce eu tortor ac dolor gravida convallis. Curabitur feugiat commodo nulla. Donec odio eros, varius adipiscing mi id, viverra laoreet arcu. Sed mauris turpis, aliquam eget volutpat ut, elementum nec leo. Nam erat erat, convallis sed diam eget, rutrum dignissim ligula. Aliquam rhoncus vulputate dolor et mollis. Duis nisi felis, sodales in odio in, scelerisque pellentesque magna. Nunc sagittis consequat gravida. Aliquam aliquet elit lacinia dolor euismod, id imperdiet massa rhoncus. Sed vitae vestibulum felis. Pellentesque ornare consectetur enim.  Vestibulum dignissim nec velit sed pellentesque. Proin placerat nulla nibh, eu euismod magna fermentum sed. Cras ultricies mauris eget ullamcorper tincidunt. Maecenas vestibulum sem sed magna rutrum, at mattis urna iaculis. Phasellus quis molestie nisi. Nulla facilisi. Mauris risus nisi, vehicula vitae magna eget, vulputate placerat massa. Fusce suscipit sed dui eget volutpat. Donec ac accumsan turpis. Suspendisse potenti.  Vestibulum cursus sapien et mi sollicitudin adipiscing. Donec convallis placerat elit, ut laoreet augue volutpat at. Vivamus non turpis nunc. In eleifend nibh consectetur nisl molestie, ac tincidunt dolor vulputate. Donec urna tortor, condimentum nec ipsum et, imperdiet vulputate mauris. Nunc ut nisi non turpis pharetra viverra. Aenean enim dolor, pellentesque sit amet sapien sit amet, placerat posuere tortor. Nunc faucibus, lorem non euismod malesuada, orci velit ultrices diam, vitae facilisis lorem nisi nec diam.  Vivamus nulla felis, dignissim aliquet eros eget, vulputate condimentum leo. Sed quis congue tellus. Nam sed odio sit amet est lacinia suscipit. Sed ultrices porttitor felis vel imperdiet. Praesent pulvinar ligula ut erat iaculis, non sollicitudin erat volutpat. Proin ac laoreet quam, id placerat tellus. Cras eu semper velit. Curabitur porttitor lectus vel sem lacinia, ullamcorper feugiat lorem sodales. Quisque porta eros orci, vitae pellentesque quam interdum vitae.  Suspendisse potenti. Morbi venenatis sodales ullamcorper. Fusce lectus augue, vestibulum id consequat elementum, pellentesque eget lorem. Nam sed massa diam. In feugiat at ipsum commodo faucibus. Pellentesque tempor metus feugiat lacinia porta. Sed malesuada sapien eget nunc volutpat porta. Sed tincidunt porta turpis at porta. Donec id magna quis elit vestibulum varius a in tortor.  Mauris sed dignissim mi. Aenean dignissim, nulla quis hendrerit sagittis, metus turpis rutrum quam, id bibendum orci ipsum id turpis. Etiam mattis lorem in dui pretium semper. Phasellus ornare, lacus non porta dapibus, orci neque mattis felis, eu varius turpis ante nec sem. Vivamus in eros ultrices, gravida erat ut, sodales lacus. Curabitur vel bibendum leo, consectetur vehicula nulla. Aenean eu enim sapien. Aenean sagittis commodo libero, at rhoncus enim laoreet a. Fusce leo felis, malesuada ut est at, dapibus molestie orci. In imperdiet fermentum lacinia. Nam accumsan hendrerit imperdiet. Nullam quis elit in mauris imperdiet aliquam. Morbi ac sapien sodales, volutpat neque a, imperdiet lacus. Pellentesque bibendum augue nec purus egestas, ac aliquet nisl pharetra. Donec imperdiet accumsan nunc, a laoreet nunc feugiat nec.  Pellentesque aliquam massa sapien, nec sollicitudin dolor scelerisque vitae. Aliquam posuere dignissim egestas. Fusce malesuada egestas scelerisque. Sed tellus lectus, accumsan non luctus tincidunt, consectetur non felis. Vestibulum ac neque purus. In vehicula sit amet sapien vel elementum. Mauris luctus pellentesque cursus. Aenean eget purus eu nibh tempor auctor eu non tortor. Aliquam mi odio, dignissim ut leo id, consequat tincidunt libero. Sed vitae fermentum est, nec vestibulum lorem. Donec interdum nisi in sem elementum iaculis. Suspendisse sagittis magna quis sem consectetur, nec lobortis est suscipit. Mauris pharetra leo eget arcu feugiat, tempus vehicula orci malesuada. Phasellus metus magna, varius sed nunc et, adipiscing euismod orci.  Quisque in dui metus. Cras augue dolor, fringilla at bibendum id, faucibus in ante. Aliquam aliquam, tellus quis ultrices adipiscing, felis nibh porttitor arcu, et laoreet dolor nisl id nisl. Pellentesque dignissim eget purus in dapibus. Ut porttitor felis sed pellentesque dictum. Aenean a lacus cursus, laoreet sapien sit amet, molestie quam. Fusce lacus metus, porta sed lectus nec, laoreet pellentesque sem. Integer congue velit tortor, sit amet tristique ipsum lobortis quis. Vestibulum viverra adipiscing nulla nec pellentesque. Cras sollicitudin ut sapien ac tempor. Sed eleifend, sapien vitae pharetra mattis, nunc mauris volutpat libero, a pretium leo massa sit amet ligula. Fusce malesuada velit at felis tempor rhoncus. Quisque arcu metus, lacinia nec bibendum id, accumsan in tellus. Praesent congue orci non dolor rhoncus consectetur. Cras feugiat porttitor lorem, nec iaculis neque vulputate at.  Ut vel elementum justo, non porta tellus. Nam dignissim commodo suscipit. Donec hendrerit tristique sapien, ac tincidunt magna tincidunt ac. Quisque eget purus ultricies, convallis dolor at, sagittis mauris. Suspendisse faucibus, ante eu congue iaculis, augue quam dictum diam, nec pellentesque ipsum sem ac nunc. Curabitur quis luctus ligula, semper ullamcorper magna. Nullam sit amet erat feugiat, gravida tellus interdum, accumsan elit. In velit mauris, tempor et massa gravida, molestie varius diam. In rutrum at sapien vel accumsan. Curabitur eu velit eu risus commodo ullamcorper vitae at diam. Vivamus sit amet porta orci. Maecenas lorem massa, porttitor nec ante auctor, fringilla rhoncus arcu. Integer faucibus, nulla commodo congue accumsan, erat ligula ullamcorper eros, eget cursus eros nisl id leo. Fusce suscipit diam nec lectus sollicitudin, id vulputate elit hendrerit. Quisque facilisis auctor scelerisque.  Integer lectus nulla, ultrices non eros at, elementum viverra turpis. Cras rutrum enim non euismod scelerisque. Duis tempor hendrerit eros ut fringilla. Quisque imperdiet purus quis sapien bibendum, sed tincidunt augue bibendum. Nulla luctus viverra urna, sit amet auctor nibh gravida sollicitudin. Aliquam volutpat nunc sit amet quam imperdiet rutrum. Sed eget dolor quis felis tincidunt malesuada. Morbi blandit consequat hendrerit. Donec venenatis tortor et dui blandit pellentesque. Nullam ut felis nisi. Donec vel semper lectus. Praesent imperdiet, nulla et mattis laoreet, ipsum eros elementum quam, at lacinia tellus arcu a enim. Nullam adipiscing at arcu vel rutrum. Integer nec diam blandit, accumsan urna vitae, dignissim nunc.  Donec viverra est quis fermentum elementum. Aliquam interdum odio a elementum porta. Proin non accumsan nunc. Pellentesque tincidunt odio accumsan odio ultrices auctor. Cras non eleifend mauris. Sed id faucibus diam, ut pellentesque leo. Sed in orci non nunc varius luctus non nec dolor. Morbi fringilla et augue vel imperdiet. Aenean ante erat, tincidunt sed purus quis, tristique aliquam leo. Proin sed nisl placerat, aliquam neque et, dignissim lorem. Proin placerat euismod odio eu lobortis.  Nam sit amet nisi vel est iaculis vestibulum vitae ac leo. In euismod tellus at mi fringilla, sit amet blandit nulla lacinia. Nullam posuere venenatis venenatis. Integer vel tortor cursus, facilisis est vel, semper enim. Vestibulum at pharetra massa. Donec in auctor augue. Morbi facilisis dignissim sapien, vitae consequat dolor vulputate in. Integer ut erat ultrices, eleifend sapien blandit, fringilla mi. Sed odio augue, placerat eget cursus sed, consequat vitae turpis. Curabitur sed tristique sapien. Integer porttitor eget odio quis sodales. Cras ornare, velit auctor dapibus ultricies, turpis mi dignissim neque, ultrices faucibus arcu libero tempor urna. Ut eu rutrum nisl. Mauris scelerisque nunc sed cursus lobortis. Proin eget cursus est, et aliquam tellus. Suspendisse in dictum purus, a venenatis urna.  Aliquam erat volutpat. Phasellus dapibus metus nec lacus pulvinar euismod. Duis sollicitudin massa sapien, at tincidunt nisl placerat id. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec nec lacus augue. Curabitur facilisis, erat id fringilla ultricies, urna ipsum pulvinar arcu, vitae laoreet quam risus quis metus. In auctor turpis molestie quam molestie tempor. Suspendisse quis rhoncus orci. Phasellus vel enim mi. Praesent cursus non turpis at mollis. Mauris condimentum, risus ut auctor eleifend, justo nunc semper ante, quis egestas dui felis ac dolor. Morbi laoreet quam sit amet mauris dictum auctor. Vestibulum auctor sodales erat viverra suscipit.  Quisque ac ipsum faucibus magna aliquam semper non eget leo. Suspendisse ut quam posuere, auctor diam a, posuere leo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin dignissim semper ante, vel pretium orci tincidunt ac. Suspendisse blandit interdum massa, sit amet scelerisque lacus faucibus sit amet. Donec vitae rutrum odio. Nam mi enim, facilisis sed odio vitae, adipiscing eleifend tellus. Praesent non massa pellentesque, gravida ipsum nec, ullamcorper odio. Morbi vitae felis nulla. Fusce eu tincidunt ante. Vestibulum pretium hendrerit eros, et imperdiet tortor sodales ac. Vestibulum sodales sem vel arcu ullamcorper, sed tempus purus placerat. Cras adipiscing arcu quam, at euismod tortor imperdiet eget.  Quisque sed lectus felis. Donec hendrerit, nisi sit amet blandit tempus, sapien arcu iaculis tortor, a viverra dolor justo ac felis. Maecenas euismod quam ultrices pellentesque fringilla. Donec lobortis vulputate lectus at molestie. Pellentesque fringilla ornare sapien egestas ultrices. Integer pulvinar dui in augue elementum convallis. Nulla tempus adipiscing nisi. Morbi in vestibulum arcu.  Integer condimentum consequat pulvinar. Maecenas consectetur ut urna sed vehicula. Mauris vitae justo eu dolor sollicitudin tristique. Etiam nec porttitor lacus, nec sagittis turpis. Cras semper ipsum ut sollicitudin tempor. Proin placerat sem nec blandit varius. Fusce in nibh non nulla aliquet dignissim. Sed tempus sed neque id tristique. Sed eget interdum neque, convallis luctus ligula. Morbi a arcu a lectus posuere lobortis eu id velit. Nunc sed vehicula velit, eget pellentesque enim. Donec fringilla rhoncus pellentesque. Ut ullamcorper mi est, ac tristique ante ultrices et. Mauris consectetur massa ut pretium blandit. Phasellus at massa sit amet diam pretium blandit non eu est. Ut odio arcu, interdum porttitor tristique dignissim, rhoncus ut risus. Nulla eu orci nec tellus dignissim pellentesque sed id nibh. Suspendisse porta quam quis erat mattis, vitae mattis tellus fermentum. Aliquam erat volutpat. Cras molestie erat augue, sit amet tempus ante lacinia quis. Integer tristique erat rhoncus malesuada varius.  Nulla vel felis id orci viverra suscipit eget in leo. Sed facilisis purus id ipsum vestibulum, eget tincidunt metus lacinia. Donec leo arcu, volutpat a ultricies id, cursus sed eros. Vestibulum viverra sapien at augue pharetra faucibus. Curabitur consequat pulvinar arcu, vitae aliquet leo. Suspendisse vel suscipit risus, quis vehicula nisl. Vivamus eget felis metus. Curabitur at dapibus eros, non sollicitudin nulla. Nunc fringilla rhoncus ipsum quis viverra."
end

describe Mozzn::Cli do
  before :each do
    @cli = Mozzn::Cli.new
  end

  describe "mozzn create_app" do
    describe "with valid params" do
      it "returns Application created successfuly" do
        output = capture(:stdout) { @cli.create_app "#{unique_name}"}
        one,two = output.split("\n")
        expect(one).to match('Application created successfuly') 
      end
    end

    describe "with invalid params" do
      it "returns creating faild " do
        output = capture(:stdout) { @cli.create_app "App name"}
        one,two = output.split("\n")
        expect(one).to match('creating faild')  
      end
    end

    describe "without params " do
      it "returns You must enter Application Name! " do
        expect { @cli.create_app }.to raise_error(Thor::Error, "You must enter application name.")
      end
    end
  end

  describe "mozzn add_key" do 
    describe "with valid SSH key" do 
      it "returns SSH key created" do
        @cli.options = {public_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDXwZsqptW/1sxBvT6FAukbGsDKzqoBwwaAj6yUgM1ygdupF3NHhpf3huenu9X09SQTjvGDUjLCn6MgIREumrn3JaIEceqRVI5wtAd2c8S1kwJxZLYqTJT4iifW/ydTocz94FADwrLYWHIjlGLh/FY6xDHhloL0Ymvv+iiEg4cWhdC23zenEUOBS7khnw2FeXxLag4/tcinEYR1+Z3PrhRvfg964Rlf1BdspRwuF26GbiRqgo2M1bj9tBH5PZyL17R06adOpBAh1UzT8X9qSXi9OYE9C2HDIGH3MRpCdpJWU36FWqg8iG/DnFzlxzheRJ78A5R8WdDL2oMFE/BrkM9d'}
        output = capture(:stdout) { @cli.add_key }
        expect(output).to match('SSH key created')
      end
    end

    describe "with invalid SSH key" do
      it "returns SSH key created" do
        @cli.options = {public_key: 'invalid_public_key'}
        output = capture(:stdout) { @cli.add_key }
        expect(output).to match('creating faild')
      end
    end

    describe "with valid SSH key path" do
      it "returns SSH key created" do
        @cli.options = {key_path: '~/.ssh/id_rsa.pub'}
        output = capture(:stdout) { @cli.add_key }
        expect(output).to match('SSH key created')
      end
    end

    describe "with invalid SSH key path" do
      it "returns Unable to read /invalid_path, file does not exist or not accessible!" do
        @cli.options = {key_path: '/invalid_path'}
        expect { @cli.add_key }.to raise_error(Thor::Error, "Unable to read /invalid_path. File does not exist or not accessible.")
      end
    end

    describe "without params " do
      it "returns You must enter an SSH key path or a public SSH key!" do
        expect { @cli.add_key }.to raise_error(Thor::Error, "Neither a key path or an SSH key were provided. You must use -p or -k options.")
      end
    end
  end

  describe "mozzn login" do
    describe "with valid params " do
      it "returns Successfully logged in." do
        name = 'rania'
        email = unique_email
        password = '12345678'
        password_confirmation = '12345678'
        @cli.options = {
          name: name,
          email: email ,
          password: password,
          password_confirmation: password_confirmation
        }
        output = capture(:stdout) { @cli.registration }
        cli1 = Mozzn::Cli.new
        cli1.options = {
          email:email,
          password: password
        }
        expect{ @cli.login }.to raise_error(Thor::Error,"You have to confirm your account before continuing.")
      end
    end

    describe "with long_string email and password " do
      it "returns Invalid email or password." do
        @cli.options = {
          email: long_string,
          password: long_string
        }
        expect { @cli.login }.to raise_error(Thor::Error, "Invalid email or password.")
      end
    end

    describe "with invalid params " do
      it "returns Invalid email or password." do
        @cli.options = {
          email: 'invalid@example.com',
          password: '12345678'
        }
        expect { @cli.login }.to raise_error(Thor::Error, "Invalid email or password.")
      end
    end

    describe "with nil params " do
      it "returns Invalid email or password." do
        @cli.options = {
          email: '',
          password: ''
        }
        expect { @cli.login }.to raise_error(Thor::Error, "Invalid email or password.")
      end
    end

    describe "without email " do
      it "returns Email and password must be provided! " do
        @cli.options = {
          password: '12345678'
        }
        expect { @cli.login }.to raise_error(Thor::Error, "Email and password must be provided!")
      end
    end

    describe "without password " do
      it "returns Email and password must be provided! " do
        @cli.options = {
          email: 'rania@overcstudios.com'
        }
        expect { @cli.login }.to raise_error(Thor::Error, "Email and password must be provided!")
      end
    end

    describe "with no params " do
      it "returns an interactive shell asking for email and password" do
        pending
      end
    end
  end

  describe "mozzn update" do
    describe "with avilable updates" do
      it "returns An update is available" do
        pending
      end
    end
    describe "with no avilable updates" do
      it "returns You have the latest version." do
        pending
      end
    end
  end

  describe "mozzn registration" do
    describe "with valid params" do
      it "returns Succesfully registered" do
        @cli.options = {
          name: 'rania',
          email: unique_email ,
          password: '12345678',
          password_confirmation: '12345678'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to match("Successfully registered")
      end
    end

    describe "with missing email" do
      it "should return email missing" do
        @cli.options = {
          name: 'rania',
          password: '12345678',
          password_confirmation: '12345678'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be  =~ /email/ 
      end
    end

    describe "with missing password" do
      it "should return password missing" do
        @cli.options = {
          name: 'rania',
          email: unique_name,
          password_confirmation: '12345678'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be  =~ /password/ 
      end
    end

    describe "with missing confirmation Password" do
      it "should return password confirmation Missing" do
        @cli.options = {
          name: 'rania',
          email: unique_email,
          password: '12345678'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be  =~ /password_confirmation/ 
      end
    end

    describe "with invalid email" do
      it "should return invalid email" do
        @cli.options = {
          name: 'rania',
          email: 'qqqqqqq',
          password: '12345678',
          password_confirmation: '12345678'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be  =~ /email/
      end
    end

    describe "with short password" do
      it "should short password" do
        @cli.options = {
          name: 'rania',
          email: unique_email,
          password: '123',
          password_confirmation: '123'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be  =~ /password/
      end
    end

    describe "with unmatched password and confirmation password" do
      it "should return password and confirmation password are not matched" do
        @cli.options = {
          name: 'rania',
          email: unique_email,
          password: '12345678',
          password_confirmation: '87654321'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be  =~ /password_confirmation/
      end
    end

    describe "with nil parammeters" do
      it "should return Parameter Missing" do
        @cli.options = {
          name: nil,
          email: nil,
          password: nil,
          password_confirmation: nil
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be =~ /email/
      end
    end
  end

  describe "mozzn instances" do
    describe "With valid params" do
      describe "With an existing App having compnents and data stores" do
        it "returns HTTP code 200:OK" do
          pending
        end
      end

      describe "With an existing App having compnents and no datastores" do
        it "returns HTTP code 200:OK" do
          pending
        end
      end
    
      describe "With an existing App having datastores and no components" do
        it "returns HTTP code 200:OK" do
          pending
        end
      end

      describe "With an existing App having no datastores or components" do
        it "returns HTTP code 200:OK" do
          pending
        end
      end
    end
    describe "With invalid parameters" do
      describe "with not existing application" do
        it "returns HTTP code 422" do
          pending 
        end
      end

      describe "with unauthorized user" do
        it "returns HTTP code 422" do
          pending
        end
      end

      describe "without name" do
        it "should return Application name must be provided." do 
          pending
        end
      end

      describe "with very long application name." do
        it "should return This application is not exist." do 
          pending
        end
      end
    end
  end
end