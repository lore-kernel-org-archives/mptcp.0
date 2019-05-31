Content-Type: multipart/mixed; boundary="===============5301884406077510134=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] KSelftests warnings: Replaced mapping before it was done
Date: Fri, 31 May 2019 18:59:52 +0200
Message-ID: <c174bdf2-0418-5b1c-781c-22493290d6d7@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1275

--===============5301884406077510134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

As just discussed, I have this warning when launching kselftests:

    Replaced mapping before it was done


Here are the logs when KASAN and PROVE_LOCKING are used:

TAP version 13
1..1
# selftests: mptcp: mptcp_connect.sh
[   40.042417] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link becomes ready
[   40.258626] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth3: link becomes ready
[   40.488896] IPv6: ADDRCONF(NETDEV_CHANGE): ns3eth4: link becomes ready
# Created /tmp/tmp.GJv3xyPEgr (size 5220870) containing data sent by client
# Created /tmp/tmp.qFsIUFmpRA (size 2720072) containing data sent by server
# ns1  MPTCP -> ns1  (10.0.1.1:10000) MPTCP	[   40.852761] IPv6:
ADDRCONF(NETDEV_CHANGE): ns2eth1: link becomes ready
[ OK ]
# ns1  MPTCP -> ns1  (10.0.1.1:10001) TCP  	[ OK ]
# ns1  TCP   -> ns1  (10.0.1.1:10002) MPTCP	[ OK ]
# ns1  MPTCP -> ns2  (10.0.1.2:10003) MPTCP	[ OK ]
# ns1  MPTCP -> ns2  (10.0.1.2:10004) TCP  	[ OK ]
# ns1  TCP   -> ns2  (10.0.1.2:10005) MPTCP	[ OK ]
# ns1  MPTCP -> ns2  (10.0.2.1:10006) MPTCP	[ OK ]
# ns1  MPTCP -> ns2  (10.0.2.1:10007) TCP  	[ OK ]
# ns1  TCP   -> ns2  (10.0.2.1:10008) MPTCP	[ OK ]
# ns1  MPTCP -> ns3  (10.0.2.2:10009) MPTCP	[ OK ]
# ns1  MPTCP -> ns3  (10.0.2.2:10010) TCP  	[ OK ]
# ns1  TCP   -> ns3  (10.0.2.2:10011) MPTCP	[ OK ]
# ns1  MPTCP -> ns3  (10.0.3.2:10012) MPTCP	[ OK ]
# ns1  MPTCP -> ns3  (10.0.3.2:10013) TCP  	[ OK ]
# ns1  TCP   -> ns3  (10.0.3.2:10014) MPTCP	[ OK ]
# ns1  MPTCP -> ns4  (10.0.3.1:10015) MPTCP	[   62.510172] Replaced
mapping before it was done
[   62.510714] Replaced mapping before it was done
[   62.516202] Replaced mapping before it was done
[   62.556681] Replaced mapping before it was done
[   62.561805] Replaced mapping before it was done
[   62.574194] Replaced mapping before it was done
[   62.586401] Replaced mapping before it was done
[   62.599163] Replaced mapping before it was done
[   62.611202] Replaced mapping before it was done
[   62.623341] Replaced mapping before it was done
[   62.624615] Replaced mapping before it was done
[   62.636842] Replaced mapping before it was done
[   62.649633] Replaced mapping before it was done
[   62.662349] Replaced mapping before it was done
[   62.663527] Replaced mapping before it was done
[   62.675872] Replaced mapping before it was done
[   62.677086] Replaced mapping before it was done
[   62.688965] Replaced mapping before it was done
[   62.690260] Replaced mapping before it was done
[   62.702386] Replaced mapping before it was done
[   62.704102] Replaced mapping before it was done
[   62.715569] Replaced mapping before it was done
[   62.717106] Replaced mapping before it was done
[   62.728812] Replaced mapping before it was done
[   62.730497] Replaced mapping before it was done
[   62.731282] Replaced mapping before it was done
[   62.742104] Replaced mapping before it was done
[   62.743546] Replaced mapping before it was done
[   62.744334] Replaced mapping before it was done
[   62.745559] Replaced mapping before it was done
[   62.756356] Replaced mapping before it was done
[ OK ]
# ns1  MPTCP -> ns4  (10.0.3.1:10016) TCP  	[ OK ]
# ns1  TCP   -> ns4  (10.0.3.1:10017) MPTCP	[ OK ]
# ns2  MPTCP -> ns1  (10.0.1.1:10018) MPTCP	[ OK ]
# ns2  MPTCP -> ns1  (10.0.1.1:10019) TCP  	[ OK ]
# ns2  TCP   -> ns1  (10.0.1.1:10020) MPTCP	[ OK ]
# ns2  MPTCP -> ns2  (10.0.1.2:10021) MPTCP	[ OK ]
# ns2  MPTCP -> ns2  (10.0.1.2:10022) TCP  	[ OK ]
# ns2  TCP   -> ns2  (10.0.1.2:10023) MPTCP	[ OK ]
# ns2  MPTCP -> ns2  (10.0.2.1:10024) MPTCP	[ OK ]
# ns2  MPTCP -> ns2  (10.0.2.1:10025) TCP  	[ OK ]
# ns2  TCP   -> ns2  (10.0.2.1:10026) MPTCP	[ OK ]
# ns2  MPTCP -> ns3  (10.0.2.2:10027) MPTCP	[ OK ]
# ns2  MPTCP -> ns3  (10.0.2.2:10028) TCP  	[ OK ]
# ns2  TCP   -> ns3  (10.0.2.2:10029) MPTCP	[ OK ]
# ns2  MPTCP -> ns3  (10.0.3.2:10030) MPTCP	[ OK ]
# ns2  MPTCP -> ns3  (10.0.3.2:10031) TCP  	[ OK ]
# ns2  TCP   -> ns3  (10.0.3.2:10032) MPTCP	[ OK ]
# ns2  MPTCP -> ns4  (10.0.3.1:10033) MPTCP	[   62.757636] Replaced
mapping before it was done
[   95.298199] Replaced mapping before it was done
[   95.327847] Replaced mapping before it was done
[   95.328602] Replaced mapping before it was done
[   95.329316] Replaced mapping before it was done
[   95.351276] Replaced mapping before it was done
[   95.352074] Replaced mapping before it was done
[   95.352909] Replaced mapping before it was done
[   95.353684] Replaced mapping before it was done
[   95.354498] Replaced mapping before it was done
[   95.357110] Replaced mapping before it was done
[   95.358564] Replaced mapping before it was done
[   95.359667] Replaced mapping before it was done
[   95.360482] Replaced mapping before it was done
[   95.366152] Replaced mapping before it was done
[   95.367832] Replaced mapping before it was done
[   95.369141] Replaced mapping before it was done
[   95.370752] Replaced mapping before it was done
[   95.371547] Replaced mapping before it was done
[   95.390047] Replaced mapping before it was done
[   95.390959] Replaced mapping before it was done
[   95.391833] Replaced mapping before it was done
[   95.392758] Replaced mapping before it was done
[   95.393905] Replaced mapping before it was done
[   95.394920] Replaced mapping before it was done
[   95.395848] Replaced mapping before it was done
[   95.396774] Replaced mapping before it was done
[   95.397696] Replaced mapping before it was done
[   95.398619] Replaced mapping before it was done
[   95.399532] Replaced mapping before it was done
[   95.405810] Replaced mapping before it was done
[   95.406954] Replaced mapping before it was done
[   95.407902] Replaced mapping before it was done
[   95.408827] Replaced mapping before it was done
[   95.409750] Replaced mapping before it was done
[   95.410612] Replaced mapping before it was done
[   95.411502] Replaced mapping before it was done
[   95.412339] Replaced mapping before it was done
[   95.413233] Replaced mapping before it was done
[   95.414120] Replaced mapping before it was done
[   95.422271] Replaced mapping before it was done
[   95.423322] Replaced mapping before it was done
[   95.424358] Replaced mapping before it was done
[   95.425294] Replaced mapping before it was done
[   95.426348] Replaced mapping before it was done
[   95.427287] Replaced mapping before it was done
[   95.428526] Replaced mapping before it was done
[   95.429472] Replaced mapping before it was done
[   95.430418] Replaced mapping before it was done
[   95.431471] Replaced mapping before it was done
[   95.432262] Replaced mapping before it was done
[   95.433056] Replaced mapping before it was done
[   95.433842] Replaced mapping before it was done
[   95.434927] Replaced mapping before it was done
[   95.435701] Replaced mapping before it was done
[   95.436449] Replaced mapping before it was done
[   95.437232] Replaced mapping before it was done
[   95.437993] Replaced mapping before it was done
[   95.439034] Replaced mapping before it was done
[   95.439832] Replaced mapping before it was done
[   95.440600] Replaced mapping before it was done
[   95.441388] Replaced mapping before it was done
[   95.442458] Replaced mapping before it was done
[   95.443240] Replaced mapping before it was done
[   95.444022] Replaced mapping before it was done
[   95.444814] Replaced mapping before it was done
[   95.445599] Replaced mapping before it was done
[   95.446345] Replaced mapping before it was done
[   95.447327] Replaced mapping before it was done
[   95.448120] Replaced mapping before it was done
[   95.448888] Replaced mapping before it was done
[   95.449662] Replaced mapping before it was done
[ OK ]
# ns2  MPTCP -> ns4  (10.0.3.1:10034) TCP  	[ OK ]
# ns2  TCP   -> ns4  (10.0.3.1:10035) MPTCP	[ OK ]
# ns3  MPTCP -> ns1  (10.0.1.1:10036) MPTCP	[   95.450451] Replaced
mapping before it was done
[  112.571520] Replaced mapping before it was done
[  112.587209] Replaced mapping before it was done
[  112.594369] Replaced mapping before it was done
[  112.600594] Replaced mapping before it was done
[  112.612149] Replaced mapping before it was done
[  112.613490] Replaced mapping before it was done
[  112.626688] Replaced mapping before it was done
[  112.644450] Replaced mapping before it was done
[  112.651502] Replaced mapping before it was done
[  112.654026] Replaced mapping before it was done
[  112.656538] Replaced mapping before it was done
[  112.658511] Replaced mapping before it was done
[  112.661683] Replaced mapping before it was done
[  112.666669] Replaced mapping before it was done
[  112.669327] Replaced mapping before it was done
[  112.693197] Replaced mapping before it was done
[  112.697572] Replaced mapping before it was done
[  112.701228] Replaced mapping before it was done
[  112.709456] Replaced mapping before it was done
[  112.718214] Replaced mapping before it was done
[  112.734514] Replaced mapping before it was done
[  112.744116] Replaced mapping before it was done
[  112.751082] Replaced mapping before it was done
[  112.767345] Replaced mapping before it was done
[  112.768081] Replaced mapping before it was done
[  112.771245] Replaced mapping before it was done
[  112.774876] Replaced mapping before it was done
[  112.778511] Replaced mapping before it was done
[  112.787584] Replaced mapping before it was done
[  112.801550] Replaced mapping before it was done
[  112.807544] Replaced mapping before it was done
[  112.810806] Replaced mapping before it was done
[  112.811494] Replaced mapping before it was done
[  112.815067] Replaced mapping before it was done
[  112.821310] Replaced mapping before it was done
[  112.822963] Replaced mapping before it was done
[  112.833031] Replaced mapping before it was done
[  112.878348] Replaced mapping before it was done
[  112.881293] Replaced mapping before it was done
[  112.884245] Replaced mapping before it was done
[  112.887241] Replaced mapping before it was done
[  112.890213] Replaced mapping before it was done
[  112.893226] Replaced mapping before it was done
[  112.896229] Replaced mapping before it was done
[  112.907315] Replaced mapping before it was done
[  112.909335] Replaced mapping before it was done
[  112.914545] Replaced mapping before it was done
[ OK ]
# ns3  MPTCP -> ns1  (10.0.1.1:10037) TCP  	[ OK ]
# ns3  TCP   -> ns1  (10.0.1.1:10038) MPTCP	[ OK ]
# ns3  MPTCP -> ns2  (10.0.1.2:10039) MPTCP	[  112.915654] Replaced
mapping before it was done
[  116.878194] Replaced mapping before it was done
[  116.893826] Replaced mapping before it was done
[  116.911705] Replaced mapping before it was done
[  116.951919] Replaced mapping before it was done
[  116.986086] Replaced mapping before it was done
[  117.006014] Replaced mapping before it was done
[ OK ]
# ns3  MPTCP -> ns2  (10.0.1.2:10040) TCP  	[ OK ]
# ns3  TCP   -> ns2  (10.0.1.2:10041) MPTCP	[ OK ]
# ns3  MPTCP -> ns2  (10.0.2.1:10042) MPTCP	[  117.011297] Replaced
mapping before it was done
[  120.941688] Replaced mapping before it was done
[  120.948442] Replaced mapping before it was done
[  120.953012] Replaced mapping before it was done
[  120.954179] Replaced mapping before it was done
[  120.955886] Replaced mapping before it was done
[  120.961897] Replaced mapping before it was done
[ OK ]
# ns3  MPTCP -> ns2  (10.0.2.1:10043) TCP  	[ OK ]
# ns3  TCP   -> ns2  (10.0.2.1:10044) MPTCP	[ OK ]
# ns3  MPTCP -> ns3  (10.0.2.2:10045) MPTCP	[ OK ]
# ns3  MPTCP -> ns3  (10.0.2.2:10046) TCP  	[ OK ]
# ns3  TCP   -> ns3  (10.0.2.2:10047) MPTCP	[ OK ]
# ns3  MPTCP -> ns3  (10.0.3.2:10048) MPTCP	[ OK ]
# ns3  MPTCP -> ns3  (10.0.3.2:10049) TCP  	[ OK ]
# ns3  TCP   -> ns3  (10.0.3.2:10050) MPTCP	[ OK ]
# ns3  MPTCP -> ns4  (10.0.3.1:10051) MPTCP	[ OK ]
# ns3  MPTCP -> ns4  (10.0.3.1:10052) TCP  	[ OK ]
# ns3  TCP   -> ns4  (10.0.3.1:10053) MPTCP	[ OK ]
# ns4  MPTCP -> ns1  (10.0.1.1:10054) MPTCP	[  121.015360] Replaced
mapping before it was done
[  147.456471] Replaced mapping before it was done
[  147.506210] Replaced mapping before it was done
[  147.524400] Replaced mapping before it was done
[  147.535701] Replaced mapping before it was done
[  147.540292] Replaced mapping before it was done
[  147.541784] Replaced mapping before it was done
[  147.542780] Replaced mapping before it was done
[  147.553868] Replaced mapping before it was done
[  147.555707] Replaced mapping before it was done
[  147.566386] Replaced mapping before it was done
[  147.567662] Replaced mapping before it was done
[  147.568929] Replaced mapping before it was done
[  147.574307] Replaced mapping before it was done
[  147.575560] Replaced mapping before it was done
[  147.601309] Replaced mapping before it was done
[  147.602596] Replaced mapping before it was done
[  147.603389] Replaced mapping before it was done
[  147.604688] Replaced mapping before it was done
[  147.605427] Replaced mapping before it was done
[  147.606161] Replaced mapping before it was done
[  147.614362] Replaced mapping before it was done
[  147.615564] Replaced mapping before it was done
[  147.620642] Replaced mapping before it was done
[  147.628157] Replaced mapping before it was done
[  147.629371] Replaced mapping before it was done
[  147.642333] Replaced mapping before it was done
[  147.643834] Replaced mapping before it was done
[  147.660020] Replaced mapping before it was done
[  147.660826] Replaced mapping before it was done
[  147.662040] Replaced mapping before it was done
[  147.662969] Replaced mapping before it was done
[  147.678469] Replaced mapping before it was done
[  147.679238] Replaced mapping before it was done
[  147.680509] Replaced mapping before it was done
[  147.682172] Replaced mapping before it was done
[  147.683383] Replaced mapping before it was done
[  147.684161] Replaced mapping before it was done
[  147.686807] Replaced mapping before it was done
[  147.687537] Replaced mapping before it was done
[  147.688766] Replaced mapping before it was done
[  147.689525] Replaced mapping before it was done
[  147.690748] Replaced mapping before it was done
[  147.691514] Replaced mapping before it was done
[  147.728610] Replaced mapping before it was done
[  147.729397] Replaced mapping before it was done
[  147.730603] Replaced mapping before it was done
[  147.731380] Replaced mapping before it was done
[  147.732616] Replaced mapping before it was done
[  147.733372] Replaced mapping before it was done
[  147.734519] Replaced mapping before it was done
[  147.735289] Replaced mapping before it was done
[  147.738078] Replaced mapping before it was done
[  147.741858] Replaced mapping before it was done
[  147.747656] Replaced mapping before it was done
[  147.749643] Replaced mapping before it was done
[  147.752984] Replaced mapping before it was done
[  147.753760] Replaced mapping before it was done
[  147.760328] Replaced mapping before it was done
[  147.761817] Replaced mapping before it was done
[  147.773499] Replaced mapping before it was done
[  147.774282] Replaced mapping before it was done
[  147.775019] Replaced mapping before it was done
[  147.776088] Replaced mapping before it was done
[  147.777624] Replaced mapping before it was done
[  147.778299] Replaced mapping before it was done
[  147.779434] Replaced mapping before it was done
[  147.780656] Replaced mapping before it was done
[  147.781389] Replaced mapping before it was done
[  147.784510] Replaced mapping before it was done
[ OK ]
# ns4  MPTCP -> ns1  (10.0.1.1:10055) TCP  	[ OK ]
# ns4  TCP   -> ns1  (10.0.1.1:10056) MPTCP	[ OK ]
# ns4  MPTCP -> ns2  (10.0.1.2:10057) MPTCP	[  147.785279] Replaced
mapping before it was done
[  157.452612] Replaced mapping before it was done
[  157.454093] Replaced mapping before it was done
[  157.457792] Replaced mapping before it was done
[  157.463385] Replaced mapping before it was done
[  157.474383] Replaced mapping before it was done
[  157.485216] Replaced mapping before it was done
[  157.493835] Replaced mapping before it was done
[  157.519095] Replaced mapping before it was done
[  157.530277] Replaced mapping before it was done
[  157.538921] Replaced mapping before it was done
[  157.551129] Replaced mapping before it was done
[  157.562293] Replaced mapping before it was done
[  157.588288] Replaced mapping before it was done
[  157.589520] Replaced mapping before it was done
[  157.599306] Replaced mapping before it was done
[  157.600596] Replaced mapping before it was done
[  157.611909] Replaced mapping before it was done
[  157.612748] Replaced mapping before it was done
[  157.614101] Replaced mapping before it was done
[  157.623566] Replaced mapping before it was done
[  157.624935] Replaced mapping before it was done
[  157.636249] Replaced mapping before it was done
[  157.637547] Replaced mapping before it was done
[  157.642686] Replaced mapping before it was done
[  157.649446] Replaced mapping before it was done
[  157.650227] Replaced mapping before it was done
[  157.651483] Replaced mapping before it was done
[  157.662030] Replaced mapping before it was done
[  157.663748] Replaced mapping before it was done
[  157.665401] Replaced mapping before it was done
[  157.666178] Replaced mapping before it was done
[  157.676388] Replaced mapping before it was done
[  157.677191] Replaced mapping before it was done
[  157.678369] Replaced mapping before it was done
[  157.679087] Replaced mapping before it was done
[  157.690077] Replaced mapping before it was done
[  157.690824] Replaced mapping before it was done
[  157.692002] Replaced mapping before it was done
[  157.692786] Replaced mapping before it was done
[  157.694010] Replaced mapping before it was done
[  157.694784] Replaced mapping before it was done
[  157.703884] Replaced mapping before it was done
[  157.704634] Replaced mapping before it was done
[  157.705816] Replaced mapping before it was done
[  157.706580] Replaced mapping before it was done
[  157.708002] Replaced mapping before it was done
[  157.708800] Replaced mapping before it was done
[  157.718261] Replaced mapping before it was done
[  157.719053] Replaced mapping before it was done
[  157.720240] Replaced mapping before it was done
[  157.721016] Replaced mapping before it was done
[  157.722471] Replaced mapping before it was done
[  157.723247] Replaced mapping before it was done
[  157.736450] Replaced mapping before it was done
[  157.737240] Replaced mapping before it was done
[  157.738429] Replaced mapping before it was done
[  157.739208] Replaced mapping before it was done
[  157.740430] Replaced mapping before it was done
[  157.741213] Replaced mapping before it was done
[  157.752235] Replaced mapping before it was done
[  157.753022] Replaced mapping before it was done
[  157.754222] Replaced mapping before it was done
[  157.755002] Replaced mapping before it was done
[  157.755764] Replaced mapping before it was done
[  157.756923] Replaced mapping before it was done
[  157.757693] Replaced mapping before it was done
[  157.764862] Replaced mapping before it was done
[  157.765613] Replaced mapping before it was done
[  157.766410] Replaced mapping before it was done
[  157.767578] Replaced mapping before it was done
[  157.768789] Replaced mapping before it was done
[  157.769997] Replaced mapping before it was done
[  157.770796] Replaced mapping before it was done
[  157.772156] Replaced mapping before it was done
[  157.772939] Replaced mapping before it was done
[  157.778911] Replaced mapping before it was done
[  157.779687] Replaced mapping before it was done
[  157.780897] Replaced mapping before it was done
[  157.781667] Replaced mapping before it was done
[  157.783569] Replaced mapping before it was done
[  157.784324] Replaced mapping before it was done
[  157.785473] Replaced mapping before it was done
[  157.786384] Replaced mapping before it was done
[  157.792879] Replaced mapping before it was done
[  157.796139] Replaced mapping before it was done
[  157.797561] Replaced mapping before it was done
[  157.799165] Replaced mapping before it was done
[  157.799962] Replaced mapping before it was done
[  157.801428] Replaced mapping before it was done
[  157.802222] Replaced mapping before it was done
[  157.804827] Replaced mapping before it was done
[  157.805598] Replaced mapping before it was done
[ OK ]
# ns4  MPTCP -> ns2  (10.0.1.2:10058) TCP  	[ OK ]
# ns4  TCP   -> ns2  (10.0.1.2:10059) MPTCP	[ OK ]
# ns4  MPTCP -> ns2  (10.0.2.1:10060) MPTCP	[  157.806789] Replaced
mapping before it was done
[  166.903183] Replaced mapping before it was done
[  166.943365] Replaced mapping before it was done
[  166.948613] Replaced mapping before it was done
[  166.962651] Replaced mapping before it was done
[  166.963987] Replaced mapping before it was done
[  166.976260] Replaced mapping before it was done
[  166.987087] Replaced mapping before it was done
[  166.991032] Replaced mapping before it was done
[  167.003736] Replaced mapping before it was done
[  167.014847] Replaced mapping before it was done
[  167.016107] Replaced mapping before it was done
[  167.026187] Replaced mapping before it was done
[  167.038067] Replaced mapping before it was done
[  167.039304] Replaced mapping before it was done
[  167.052895] Replaced mapping before it was done
[  167.054371] Replaced mapping before it was done
[  167.055112] Replaced mapping before it was done
[  167.065909] Replaced mapping before it was done
[  167.067527] Replaced mapping before it was done
[  167.068299] Replaced mapping before it was done
[  167.078825] Replaced mapping before it was done
[  167.080105] Replaced mapping before it was done
[  167.091030] Replaced mapping before it was done
[  167.092289] Replaced mapping before it was done
[  167.103328] Replaced mapping before it was done
[  167.104098] Replaced mapping before it was done
[  167.105320] Replaced mapping before it was done
[  167.106236] Replaced mapping before it was done
[  167.107474] Replaced mapping before it was done
[  167.119817] Replaced mapping before it was done
[  167.125628] Replaced mapping before it was done
[  167.126415] Replaced mapping before it was done
[  167.127587] Replaced mapping before it was done
[  167.128422] Replaced mapping before it was done
[  167.139439] Replaced mapping before it was done
[  167.144177] Replaced mapping before it was done
[  167.145900] Replaced mapping before it was done
[  167.146792] Replaced mapping before it was done
[  167.147988] Replaced mapping before it was done
[  167.148819] Replaced mapping before it was done
[  167.149992] Replaced mapping before it was done
[  167.150932] Replaced mapping before it was done
[  167.152217] Replaced mapping before it was done
[  167.153009] Replaced mapping before it was done
[  167.158968] Replaced mapping before it was done
[  167.159759] Replaced mapping before it was done
[  167.160533] Replaced mapping before it was done
[  167.161618] Replaced mapping before it was done
[  167.162388] Replaced mapping before it was done
[  167.163119] Replaced mapping before it was done
[  167.163892] Replaced mapping before it was done
[  167.165032] Replaced mapping before it was done
[  167.165993] Replaced mapping before it was done
[  167.166781] Replaced mapping before it was done
[  167.177238] Replaced mapping before it was done
[  167.178028] Replaced mapping before it was done
[  167.178811] Replaced mapping before it was done
[  167.180117] Replaced mapping before it was done
[  167.181053] Replaced mapping before it was done
[  167.181994] Replaced mapping before it was done
[  167.183179] Replaced mapping before it was done
[  167.183928] Replaced mapping before it was done
[  167.184663] Replaced mapping before it was done
[  167.185701] Replaced mapping before it was done
[  167.186422] Replaced mapping before it was done
[  167.192883] Replaced mapping before it was done
[  167.193650] Replaced mapping before it was done
[  167.194830] Replaced mapping before it was done
[  167.195534] Replaced mapping before it was done
[  167.196665] Replaced mapping before it was done
[  167.197387] Replaced mapping before it was done
[  167.198535] Replaced mapping before it was done
[  167.199454] Replaced mapping before it was done
[  167.200589] Replaced mapping before it was done
[  167.201497] Replaced mapping before it was done
[  167.211678] Replaced mapping before it was done
[  167.213060] Replaced mapping before it was done
[  167.214417] Replaced mapping before it was done
[  167.215378] Replaced mapping before it was done
[  167.216302] Replaced mapping before it was done
[  167.224399] Replaced mapping before it was done
[  167.225225] Replaced mapping before it was done
[  167.226002] Replaced mapping before it was done
[  167.227140] Replaced mapping before it was done
[ OK ]
# ns4  MPTCP -> ns2  (10.0.2.1:10061) TCP  	[ OK ]
# ns4  TCP   -> ns2  (10.0.2.1:10062) MPTCP	[ OK ]
# ns4  MPTCP -> ns3  (10.0.2.2:10063) MPTCP	[ OK ]
# ns4  MPTCP -> ns3  (10.0.2.2:10064) TCP  	[ OK ]
# ns4  TCP   -> ns3  (10.0.2.2:10065) MPTCP	[ OK ]
# ns4  MPTCP -> ns3  (10.0.3.2:10066) MPTCP	[ OK ]
# ns4  MPTCP -> ns3  (10.0.3.2:10067) TCP  	[ OK ]
# ns4  TCP   -> ns3  (10.0.3.2:10068) MPTCP	[ OK ]
# ns4  MPTCP -> ns4  (10.0.3.1:10069) MPTCP	[ OK ]
# ns4  MPTCP -> ns4  (10.0.3.1:10070) TCP  	[ OK ]
# ns4  TCP   -> ns4  (10.0.3.1:10071) MPTCP	[ OK ]
ok 1 selftests: mptcp: mptcp_connect.sh
make[1]: warning:  Clock skew detected.  Your build may be incomplete.


A bit less without KASAN and PROVE_LOCKING (launched on May 28, 2019
16:47:08 UTC)


TAP version 13
1..1
# selftests: mptcp: mptcp_connect.sh
[   15.420305] ip (556) used greatest stack depth: 12168 bytes left
[   15.506125] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link becomes ready
# Error: Specified qdisc not found.
[   15.587395] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth3: link becomes ready
# Error: Specified qdisc not found.
[   15.735700] IPv6: ADDRCONF(NETDEV_CHANGE): ns3eth4: link becomes ready
# Created /tmp/tmp.p6Y0N8EF65 (size 142618) containing data sent by client
# Created /tmp/tmp.wDIjuigEtN (size 1320329) containing data sent by server
# ns1  MPTCP -> ns1  (10.0.1.1:10000) MPTCP	[   16.498671] IPv6:
ADDRCONF(NETDEV_CHANGE): ns2eth1: link becomes ready
[ OK ]
# ns1  MPTCP -> ns1  (10.0.1.1:10001) TCP  	[ OK ]
# ns1  TCP   -> ns1  (10.0.1.1:10002) MPTCP	[ OK ]
# ns1  MPTCP -> ns2  (10.0.1.2:10003) MPTCP	[ OK ]
# ns1  MPTCP -> ns2  (10.0.1.2:10004) TCP  	[ OK ]
# ns1  TCP   -> ns2  (10.0.1.2:10005) MPTCP	[ OK ]
# ns1  MPTCP -> ns2  (10.0.2.1:10006) MPTCP	[ OK ]
# ns1  MPTCP -> ns2  (10.0.2.1:10007) TCP  	[ OK ]
# ns1  TCP   -> ns2  (10.0.2.1:10008) MPTCP	[ OK ]
# ns1  MPTCP -> ns3  (10.0.2.2:10009) MPTCP	[   26.111191] Replaced
mapping before it was done
[   26.111217] Replaced mapping before it was done
[ OK ]
# ns1  MPTCP -> ns3  (10.0.2.2:10010) TCP  	[ OK ]
# ns1  TCP   -> ns3  (10.0.2.2:10011) MPTCP	[ OK ]
# ns1  MPTCP -> ns3  (10.0.3.2:10012) MPTCP	[   26.111949] Replaced
mapping before it was done
[   29.213623] Replaced mapping before it was done
[   29.214367] Replaced mapping before it was done
[   29.215425] Replaced mapping before it was done
[   29.216188] Replaced mapping before it was done
[   29.216875] Replaced mapping before it was done
[   29.217566] Replaced mapping before it was done
[   29.218222] Replaced mapping before it was done
[   29.218919] Replaced mapping before it was done
[   29.219606] Replaced mapping before it was done
[   29.220284] Replaced mapping before it was done
[   29.220978] Replaced mapping before it was done
[   29.221677] Replaced mapping before it was done
[   29.222379] Replaced mapping before it was done
[   29.223062] Replaced mapping before it was done
[   29.224121] Replaced mapping before it was done
[   29.225069] Replaced mapping before it was done
[   29.225752] Replaced mapping before it was done
[   29.226462] Replaced mapping before it was done
[ OK ]
# ns1  MPTCP -> ns3  (10.0.3.2:10013) TCP  	[ OK ]
# ns1  TCP   -> ns3  (10.0.3.2:10014) MPTCP	[ OK ]
# ns1  MPTCP -> ns4  (10.0.3.1:10015) MPTCP	[   29.227212] Replaced
mapping before it was done
[   32.331271] Replaced mapping before it was done
[   32.332024] Replaced mapping before it was done
[   32.332740] Replaced mapping before it was done
[   32.333487] Replaced mapping before it was done
[   32.334283] Replaced mapping before it was done
[   32.336077] Replaced mapping before it was done
[ OK ]
# ns1  MPTCP -> ns4  (10.0.3.1:10016) TCP  	[ OK ]
# ns1  TCP   -> ns4  (10.0.3.1:10017) MPTCP	[ OK ]
# ns2  MPTCP -> ns1  (10.0.1.1:10018) MPTCP	[ OK ]
# ns2  MPTCP -> ns1  (10.0.1.1:10019) TCP  	[ OK ]
# ns2  TCP   -> ns1  (10.0.1.1:10020) MPTCP	[ OK ]
# ns2  MPTCP -> ns2  (10.0.1.2:10021) MPTCP	[ OK ]
# ns2  MPTCP -> ns2  (10.0.1.2:10022) TCP  	[ OK ]
# ns2  TCP   -> ns2  (10.0.1.2:10023) MPTCP	[ OK ]
# ns2  MPTCP -> ns2  (10.0.2.1:10024) MPTCP	[ OK ]
# ns2  MPTCP -> ns2  (10.0.2.1:10025) TCP  	[ OK ]
# ns2  TCP   -> ns2  (10.0.2.1:10026) MPTCP	[ OK ]
# ns2  MPTCP -> ns3  (10.0.2.2:10027) MPTCP	[   32.336955] Replaced
mapping before it was done
[   44.709910] Replaced mapping before it was done
[   44.711156] Replaced mapping before it was done
[   44.711993] Replaced mapping before it was done
[   44.712730] Replaced mapping before it was done
[   44.713422] Replaced mapping before it was done
[   44.714121] Replaced mapping before it was done
[   44.714813] Replaced mapping before it was done
[   44.715560] Replaced mapping before it was done
[   44.716425] Replaced mapping before it was done
[   44.717091] Replaced mapping before it was done
[   44.717943] Replaced mapping before it was done
[   44.718569] Replaced mapping before it was done
[   44.719232] Replaced mapping before it was done
[   44.719944] Replaced mapping before it was done
[ OK ]
# ns2  MPTCP -> ns3  (10.0.2.2:10028) TCP  	[ OK ]
# ns2  TCP   -> ns3  (10.0.2.2:10029) MPTCP	[ OK ]
# ns2  MPTCP -> ns3  (10.0.3.2:10030) MPTCP	[   44.720685] Replaced
mapping before it was done
[   47.811611] Replaced mapping before it was done
[   47.812545] Replaced mapping before it was done
[   47.813250] Replaced mapping before it was done
[   47.814007] Replaced mapping before it was done
[   47.814731] Replaced mapping before it was done
[   47.815444] Replaced mapping before it was done
[   47.816155] Replaced mapping before it was done
[   47.816880] Replaced mapping before it was done
[   47.817570] Replaced mapping before it was done
[ OK ]
# ns2  MPTCP -> ns3  (10.0.3.2:10031) TCP  	[ OK ]
# ns2  TCP   -> ns3  (10.0.3.2:10032) MPTCP	[ OK ]
# ns2  MPTCP -> ns4  (10.0.3.1:10033) MPTCP	[   47.818284] Replaced
mapping before it was done
[   50.919166] Replaced mapping before it was done
[   50.920186] Replaced mapping before it was done
[   50.920967] Replaced mapping before it was done
[   50.921695] Replaced mapping before it was done
[   50.922365] Replaced mapping before it was done
[ OK ]
# ns2  MPTCP -> ns4  (10.0.3.1:10034) TCP  	[ OK ]
# ns2  TCP   -> ns4  (10.0.3.1:10035) MPTCP	[ OK ]
# ns3  MPTCP -> ns1  (10.0.1.1:10036) MPTCP	[   50.923077] Replaced
mapping before it was done
[   54.023781] Replaced mapping before it was done
[ OK ]
# ns3  MPTCP -> ns1  (10.0.1.1:10037) TCP  	[ OK ]
# ns3  TCP   -> ns1  (10.0.1.1:10038) MPTCP	[ OK ]
# ns3  MPTCP -> ns2  (10.0.1.2:10039) MPTCP	[   54.024528] Replaced
mapping before it was done
[   57.122333] Replaced mapping before it was done
[   57.123256] Replaced mapping before it was done
[   57.123867] Replaced mapping before it was done
[   57.125187] Replaced mapping before it was done
[ OK ]
# ns3  MPTCP -> ns2  (10.0.1.2:10040) TCP  	[ OK ]
# ns3  TCP   -> ns2  (10.0.1.2:10041) MPTCP	[ OK ]
# ns3  MPTCP -> ns2  (10.0.2.1:10042) MPTCP	[   57.125966] Replaced
mapping before it was done
[   60.223267] Replaced mapping before it was done
[   60.223975] Replaced mapping before it was done
[   60.224649] Replaced mapping before it was done
[ OK ]
# ns3  MPTCP -> ns2  (10.0.2.1:10043) TCP  	[ OK ]
# ns3  TCP   -> ns2  (10.0.2.1:10044) MPTCP	[ OK ]
# ns3  MPTCP -> ns3  (10.0.2.2:10045) MPTCP	[ OK ]
# ns3  MPTCP -> ns3  (10.0.2.2:10046) TCP  	[ OK ]
# ns3  TCP   -> ns3  (10.0.2.2:10047) MPTCP	[ OK ]
# ns3  MPTCP -> ns3  (10.0.3.2:10048) MPTCP	[ OK ]
# ns3  MPTCP -> ns3  (10.0.3.2:10049) TCP  	[ OK ]
# ns3  TCP   -> ns3  (10.0.3.2:10050) MPTCP	[ OK ]
# ns3  MPTCP -> ns4  (10.0.3.1:10051) MPTCP	[ OK ]
# ns3  MPTCP -> ns4  (10.0.3.1:10052) TCP  	[ OK ]
# ns3  TCP   -> ns4  (10.0.3.1:10053) MPTCP	[ OK ]
# ns4  MPTCP -> ns1  (10.0.1.1:10054) MPTCP	[   60.225606] Replaced
mapping before it was done
[   72.597843] Replaced mapping before it was done
[ OK ]
# ns4  MPTCP -> ns1  (10.0.1.1:10055) TCP  	[ OK ]
# ns4  TCP   -> ns1  (10.0.1.1:10056) MPTCP	[ OK ]
# ns4  MPTCP -> ns2  (10.0.1.2:10057) MPTCP	[   72.598742] Replaced
mapping before it was done
[ OK ]
# ns4  MPTCP -> ns2  (10.0.1.2:10058) TCP  	[ OK ]
# ns4  TCP   -> ns2  (10.0.1.2:10059) MPTCP	[ OK ]
# ns4  MPTCP -> ns2  (10.0.2.1:10060) MPTCP	[   75.699965] Replaced
mapping before it was done
[ OK ]
# ns4  MPTCP -> ns2  (10.0.2.1:10061) TCP  	[ OK ]
# ns4  TCP   -> ns2  (10.0.2.1:10062) MPTCP	[ OK ]
# ns4  MPTCP -> ns3  (10.0.2.2:10063) MPTCP	[ OK ]
# ns4  MPTCP -> ns3  (10.0.2.2:10064) TCP  	[ OK ]
# ns4  TCP   -> ns3  (10.0.2.2:10065) MPTCP	[ OK ]
# ns4  MPTCP -> ns3  (10.0.3.2:10066) MPTCP	[ OK ]
# ns4  MPTCP -> ns3  (10.0.3.2:10067) TCP  	[ OK ]
# ns4  TCP   -> ns3  (10.0.3.2:10068) MPTCP	[ OK ]
# ns4  MPTCP -> ns4  (10.0.3.1:10069) MPTCP	[ OK ]
# ns4  MPTCP -> ns4  (10.0.3.1:10070) TCP  	[ OK ]
# ns4  TCP   -> ns4  (10.0.3.1:10071) MPTCP	[ OK ]
ok 1 selftests: mptcp: mptcp_connect.sh
make[1]: warning:  Clock skew detected.  Your build may be incomplete.



Can be reproduced by downloading the two *virtme.sh scripts from the
"scripts" branch:

  https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/ci

and launching the Docker script:

  bash -x patches/docker/Dockerfile.virtme.sh patches/virtme.sh

Docker is the only real dependence.

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5301884406077510134==--
