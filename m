Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6142C9D
	for <mptcp@lists.linux.dev>; Sat,  8 Jan 2022 17:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1641664696; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NwqtqPdOyS68ktlx2wX/O6M2X+Yqom/6oWJWALGc9G1pIs0GAeOxrDyZgjXj8/gQdOS+wwQT95BI2GeGXmmXGRhFepWT+dN6Uy1f/HzVhlv94JahpSI+ZL/0GRWpjxGAPpaDFqC0IvXjFtEjk3l6DvryckDyVCbdVNae6FRncJg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1641664696; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=X1bEkkMQCxm41yz3C54IeDcfvaoWJ90STovCYG6VZcc=; 
	b=QYBTcE9Si5ry9D6X9Anm4FaGYvJVQw56y1l02vh/NyJSB5+IIFVpAOpGeLU5ftCAg3oCwX3LhpDYa8jAMKj2c7h144HrMgaDiZ3mOim914JyIhJOrpDYU+f6038CRFm6Woq5wzcFlrJ26LY+0n9LAzVi37+FFijXQyRS7WFCTc8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1641664696;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Subject:MIME-Version:Content-Type;
	bh=X1bEkkMQCxm41yz3C54IeDcfvaoWJ90STovCYG6VZcc=;
	b=KSf7OQU81VGBiK8Y5qeKsw/9Lk8DHwCRekxSvfc/kDbxlBz3loJAjYr7k4UmeZPw
	A2T8+xgDDX6TnfTmu3ce+ShyEA1k0JLyQ9a2Ejd3ADo9m9aBKxPmtVEICPgPH4FiQGr
	1zx/2TopHcUz9/cPQsyWbxJeKgpquL5FxPZjIH28=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1641664690129171.4882415910305; Sat, 8 Jan 2022 18:58:10 +0100 (CET)
Date: Sat, 08 Jan 2022 18:58:10 +0100
From: Dmytro Shytyi <dmytro@shytyi.net>
To: "mptcp" <mptcp@lists.linux.dev>,
	"Matthieu Baerts" <matthieu.baerts@tessares.net>
Cc: "mathewjmartineau" <mathew.j.martineau@linux.intel.com>
Message-Id: <17e3ad737a6.11773db21196328.7247055283158244704@shytyi.net>
In-Reply-To: <17d8c64c442.11c026c79399960.5261313972320451268@shytyi.net>
References: <17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net>
 <a52c4e6d-8463-6328-c786-9cb8b71ac62e@tessares.net>
 <17cb73b1343.c752fede1729351.6463099199494289591@shytyi.net> <868a9dcc-9001-cdd8-c655-dabe7b8f9222@tessares.net> <17d8c64c442.11c026c79399960.5261313972320451268@shytyi.net>
Subject: Re: [PATCH net-next v1] net: mptcp, Fast Open Mechanism
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_711688_1572048598.1641664690086"
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Zoho-Virus-Status: 1

------=_Part_711688_1572048598.1641664690086
Content-Type: multipart/alternative; 
	boundary="----=_Part_711689_1542745249.1641664690086"

------=_Part_711689_1542745249.1641664690086
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,



I'm writing this message to post another update regarding the work on fasto=
pen mechanism in MPTCP.



Changelog:

1. Packet retransmissions are fixed.

2. The final ack (was missing) is now present during the exchange 3way hand=
shake during TFO cookie request.



Work is in process...



If you find any anomaly, comments are welcome.



Tcpdump log + pcap trace are attached.





Tcpdump log:


awesome@ferby:~/workspace/new-ns$ sudo ip netns exec client ./client

17:23:50.587922 IP 10.0.0.1.35282 > 10.0.0.2.7003: Flags [S], seq 391007048=
9, win 64240, options [mss 1460,sackOK,TS val 2969564598 ecr 0,nop,wscale 7=
,tfo=C2=A0 cookiereq,nop,nop,mptcp capable[bad opt]>

17:23:50.587955 IP 10.0.0.2.7003 > 10.0.0.1.35282: Flags [S.], seq 38066374=
30, ack 3910070490, win 65160, options [mss 1460,sackOK,TS val 2284154585 e=
cr 2969564598,nop,wscale 7,tfo=C2=A0 cookie 5e09b5dd,nop,nop,mptcp capable =
Unknown Version (1)], length 0

17:23:50.587997 IP 10.0.0.1.35282 > 10.0.0.2.7003: Flags [.], ack 1, win 50=
2, options [nop,nop,TS val 2969564598 ecr 2284154585,mptcp capable Unknown =
Version (1)], length 0

17:23:50.589091 IP 10.0.0.1.35282 > 10.0.0.2.7003: Flags [P.], seq 1:4, ack=
 1, win 502, options [nop,nop,TS val 2969564599 ecr 2284154585,mptcp capabl=
e[bad opt]>

17:23:50.589149 IP 10.0.0.2.7003 > 10.0.0.1.35282: Flags [.], ack 4, win 51=
0, options [nop,nop,TS val 2284154586 ecr 2969564599,mptcp dss ack 66534524=
24296905113], length 0

17:23:50.591278 IP 10.0.0.1.35282 > 10.0.0.2.7003: Flags [P.], seq 4:7, ack=
 1, win 502, options [nop,nop,TS val 2969564601 ecr 2284154586,mptcp dss ac=
k 3417001499 seq 6653452424296905113 subseq 4 len 3,nop,nop], length 3

17:23:50.591382 IP 10.0.0.2.7003 > 10.0.0.1.35282: Flags [.], ack 7, win 51=
0, options [nop,nop,TS val 2284154588 ecr 2969564601,mptcp dss ack 66534524=
24296905116], length 0

17:23:50.591433 IP 10.0.0.1.35282 > 10.0.0.2.7003: Flags [P.], seq 7:10, ac=
k 1, win 502, options [nop,nop,TS val 2969564601 ecr 2284154588,mptcp dss a=
ck 3417001499 seq 6653452424296905116 subseq 7 len 3,nop,nop], length 3

17:23:50.591441 IP 10.0.0.2.7003 > 10.0.0.1.35282: Flags [.], ack 10, win 5=
10, options [nop,nop,TS val 2284154588 ecr 2969564601,mptcp dss ack 6653452=
424296905119], length 0

17:23:50.591458 IP 10.0.0.1.35282 > 10.0.0.2.7003: Flags [P.], seq 10:13, a=
ck 1, win 502, options [nop,nop,TS val 2969564601 ecr 2284154588,mptcp dss =
ack 3417001499 seq 6653452424296905119 subseq 10 len 3,nop,nop], length 3

17:23:50.591465 IP 10.0.0.2.7003 > 10.0.0.1.35282: Flags [.], ack 13, win 5=
10, options [nop,nop,TS val 2284154588 ecr 2969564601,mptcp dss ack 6653452=
424296905122], length 0

17:23:50.591479 IP 10.0.0.1.35282 > 10.0.0.2.7003: Flags [P.], seq 13:16, a=
ck 1, win 502, options [nop,nop,TS val 2969564601 ecr 2284154588,mptcp dss =
ack 3417001499 seq 6653452424296905122 subseq 13 len 3,nop,nop], length 3

17:23:50.591485 IP 10.0.0.2.7003 > 10.0.0.1.35282: Flags [.], ack 16, win 5=
10, options [nop,nop,TS val 2284154588 ecr 2969564601,mptcp dss ack 6653452=
424296905125], length 0

17:24:51.757234 IP 10.0.0.2.7003 > 10.0.0.1.35282: Flags [F.], seq 1, ack 1=
6, win 510, options [nop,nop,TS val 2284215754 ecr 2969564601,mptcp dss fin=
 ack 6653452424296905125 seq 12259594063739309595 subseq 0 len 1,nop,nop], =
length 0

17:24:51.757252 IP 10.0.0.1.35282 > 10.0.0.2.7003: Flags [F.], seq 16, ack =
1, win 502, options [nop,nop,TS val 2969625767 ecr 2284154588,mptcp dss fin=
 ack 3417001499 seq 6653452424296905125 subseq 0 len 1,nop,nop], length 0

17:24:51.757364 IP 10.0.0.2.7003 > 10.0.0.1.35282: Flags [.], ack 17, win 5=
10, options [nop,nop,TS val 2284215754 ecr 2969625767,mptcp dss fin ack 665=
3452424296905125 seq 12259594063739309595 subseq 0 len 1,nop,nop], length 0

17:24:51.757367 IP 10.0.0.1.35282 > 10.0.0.2.7003: Flags [.], ack 2, win 50=
2, options [nop,nop,TS val 2969625767 ecr 2284215754,mptcp dss fin ack 3417=
001499 seq 6653452424296905125 subseq 0 len 1,nop,nop], length 0




awesome@ferby:~/workspace/new-ns$ sudo ip netns exec client ./client

17:24:00.975725 IP 10.0.0.1.35284 > 10.0.0.2.7003: Flags [S], seq 182310672=
8:1823106731, win 64240, options [mss 1460,sackOK,TS val 2969574986 ecr 0,n=
op,wscale 7,tfo=C2=A0 cookie 5e09b5dd,nop,nop,mptcp capable[bad opt]>

17:24:00.975783 IP 10.0.0.2.7003 > 10.0.0.1.35284: Flags [S.], seq 31071291=
98, ack 1823106732, win 65160, options [mss 1460,sackOK,TS val 2284164973 e=
cr 2969574986,nop,wscale 7,mptcp capable Unknown Version (1)], length 0

17:24:00.975896 IP 10.0.0.1.35284 > 10.0.0.2.7003: Flags [.], ack 1, win 50=
2, options [nop,nop,TS val 2969574986 ecr 2284164973,mptcp capable Unknown =
Version (1)], length 0

17:24:00.976880 IP 10.0.0.1.35284 > 10.0.0.2.7003: Flags [P.], seq 1:4, ack=
 1, win 502, options [nop,nop,TS val 2969574987 ecr 2284164973,mptcp capabl=
e[bad opt]>

17:24:00.977097 IP 10.0.0.2.7003 > 10.0.0.1.35284: Flags [.], ack 4, win 51=
0, options [nop,nop,TS val 2284164974 ecr 2969574987,mptcp dss ack 17277082=
426285855013], length 0

17:24:00.977148 IP 10.0.0.1.35284 > 10.0.0.2.7003: Flags [P.], seq 4:7, ack=
 1, win 502, options [nop,nop,TS val 2969574987 ecr 2284164974,mptcp dss ac=
k 3342174256 seq 777308174741155629 subseq 4 len 3,nop,nop], length 3

17:24:00.977163 IP 10.0.0.2.7003 > 10.0.0.1.35284: Flags [.], ack 7, win 51=
0, options [nop,nop,TS val 2284164974 ecr 2969574987,mptcp dss ack 17277082=
426285855016], length 0

17:24:00.977184 IP 10.0.0.1.35284 > 10.0.0.2.7003: Flags [P.], seq 7:10, ac=
k 1, win 502, options [nop,nop,TS val 2969574987 ecr 2284164974,mptcp dss a=
ck 3342174256 seq 777308174741155632 subseq 7 len 3,nop,nop], length 3

17:24:00.977192 IP 10.0.0.2.7003 > 10.0.0.1.35284: Flags [.], ack 10, win 5=
10, options [nop,nop,TS val 2284164974 ecr 2969574987,mptcp dss ack 1727708=
2426285855019], length 0

17:24:00.977230 IP 10.0.0.1.35284 > 10.0.0.2.7003: Flags [P.], seq 10:13, a=
ck 1, win 502, options [nop,nop,TS val 2969574987 ecr 2284164974,mptcp dss =
ack 3342174256 seq 777308174741155635 subseq 10 len 3,nop,nop], length 3

17:24:00.977243 IP 10.0.0.2.7003 > 10.0.0.1.35284: Flags [.], ack 13, win 5=
10, options [nop,nop,TS val 2284164974 ecr 2969574987,mptcp dss ack 1727708=
2426285855022], length 0

17:25:01.997117 IP 10.0.0.2.7003 > 10.0.0.1.35284: Flags [F.], seq 1, ack 1=
3, win 510, options [nop,nop,TS val 2284225994 ecr 2969574987,mptcp dss fin=
 ack 17277082426285855022 seq 1417219265470498864 subseq 0 len 1,nop,nop], =
length 0

17:25:01.997180 IP 10.0.0.1.35284 > 10.0.0.2.7003: Flags [F.], seq 13, ack =
1, win 502, options [nop,nop,TS val 2969636007 ecr 2284164974,mptcp dss fin=
 ack 3342174256 seq 777308174741155638 subseq 0 len 1,nop,nop], length 0

17:25:01.997232 IP 10.0.0.2.7003 > 10.0.0.1.35284: Flags [.], ack 14, win 5=
10, options [nop,nop,TS val 2284225994 ecr 2969636007,mptcp dss fin ack 172=
77082426285855022 seq 1417219265470498864 subseq 0 len 1,nop,nop], length 0

17:25:01.997233 IP 10.0.0.1.35284 > 10.0.0.2.7003: Flags [.], ack 2, win 50=
2, options [nop,nop,TS val 2969636007 ecr 2284225994,mptcp dss fin ack 3342=
174256 seq 777308174741155638 subseq 0 len 1,nop,nop], length 0



Userspace data exchange:





awesome@ferby:~/workspace/new-ns$ sudo ip netns exec client ./client

received abc from client

received zzz from client

received zzz from client

received zzz from client

received fff from client



awesome@ferby:~/workspace/new-ns$ sudo ip netns exec client ./client

received abc from client

received zzz from client

received zzz from client

received zzz from client

received fff from client





Best regards,
Dmytro SHYTYI.



> Hello all,

>=C2=A0

> I'm writing this message to post an update regarding the work on fastopen=
 mechanism.

> Evolution of fastopen PATCH is far away from submission yet (packet retra=
nsmissions are present), but there are good signs.

> Notably I attach the pcap wireshark that includes client + server in 2 di=
fferent namespaces:

>=C2=A0 > > 1. MPTCP cookie request from client.

>=C2=A0 > > 2. MPTCP cookie offering from server.

>=C2=A0 > > 3. MPTCP SYN+DATA+COOKIE from client.

>=C2=A0 > > 4. subsequent write + read on the opened socket.

> Finally the userspace application receives the data send in the SYN+DATA+=
COOKIE. You may find the examples in the prinf+tcpdump log on the bottom of=
 the message as a bonus...

>=C2=A0

> I'm looking what I have to adjust to fix packet retransmissions. If you h=
ave in mind some ideas/suggestions, you are welcome to provide some comment=
s (in mailing list or maybe in private),

>=C2=A0

> awesome@ferby:~/workspace/new-ns$ sudo ip netns exec client ./client

> info: 0

> ACCEPT_SUCCESS: Success

> SERVER_READ_SUCCESS: Success

> received z from client

> SERVER_READ_SUCCESS: Success

> received z from client

> SERVER_READ_SUCCESS: Success

> received z from client

> SERVER_READ_SUCCESS: Success

> received a from client

> SERVER_READ_SUCCESS: Success

> received f from client

>=C2=A0

> 22:49:21.410344 IP 10.0.0.1.37980 > 10.0.0.2.7003: Flags [S], seq 3325457=
504, win 64240, options [mss 1460,sackOK,TS val 1084403317 ecr 0,nop,wscale=
 7,tfo cookiereq,nop,nop,mptcp capable[bad opt]>

> 22:49:21.410367 IP 10.0.0.2.7003 > 10.0.0.1.37980: Flags [S.], seq 192968=
1786, ack 3325457505, win 65160, options [mss 1460,sackOK,TS val 1487352723=
 ecr 1084403317,nop,wscale 7,tfo cookie d0f85d19,nop,nop,mptcp capable Unkn=
own Version (1)], length 0

> 22:49:21.412560 IP 10.0.0.1.37980 > 10.0.0.2.7003: Flags [P.], seq 1:2, a=
ck 1, win 502, options [nop,nop,TS val 1084403319 ecr 1487352723,mptcp capa=
ble[bad opt]>

> 22:49:21.412621 IP 10.0.0.2.7003 > 10.0.0.1.37980: Flags [.], ack 2, win =
510, options [nop,nop,TS val 1487352725 ecr 1084403319,mptcp dss ack 128800=
89298653898158], length 0

> 22:49:21.413113 IP 10.0.0.1.37980 > 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084403319 ecr 1487352725,mptcp dss ack 316880=
4441], length 0

> 22:49:21.413134 IP 10.0.0.1.37980 > 10.0.0.2.7003: Flags [P.], seq 2:3, a=
ck 1, win 502, options [nop,nop,TS val 1084403320 ecr 1487352725,mptcp dss =
ack 3168804441 seq 12880089298653898158 subseq 2 len 1,nop,nop], length 1

> 22:49:21.413139 IP 10.0.0.2.7003 > 10.0.0.1.37980: Flags [.], ack 3, win =
510, options [nop,nop,TS val 1487352726 ecr 1084403320,mptcp dss ack 128800=
89298653898159], length 0

> 22:49:21.413394 IP 10.0.0.1.37980 > 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084403320 ecr 1487352726,mptcp dss ack 316880=
4441], length 0

> 22:49:21.413408 IP 10.0.0.1.37980 > 10.0.0.2.7003: Flags [P.], seq 3:4, a=
ck 1, win 502, options [nop,nop,TS val 1084403320 ecr 1487352726,mptcp dss =
ack 3168804441 seq 12880089298653898159 subseq 3 len 1,nop,nop], length 1

> 22:49:21.413411 IP 10.0.0.2.7003 > 10.0.0.1.37980: Flags [.], ack 4, win =
510, options [nop,nop,TS val 1487352726 ecr 1084403320,mptcp dss ack 128800=
89298653898160], length 0

> 22:49:21.413674 IP 10.0.0.1.37980 > 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084403320 ecr 1487352726,mptcp dss ack 316880=
4441], length 0

> 22:49:21.413699 IP 10.0.0.1.37980 > 10.0.0.2.7003: Flags [P.], seq 4:5, a=
ck 1, win 502, options [nop,nop,TS val 1084403320 ecr 1487352726,mptcp dss =
ack 3168804441 seq 12880089298653898160 subseq 4 len 1,nop,nop], length 1

> 22:49:21.413944 IP 10.0.0.1.37980 > 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084403320 ecr 1487352726,mptcp dss ack 316880=
4441], length 0

> 22:49:21.414206 IP 10.0.0.2.7003 > 10.0.0.1.37980: Flags [.], ack 6, win =
510, options [nop,nop,TS val 1487352727 ecr 1084403321,mptcp dss fin ack 12=
880089298653898162 seq 11302478206648458841 subseq 0 len 1,nop,nop], length=
 0

>=C2=A0

>=C2=A0

> awesome@ferby:~/workspace/new-ns$ sudo ip netns exec client ./client

> ACCEPT_SUCCESS: Success

> SERVER_READ_SUCCESS: Success

> received a from client <<<<<<<<<<<<<<< THIS "A" CHARACTER IS A PART OF TH=
E SYN+DATA+COOKIE.

> info: 0

> SERVER_READ_SUCCESS: Success

> received z from client

> SERVER_READ_SUCCESS: Success

> received z from client

> SERVER_READ_SUCCESS: Success

> received z from client

> SERVER_READ_SUCCESS: Success

> received a from client

> SERVER_READ_SUCCESS: Success

> received f from client

> 22:52:11.262622 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [S], seq 5495371=
83:549537184, win 64240, options [mss 1460,sackOK,TS val 1084573169 ecr 0,n=
op,wscale 7,tfo cookie d0f85d19,nop,nop,mptcp capable[bad opt]>

> 22:52:11.262767 IP 10.0.0.2.7003 > 10.0.0.1.37982: Flags [S.], seq 409250=
4081, ack 549537185, win 65160, options [mss 1460,sackOK,TS val 1487522575 =
ecr 1084573169,nop,wscale 7,mptcp capable Unknown Version (1)], length 0

> 22:52:11.262810 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084573169 ecr 1487522575,mptcp capable Unknow=
n Version (1)], length 0

> 22:52:11.266377 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [P.], seq 1:2, a=
ck 1, win 502, options [nop,nop,TS val 1084573173 ecr 1487522575,mptcp capa=
ble[bad opt]>

> 22:52:11.266451 IP 10.0.0.2.7003 > 10.0.0.1.37982: Flags [.], ack 2, win =
510, options [nop,nop,TS val 1487522579 ecr 1084573173,mptcp dss ack 128817=
47887342348535], length 0

> 22:52:11.266904 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084573173 ecr 1487522579,mptcp dss ack 379829=
7942], length 0

> 22:52:11.267039 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [P.], seq 2:3, a=
ck 1, win 502, options [nop,nop,TS val 1084573174 ecr 1487522579,mptcp dss =
ack 3798297942 seq 746326162666601844 subseq 2 len 1,nop,nop], length 1

> 22:52:11.267050 IP 10.0.0.2.7003 > 10.0.0.1.37982: Flags [.], ack 3, win =
510, options [nop,nop,TS val 1487522580 ecr 1084573174,mptcp dss ack 128817=
47887342348536], length 0

> 22:52:11.267427 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084573174 ecr 1487522580,mptcp dss ack 379829=
7942], length 0

> 22:52:11.267454 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [P.], seq 3:4, a=
ck 1, win 502, options [nop,nop,TS val 1084573174 ecr 1487522580,mptcp dss =
ack 3798297942 seq 746326162666601845 subseq 3 len 1,nop,nop], length 1

> 22:52:11.267461 IP 10.0.0.2.7003 > 10.0.0.1.37982: Flags [.], ack 4, win =
510, options [nop,nop,TS val 1487522580 ecr 1084573174,mptcp dss ack 128817=
47887342348537], length 0

> 22:52:11.267957 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084573174 ecr 1487522580,mptcp dss ack 379829=
7942], length 0

> 22:52:11.267988 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [P.], seq 4:5, a=
ck 1, win 502, options [nop,nop,TS val 1084573175 ecr 1487522580,mptcp dss =
ack 3798297942 seq 746326162666601846 subseq 4 len 1,nop,nop], length 1

> 22:52:11.267995 IP 10.0.0.2.7003 > 10.0.0.1.37982: Flags [.], ack 5, win =
510, options [nop,nop,TS val 1487522581 ecr 1084573175,mptcp dss ack 128817=
47887342348538], length 0

> 22:52:11.268546 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084573175 ecr 1487522581,mptcp dss ack 379829=
7942], length 0

> 22:52:11.268594 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [P.], seq 5:6, a=
ck 1, win 502, options [nop,nop,TS val 1084573175 ecr 1487522581,mptcp dss =
ack 3798297942 seq 746326162666601847 subseq 5 len 1,nop,nop], length 1

> 22:52:11.268603 IP 10.0.0.2.7003 > 10.0.0.1.37982: Flags [.], ack 6, win =
510, options [nop,nop,TS val 1487522581 ecr 1084573175,mptcp dss ack 128817=
47887342348539], length 0

> 22:52:11.269735 IP 10.0.0.2.7003 > 10.0.0.1.37982: Flags [.], ack 6, win =
510, options [nop,nop,TS val 1487522581 ecr 1084573175,mptcp dss fin ack 12=
881747887342348539 seq 9620565311902543190 subseq 0 len 1,nop,nop], length =
0

> 22:52:11.269846 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084573176 ecr 1487522581,mptcp dss ack 379829=
7942], length 0

> 22:52:11.469004 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084573177 ecr 1487522583,mptcp dss fin ack 37=
98297943 seq 746326162666601848 subseq 0 len 1,nop,nop], length 0

> 22:52:11.472189 IP 10.0.0.2.7003 > 10.0.0.1.37982: Flags [.], ack 6, win =
510, options [nop,nop,TS val 1487522782 ecr 1084573177,mptcp dss ack 128817=
47887342348539], length 0

> 22:53:11.672337 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084573379 ecr 1487522782,mptcp dss fin ack 37=
98297943 seq 746326162666601848 subseq 0 len 1,nop,nop], length 0

> 22:53:11.672425 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [F.], seq 6, ack=
 1, win 502, options [nop,nop,TS val 1084633579 ecr 1487522782,mptcp dss fi=
n ack 3798297943 seq 746326162666601848 subseq 0 len 1,nop,nop], length 0

> 22:53:11.672461 IP 10.0.0.2.7003 > 10.0.0.1.37982: Flags [.], ack 7, win =
510, options [nop,nop,TS val 1487582985 ecr 1084633579,mptcp dss ack 128817=
47887342348539], length 0

> 22:53:11.672515 IP 10.0.0.2.7003 > 10.0.0.1.37982: Flags [F.], seq 1, ack=
 7, win 510, options [nop,nop,TS val 1487582985 ecr 1084633579,mptcp dss ac=
k 12881747887342348539], length 0

> 22:53:11.672545 IP 10.0.0.1.37982 > 10.0.0.2.7003: Flags [.], ack 2, win =
502, options [nop,nop,TS val 1084633579 ecr 1487582985], length 0

>=C2=A0

> Thanks,

> Dmytro.

> >

> > Hi Dmytro,

> >

> > On 25/10/2021 13:34, Dmytro Shytyi wrote:

> > >

> > > ---- On Fri, 22 Oct 2021 11:22:31 +0200 Matthieu Baerts <mailto:matth=
ieu.baerts@tessares.net> wrote ----

> > >

> > > > Hi Dmytro,

> > > >

> >

> > Small detail: it looks like your email client is adding unusual spaces

> > before ">" to quote the previous message. That's not a big issue but it

> > makes other email clients and even lore [1] not interpreting that as

> > quotes, e.g. on lore, you can see the quotes are in blue in my reply an=
d

> > Mat's one but not in yours.

> >

> > [1]

> > https://lore.kernel.org/mptcp/17cb73b1343.c752fede1729351.6463099199494=
289591@shytyi.net/T/#t

> >

> > (...)

> >

> > > > I hope this might help reviewing the new versions ;-)

> > >

> > > Thank you, Metthieu.

> > > I'm working on PATCH net-next v2 net: mptcp. It will include all your=
 comments, except this one:

> > >

> > > > It looks like you don't use it. Does the compiler not complain abou=
t that?

> > > >

> > > > > + tp->fastopen_req =3D kzalloc(sizeof(*tp->fatopen_req),

> > > > > + ssk->sk->sk_allocation);

> > > Compiler not compalin about that because it is used in the code.

> >

> > In the version you sent, in mptcp_sendmsg_fastopen_cookie_send() you ar=
e

> > indeed using it but not it in mptcp_sendmsg_fastopen_cookie_req(), no?

> >

> > Cheers,

> > Matt

> > --

> > Tessares | Belgium | Hybrid Access Solutions

> >http://www.tessares.net
------=_Part_711689_1542745249.1641664690086
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head>=
<meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"></h=
ead><body ><div style=3D"font-family: Verdana, Arial, Helvetica, sans-serif=
; font-size: 10pt;"><div><div style=3D"font-family: Verdana, Arial, Helveti=
ca, sans-serif;font-size: 10.0pt;"><div>Hello all,<br></div><div><br></div>=
<div>I'm writing this message to post another update regarding the work on =
fastopen mechanism in MPTCP.<br></div><div><br></div><div>Changelog:<br></d=
iv><div>1. Packet retransmissions are fixed.<br></div><div>2. The final ack=
 (was missing) is now present during the exchange 3way handshake during TFO=
 cookie request.<br></div><div><br></div><div>Work is in process...<br></di=
v><div><br></div><div>If you find any anomaly, comments are welcome.<br></d=
iv><div><br></div><div>Tcpdump log + pcap trace are attached.<br></div><div=
><br></div><div><br></div><div>Tcpdump log:</div><div><br></div><div>awesom=
e@ferby:~/workspace/new-ns$ sudo ip netns exec client ./client<br></div><di=
v>17:23:50.587922 IP 10.0.0.1.35282 &gt; 10.0.0.2.7003: Flags [S], seq 3910=
070489, win 64240, options [mss 1460,sackOK,TS val 2969564598 ecr 0,nop,wsc=
ale 7,tfo&nbsp; cookiereq,nop,nop,mptcp capable[bad opt]&gt;<br></div><div>=
17:23:50.587955 IP 10.0.0.2.7003 &gt; 10.0.0.1.35282: Flags [S.], seq 38066=
37430, ack 3910070490, win 65160, options [mss 1460,sackOK,TS val 228415458=
5 ecr 2969564598,nop,wscale 7,tfo&nbsp; cookie 5e09b5dd,nop,nop,mptcp capab=
le Unknown Version (1)], length 0<br></div><div>17:23:50.587997 IP 10.0.0.1=
.35282 &gt; 10.0.0.2.7003: Flags [.], ack 1, win 502, options [nop,nop,TS v=
al 2969564598 ecr 2284154585,mptcp capable Unknown Version (1)], length 0<b=
r></div><div>17:23:50.589091 IP 10.0.0.1.35282 &gt; 10.0.0.2.7003: Flags [P=
.], seq 1:4, ack 1, win 502, options [nop,nop,TS val 2969564599 ecr 2284154=
585,mptcp capable[bad opt]&gt;<br></div><div>17:23:50.589149 IP 10.0.0.2.70=
03 &gt; 10.0.0.1.35282: Flags [.], ack 4, win 510, options [nop,nop,TS val =
2284154586 ecr 2969564599,mptcp dss ack 6653452424296905113], length 0<br><=
/div><div>17:23:50.591278 IP 10.0.0.1.35282 &gt; 10.0.0.2.7003: Flags [P.],=
 seq 4:7, ack 1, win 502, options [nop,nop,TS val 2969564601 ecr 2284154586=
,mptcp dss ack 3417001499 seq 6653452424296905113 subseq 4 len 3,nop,nop], =
length 3<br></div><div>17:23:50.591382 IP 10.0.0.2.7003 &gt; 10.0.0.1.35282=
: Flags [.], ack 7, win 510, options [nop,nop,TS val 2284154588 ecr 2969564=
601,mptcp dss ack 6653452424296905116], length 0<br></div><div>17:23:50.591=
433 IP 10.0.0.1.35282 &gt; 10.0.0.2.7003: Flags [P.], seq 7:10, ack 1, win =
502, options [nop,nop,TS val 2969564601 ecr 2284154588,mptcp dss ack 341700=
1499 seq 6653452424296905116 subseq 7 len 3,nop,nop], length 3<br></div><di=
v>17:23:50.591441 IP 10.0.0.2.7003 &gt; 10.0.0.1.35282: Flags [.], ack 10, =
win 510, options [nop,nop,TS val 2284154588 ecr 2969564601,mptcp dss ack 66=
53452424296905119], length 0<br></div><div>17:23:50.591458 IP 10.0.0.1.3528=
2 &gt; 10.0.0.2.7003: Flags [P.], seq 10:13, ack 1, win 502, options [nop,n=
op,TS val 2969564601 ecr 2284154588,mptcp dss ack 3417001499 seq 6653452424=
296905119 subseq 10 len 3,nop,nop], length 3<br></div><div>17:23:50.591465 =
IP 10.0.0.2.7003 &gt; 10.0.0.1.35282: Flags [.], ack 13, win 510, options [=
nop,nop,TS val 2284154588 ecr 2969564601,mptcp dss ack 6653452424296905122]=
, length 0<br></div><div>17:23:50.591479 IP 10.0.0.1.35282 &gt; 10.0.0.2.70=
03: Flags [P.], seq 13:16, ack 1, win 502, options [nop,nop,TS val 29695646=
01 ecr 2284154588,mptcp dss ack 3417001499 seq 6653452424296905122 subseq 1=
3 len 3,nop,nop], length 3<br></div><div>17:23:50.591485 IP 10.0.0.2.7003 &=
gt; 10.0.0.1.35282: Flags [.], ack 16, win 510, options [nop,nop,TS val 228=
4154588 ecr 2969564601,mptcp dss ack 6653452424296905125], length 0<br></di=
v><div><div>17:24:51.757234 IP 10.0.0.2.7003 &gt; 10.0.0.1.35282: Flags [F.=
], seq 1, ack 16, win 510, options [nop,nop,TS val 2284215754 ecr 296956460=
1,mptcp dss fin ack 6653452424296905125 seq 12259594063739309595 subseq 0 l=
en 1,nop,nop], length 0<br></div><div>17:24:51.757252 IP 10.0.0.1.35282 &gt=
; 10.0.0.2.7003: Flags [F.], seq 16, ack 1, win 502, options [nop,nop,TS va=
l 2969625767 ecr 2284154588,mptcp dss fin ack 3417001499 seq 66534524242969=
05125 subseq 0 len 1,nop,nop], length 0<br></div><div>17:24:51.757364 IP 10=
.0.0.2.7003 &gt; 10.0.0.1.35282: Flags [.], ack 17, win 510, options [nop,n=
op,TS val 2284215754 ecr 2969625767,mptcp dss fin ack 6653452424296905125 s=
eq 12259594063739309595 subseq 0 len 1,nop,nop], length 0<br></div><div>17:=
24:51.757367 IP 10.0.0.1.35282 &gt; 10.0.0.2.7003: Flags [.], ack 2, win 50=
2, options [nop,nop,TS val 2969625767 ecr 2284215754,mptcp dss fin ack 3417=
001499 seq 6653452424296905125 subseq 0 len 1,nop,nop], length 0<br></div><=
div><br></div></div><div>awesome@ferby:~/workspace/new-ns$ sudo ip netns ex=
ec client ./client<br></div><div>17:24:00.975725 IP 10.0.0.1.35284 &gt; 10.=
0.0.2.7003: Flags [S], seq 1823106728:1823106731, win 64240, options [mss 1=
460,sackOK,TS val 2969574986 ecr 0,nop,wscale 7,tfo&nbsp; cookie 5e09b5dd,n=
op,nop,mptcp capable[bad opt]&gt;<br></div><div>17:24:00.975783 IP 10.0.0.2=
.7003 &gt; 10.0.0.1.35284: Flags [S.], seq 3107129198, ack 1823106732, win =
65160, options [mss 1460,sackOK,TS val 2284164973 ecr 2969574986,nop,wscale=
 7,mptcp capable Unknown Version (1)], length 0<br></div><div>17:24:00.9758=
96 IP 10.0.0.1.35284 &gt; 10.0.0.2.7003: Flags [.], ack 1, win 502, options=
 [nop,nop,TS val 2969574986 ecr 2284164973,mptcp capable Unknown Version (1=
)], length 0<br></div><div>17:24:00.976880 IP 10.0.0.1.35284 &gt; 10.0.0.2.=
7003: Flags [P.], seq 1:4, ack 1, win 502, options [nop,nop,TS val 29695749=
87 ecr 2284164973,mptcp capable[bad opt]&gt;<br></div><div>17:24:00.977097 =
IP 10.0.0.2.7003 &gt; 10.0.0.1.35284: Flags [.], ack 4, win 510, options [n=
op,nop,TS val 2284164974 ecr 2969574987,mptcp dss ack 17277082426285855013]=
, length 0<br></div><div>17:24:00.977148 IP 10.0.0.1.35284 &gt; 10.0.0.2.70=
03: Flags [P.], seq 4:7, ack 1, win 502, options [nop,nop,TS val 2969574987=
 ecr 2284164974,mptcp dss ack 3342174256 seq 777308174741155629 subseq 4 le=
n 3,nop,nop], length 3<br></div><div>17:24:00.977163 IP 10.0.0.2.7003 &gt; =
10.0.0.1.35284: Flags [.], ack 7, win 510, options [nop,nop,TS val 22841649=
74 ecr 2969574987,mptcp dss ack 17277082426285855016], length 0<br></div><d=
iv>17:24:00.977184 IP 10.0.0.1.35284 &gt; 10.0.0.2.7003: Flags [P.], seq 7:=
10, ack 1, win 502, options [nop,nop,TS val 2969574987 ecr 2284164974,mptcp=
 dss ack 3342174256 seq 777308174741155632 subseq 7 len 3,nop,nop], length =
3<br></div><div>17:24:00.977192 IP 10.0.0.2.7003 &gt; 10.0.0.1.35284: Flags=
 [.], ack 10, win 510, options [nop,nop,TS val 2284164974 ecr 2969574987,mp=
tcp dss ack 17277082426285855019], length 0<br></div><div>17:24:00.977230 I=
P 10.0.0.1.35284 &gt; 10.0.0.2.7003: Flags [P.], seq 10:13, ack 1, win 502,=
 options [nop,nop,TS val 2969574987 ecr 2284164974,mptcp dss ack 3342174256=
 seq 777308174741155635 subseq 10 len 3,nop,nop], length 3<br></div><div>17=
:24:00.977243 IP 10.0.0.2.7003 &gt; 10.0.0.1.35284: Flags [.], ack 13, win =
510, options [nop,nop,TS val 2284164974 ecr 2969574987,mptcp dss ack 172770=
82426285855022], length 0<br></div><div>17:25:01.997117 IP 10.0.0.2.7003 &g=
t; 10.0.0.1.35284: Flags [F.], seq 1, ack 13, win 510, options [nop,nop,TS =
val 2284225994 ecr 2969574987,mptcp dss fin ack 17277082426285855022 seq 14=
17219265470498864 subseq 0 len 1,nop,nop], length 0<br></div><div>17:25:01.=
997180 IP 10.0.0.1.35284 &gt; 10.0.0.2.7003: Flags [F.], seq 13, ack 1, win=
 502, options [nop,nop,TS val 2969636007 ecr 2284164974,mptcp dss fin ack 3=
342174256 seq 777308174741155638 subseq 0 len 1,nop,nop], length 0<br></div=
><div>17:25:01.997232 IP 10.0.0.2.7003 &gt; 10.0.0.1.35284: Flags [.], ack =
14, win 510, options [nop,nop,TS val 2284225994 ecr 2969636007,mptcp dss fi=
n ack 17277082426285855022 seq 1417219265470498864 subseq 0 len 1,nop,nop],=
 length 0<br></div><div>17:25:01.997233 IP 10.0.0.1.35284 &gt; 10.0.0.2.700=
3: Flags [.], ack 2, win 502, options [nop,nop,TS val 2969636007 ecr 228422=
5994,mptcp dss fin ack 3342174256 seq 777308174741155638 subseq 0 len 1,nop=
,nop], length 0<br></div><div><br></div><div>Userspace data exchange:<br></=
div><div><br></div><div><br></div><div>awesome@ferby:~/workspace/new-ns$ su=
do ip netns exec client ./client<br></div><div>received abc from client<br>=
</div><div>received zzz from client<br></div><div>received zzz from client<=
br></div><div>received zzz from client<br></div><div>received fff from clie=
nt<br></div><div><br></div><div>awesome@ferby:~/workspace/new-ns$ sudo ip n=
etns exec client ./client<br></div><div>received abc from client<br></div><=
div>received zzz from client<br></div><div>received zzz from client<br></di=
v><div>received zzz from client<br></div><div>received fff from client<br><=
/div><div><br></div><div><br></div><div>Best regards,<br>Dmytro SHYTYI.<br>=
</div><div><br></div><div>&gt; Hello all,<br></div><div>&gt;&nbsp;<br></div=
><div>&gt; I'm writing this message to post an update regarding the work on=
 fastopen mechanism.<br></div><div>&gt; Evolution of fastopen PATCH is far =
away from submission yet (packet retransmissions are present), but there ar=
e good signs.<br></div><div>&gt; Notably I attach the pcap wireshark that i=
ncludes client + server in 2 different namespaces:<br></div><div>&gt;&nbsp;=
 &gt; &gt; 1. MPTCP cookie request from client.<br></div><div>&gt;&nbsp; &g=
t; &gt; 2. MPTCP cookie offering from server.<br></div><div>&gt;&nbsp; &gt;=
 &gt; 3. MPTCP SYN+DATA+COOKIE from client.<br></div><div>&gt;&nbsp; &gt; &=
gt; 4. subsequent write + read on the opened socket.<br></div><div>&gt; Fin=
ally the userspace application receives the data send in the SYN+DATA+COOKI=
E. You may find the examples in the prinf+tcpdump log on the bottom of the =
message as a bonus...<br></div><div>&gt;&nbsp;<br></div><div>&gt; I'm looki=
ng what I have to adjust to fix packet retransmissions. If you have in mind=
 some ideas/suggestions, you are welcome to provide some comments (in maili=
ng list or maybe in private),<br></div><div>&gt;&nbsp;<br></div><div>&gt; a=
wesome@ferby:~/workspace/new-ns$ sudo ip netns exec client ./client<br></di=
v><div>&gt; info: 0<br></div><div>&gt; ACCEPT_SUCCESS: Success<br></div><di=
v>&gt; SERVER_READ_SUCCESS: Success<br></div><div>&gt; received z from clie=
nt<br></div><div>&gt; SERVER_READ_SUCCESS: Success<br></div><div>&gt; recei=
ved z from client<br></div><div>&gt; SERVER_READ_SUCCESS: Success<br></div>=
<div>&gt; received z from client<br></div><div>&gt; SERVER_READ_SUCCESS: Su=
ccess<br></div><div>&gt; received a from client<br></div><div>&gt; SERVER_R=
EAD_SUCCESS: Success<br></div><div>&gt; received f from client<br></div><di=
v>&gt;&nbsp;<br></div><div>&gt; 22:49:21.410344 IP 10.0.0.1.37980 &gt; 10.0=
.0.2.7003: Flags [S], seq 3325457504, win 64240, options [mss 1460,sackOK,T=
S val 1084403317 ecr 0,nop,wscale 7,tfo cookiereq,nop,nop,mptcp capable[bad=
 opt]&gt;<br></div><div>&gt; 22:49:21.410367 IP 10.0.0.2.7003 &gt; 10.0.0.1=
.37980: Flags [S.], seq 1929681786, ack 3325457505, win 65160, options [mss=
 1460,sackOK,TS val 1487352723 ecr 1084403317,nop,wscale 7,tfo cookie d0f85=
d19,nop,nop,mptcp capable Unknown Version (1)], length 0<br></div><div>&gt;=
 22:49:21.412560 IP 10.0.0.1.37980 &gt; 10.0.0.2.7003: Flags [P.], seq 1:2,=
 ack 1, win 502, options [nop,nop,TS val 1084403319 ecr 1487352723,mptcp ca=
pable[bad opt]&gt;<br></div><div>&gt; 22:49:21.412621 IP 10.0.0.2.7003 &gt;=
 10.0.0.1.37980: Flags [.], ack 2, win 510, options [nop,nop,TS val 1487352=
725 ecr 1084403319,mptcp dss ack 12880089298653898158], length 0<br></div><=
div>&gt; 22:49:21.413113 IP 10.0.0.1.37980 &gt; 10.0.0.2.7003: Flags [.], a=
ck 1, win 502, options [nop,nop,TS val 1084403319 ecr 1487352725,mptcp dss =
ack 3168804441], length 0<br></div><div>&gt; 22:49:21.413134 IP 10.0.0.1.37=
980 &gt; 10.0.0.2.7003: Flags [P.], seq 2:3, ack 1, win 502, options [nop,n=
op,TS val 1084403320 ecr 1487352725,mptcp dss ack 3168804441 seq 1288008929=
8653898158 subseq 2 len 1,nop,nop], length 1<br></div><div>&gt; 22:49:21.41=
3139 IP 10.0.0.2.7003 &gt; 10.0.0.1.37980: Flags [.], ack 3, win 510, optio=
ns [nop,nop,TS val 1487352726 ecr 1084403320,mptcp dss ack 1288008929865389=
8159], length 0<br></div><div>&gt; 22:49:21.413394 IP 10.0.0.1.37980 &gt; 1=
0.0.0.2.7003: Flags [.], ack 1, win 502, options [nop,nop,TS val 1084403320=
 ecr 1487352726,mptcp dss ack 3168804441], length 0<br></div><div>&gt; 22:4=
9:21.413408 IP 10.0.0.1.37980 &gt; 10.0.0.2.7003: Flags [P.], seq 3:4, ack =
1, win 502, options [nop,nop,TS val 1084403320 ecr 1487352726,mptcp dss ack=
 3168804441 seq 12880089298653898159 subseq 3 len 1,nop,nop], length 1<br><=
/div><div>&gt; 22:49:21.413411 IP 10.0.0.2.7003 &gt; 10.0.0.1.37980: Flags =
[.], ack 4, win 510, options [nop,nop,TS val 1487352726 ecr 1084403320,mptc=
p dss ack 12880089298653898160], length 0<br></div><div>&gt; 22:49:21.41367=
4 IP 10.0.0.1.37980 &gt; 10.0.0.2.7003: Flags [.], ack 1, win 502, options =
[nop,nop,TS val 1084403320 ecr 1487352726,mptcp dss ack 3168804441], length=
 0<br></div><div>&gt; 22:49:21.413699 IP 10.0.0.1.37980 &gt; 10.0.0.2.7003:=
 Flags [P.], seq 4:5, ack 1, win 502, options [nop,nop,TS val 1084403320 ec=
r 1487352726,mptcp dss ack 3168804441 seq 12880089298653898160 subseq 4 len=
 1,nop,nop], length 1<br></div><div>&gt; 22:49:21.413944 IP 10.0.0.1.37980 =
&gt; 10.0.0.2.7003: Flags [.], ack 1, win 502, options [nop,nop,TS val 1084=
403320 ecr 1487352726,mptcp dss ack 3168804441], length 0<br></div><div>&gt=
; 22:49:21.414206 IP 10.0.0.2.7003 &gt; 10.0.0.1.37980: Flags [.], ack 6, w=
in 510, options [nop,nop,TS val 1487352727 ecr 1084403321,mptcp dss fin ack=
 12880089298653898162 seq 11302478206648458841 subseq 0 len 1,nop,nop], len=
gth 0<br></div><div>&gt;&nbsp;<br></div><div>&gt;&nbsp;<br></div><div>&gt; =
awesome@ferby:~/workspace/new-ns$ sudo ip netns exec client ./client<br></d=
iv><div>&gt; ACCEPT_SUCCESS: Success<br></div><div>&gt; SERVER_READ_SUCCESS=
: Success<br></div><div>&gt; received a from client &lt;&lt;&lt;&lt;&lt;&lt=
;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt; THIS "A" CHARACTER IS A PART OF THE S=
YN+DATA+COOKIE.<br></div><div>&gt; info: 0<br></div><div>&gt; SERVER_READ_S=
UCCESS: Success<br></div><div>&gt; received z from client<br></div><div>&gt=
; SERVER_READ_SUCCESS: Success<br></div><div>&gt; received z from client<br=
></div><div>&gt; SERVER_READ_SUCCESS: Success<br></div><div>&gt; received z=
 from client<br></div><div>&gt; SERVER_READ_SUCCESS: Success<br></div><div>=
&gt; received a from client<br></div><div>&gt; SERVER_READ_SUCCESS: Success=
<br></div><div>&gt; received f from client<br></div><div>&gt; 22:52:11.2626=
22 IP 10.0.0.1.37982 &gt; 10.0.0.2.7003: Flags [S], seq 549537183:549537184=
, win 64240, options [mss 1460,sackOK,TS val 1084573169 ecr 0,nop,wscale 7,=
tfo cookie d0f85d19,nop,nop,mptcp capable[bad opt]&gt;<br></div><div>&gt; 2=
2:52:11.262767 IP 10.0.0.2.7003 &gt; 10.0.0.1.37982: Flags [S.], seq 409250=
4081, ack 549537185, win 65160, options [mss 1460,sackOK,TS val 1487522575 =
ecr 1084573169,nop,wscale 7,mptcp capable Unknown Version (1)], length 0<br=
></div><div>&gt; 22:52:11.262810 IP 10.0.0.1.37982 &gt; 10.0.0.2.7003: Flag=
s [.], ack 1, win 502, options [nop,nop,TS val 1084573169 ecr 1487522575,mp=
tcp capable Unknown Version (1)], length 0<br></div><div>&gt; 22:52:11.2663=
77 IP 10.0.0.1.37982 &gt; 10.0.0.2.7003: Flags [P.], seq 1:2, ack 1, win 50=
2, options [nop,nop,TS val 1084573173 ecr 1487522575,mptcp capable[bad opt]=
&gt;<br></div><div>&gt; 22:52:11.266451 IP 10.0.0.2.7003 &gt; 10.0.0.1.3798=
2: Flags [.], ack 2, win 510, options [nop,nop,TS val 1487522579 ecr 108457=
3173,mptcp dss ack 12881747887342348535], length 0<br></div><div>&gt; 22:52=
:11.266904 IP 10.0.0.1.37982 &gt; 10.0.0.2.7003: Flags [.], ack 1, win 502,=
 options [nop,nop,TS val 1084573173 ecr 1487522579,mptcp dss ack 3798297942=
], length 0<br></div><div>&gt; 22:52:11.267039 IP 10.0.0.1.37982 &gt; 10.0.=
0.2.7003: Flags [P.], seq 2:3, ack 1, win 502, options [nop,nop,TS val 1084=
573174 ecr 1487522579,mptcp dss ack 3798297942 seq 746326162666601844 subse=
q 2 len 1,nop,nop], length 1<br></div><div>&gt; 22:52:11.267050 IP 10.0.0.2=
.7003 &gt; 10.0.0.1.37982: Flags [.], ack 3, win 510, options [nop,nop,TS v=
al 1487522580 ecr 1084573174,mptcp dss ack 12881747887342348536], length 0<=
br></div><div>&gt; 22:52:11.267427 IP 10.0.0.1.37982 &gt; 10.0.0.2.7003: Fl=
ags [.], ack 1, win 502, options [nop,nop,TS val 1084573174 ecr 1487522580,=
mptcp dss ack 3798297942], length 0<br></div><div>&gt; 22:52:11.267454 IP 1=
0.0.0.1.37982 &gt; 10.0.0.2.7003: Flags [P.], seq 3:4, ack 1, win 502, opti=
ons [nop,nop,TS val 1084573174 ecr 1487522580,mptcp dss ack 3798297942 seq =
746326162666601845 subseq 3 len 1,nop,nop], length 1<br></div><div>&gt; 22:=
52:11.267461 IP 10.0.0.2.7003 &gt; 10.0.0.1.37982: Flags [.], ack 4, win 51=
0, options [nop,nop,TS val 1487522580 ecr 1084573174,mptcp dss ack 12881747=
887342348537], length 0<br></div><div>&gt; 22:52:11.267957 IP 10.0.0.1.3798=
2 &gt; 10.0.0.2.7003: Flags [.], ack 1, win 502, options [nop,nop,TS val 10=
84573174 ecr 1487522580,mptcp dss ack 3798297942], length 0<br></div><div>&=
gt; 22:52:11.267988 IP 10.0.0.1.37982 &gt; 10.0.0.2.7003: Flags [P.], seq 4=
:5, ack 1, win 502, options [nop,nop,TS val 1084573175 ecr 1487522580,mptcp=
 dss ack 3798297942 seq 746326162666601846 subseq 4 len 1,nop,nop], length =
1<br></div><div>&gt; 22:52:11.267995 IP 10.0.0.2.7003 &gt; 10.0.0.1.37982: =
Flags [.], ack 5, win 510, options [nop,nop,TS val 1487522581 ecr 108457317=
5,mptcp dss ack 12881747887342348538], length 0<br></div><div>&gt; 22:52:11=
.268546 IP 10.0.0.1.37982 &gt; 10.0.0.2.7003: Flags [.], ack 1, win 502, op=
tions [nop,nop,TS val 1084573175 ecr 1487522581,mptcp dss ack 3798297942], =
length 0<br></div><div>&gt; 22:52:11.268594 IP 10.0.0.1.37982 &gt; 10.0.0.2=
.7003: Flags [P.], seq 5:6, ack 1, win 502, options [nop,nop,TS val 1084573=
175 ecr 1487522581,mptcp dss ack 3798297942 seq 746326162666601847 subseq 5=
 len 1,nop,nop], length 1<br></div><div>&gt; 22:52:11.268603 IP 10.0.0.2.70=
03 &gt; 10.0.0.1.37982: Flags [.], ack 6, win 510, options [nop,nop,TS val =
1487522581 ecr 1084573175,mptcp dss ack 12881747887342348539], length 0<br>=
</div><div>&gt; 22:52:11.269735 IP 10.0.0.2.7003 &gt; 10.0.0.1.37982: Flags=
 [.], ack 6, win 510, options [nop,nop,TS val 1487522581 ecr 1084573175,mpt=
cp dss fin ack 12881747887342348539 seq 9620565311902543190 subseq 0 len 1,=
nop,nop], length 0<br></div><div>&gt; 22:52:11.269846 IP 10.0.0.1.37982 &gt=
; 10.0.0.2.7003: Flags [.], ack 1, win 502, options [nop,nop,TS val 1084573=
176 ecr 1487522581,mptcp dss ack 3798297942], length 0<br></div><div>&gt; 2=
2:52:11.469004 IP 10.0.0.1.37982 &gt; 10.0.0.2.7003: Flags [.], ack 1, win =
502, options [nop,nop,TS val 1084573177 ecr 1487522583,mptcp dss fin ack 37=
98297943 seq 746326162666601848 subseq 0 len 1,nop,nop], length 0<br></div>=
<div>&gt; 22:52:11.472189 IP 10.0.0.2.7003 &gt; 10.0.0.1.37982: Flags [.], =
ack 6, win 510, options [nop,nop,TS val 1487522782 ecr 1084573177,mptcp dss=
 ack 12881747887342348539], length 0<br></div><div>&gt; 22:53:11.672337 IP =
10.0.0.1.37982 &gt; 10.0.0.2.7003: Flags [.], ack 1, win 502, options [nop,=
nop,TS val 1084573379 ecr 1487522782,mptcp dss fin ack 3798297943 seq 74632=
6162666601848 subseq 0 len 1,nop,nop], length 0<br></div><div>&gt; 22:53:11=
.672425 IP 10.0.0.1.37982 &gt; 10.0.0.2.7003: Flags [F.], seq 6, ack 1, win=
 502, options [nop,nop,TS val 1084633579 ecr 1487522782,mptcp dss fin ack 3=
798297943 seq 746326162666601848 subseq 0 len 1,nop,nop], length 0<br></div=
><div>&gt; 22:53:11.672461 IP 10.0.0.2.7003 &gt; 10.0.0.1.37982: Flags [.],=
 ack 7, win 510, options [nop,nop,TS val 1487582985 ecr 1084633579,mptcp ds=
s ack 12881747887342348539], length 0<br></div><div>&gt; 22:53:11.672515 IP=
 10.0.0.2.7003 &gt; 10.0.0.1.37982: Flags [F.], seq 1, ack 7, win 510, opti=
ons [nop,nop,TS val 1487582985 ecr 1084633579,mptcp dss ack 128817478873423=
48539], length 0<br></div><div>&gt; 22:53:11.672545 IP 10.0.0.1.37982 &gt; =
10.0.0.2.7003: Flags [.], ack 2, win 502, options [nop,nop,TS val 108463357=
9 ecr 1487582985], length 0<br></div><div>&gt;&nbsp;<br></div><div>&gt; Tha=
nks,<br></div><div>&gt; Dmytro.<br></div><div>&gt; &gt;<br></div><div>&gt; =
&gt; Hi Dmytro,<br></div><div>&gt; &gt;<br></div><div>&gt; &gt; On 25/10/20=
21 13:34, Dmytro Shytyi wrote:<br></div><div>&gt; &gt; &gt;<br></div><div>&=
gt; &gt; &gt; ---- On Fri, 22 Oct 2021 11:22:31 +0200 Matthieu Baerts &lt;<=
a target=3D"_blank" href=3D"mailto:matthieu.baerts@tessares.net">matthieu.b=
aerts@tessares.net</a>&gt; wrote ----<br></div><div>&gt; &gt; &gt;<br></div=
><div>&gt; &gt; &gt; &gt; Hi Dmytro,<br></div><div>&gt; &gt; &gt; &gt;<br><=
/div><div>&gt; &gt;<br></div><div>&gt; &gt; Small detail: it looks like you=
r email client is adding unusual spaces<br></div><div>&gt; &gt; before "&gt=
;" to quote the previous message. That's not a big issue but it<br></div><d=
iv>&gt; &gt; makes other email clients and even lore [1] not interpreting t=
hat as<br></div><div>&gt; &gt; quotes, e.g. on lore, you can see the quotes=
 are in blue in my reply and<br></div><div>&gt; &gt; Mat's one but not in y=
ours.<br></div><div>&gt; &gt;<br></div><div>&gt; &gt; [1]<br></div><div>&gt=
; &gt; <a target=3D"_blank" href=3D"https://lore.kernel.org/mptcp/17cb73b13=
43.c752fede1729351.6463099199494289591@shytyi.net/T/#t">https://lore.kernel=
.org/mptcp/17cb73b1343.c752fede1729351.6463099199494289591@shytyi.net/T/#t<=
/a><br></div><div>&gt; &gt;<br></div><div>&gt; &gt; (...)<br></div><div>&gt=
; &gt;<br></div><div>&gt; &gt; &gt; &gt; I hope this might help reviewing t=
he new versions ;-)<br></div><div>&gt; &gt; &gt;<br></div><div>&gt; &gt; &g=
t; Thank you, Metthieu.<br></div><div>&gt; &gt; &gt; I'm working on PATCH n=
et-next v2 net: mptcp. It will include all your comments, except this one:<=
br></div><div>&gt; &gt; &gt;<br></div><div>&gt; &gt; &gt; &gt; It looks lik=
e you don't use it. Does the compiler not complain about that?<br></div><di=
v>&gt; &gt; &gt; &gt;<br></div><div>&gt; &gt; &gt; &gt; &gt; + tp-&gt;fasto=
pen_req =3D kzalloc(sizeof(*tp-&gt;fatopen_req),<br></div><div>&gt; &gt; &g=
t; &gt; &gt; + ssk-&gt;sk-&gt;sk_allocation);<br></div><div>&gt; &gt; &gt; =
Compiler not compalin about that because it is used in the code.<br></div><=
div>&gt; &gt;<br></div><div>&gt; &gt; In the version you sent, in mptcp_sen=
dmsg_fastopen_cookie_send() you are<br></div><div>&gt; &gt; indeed using it=
 but not it in mptcp_sendmsg_fastopen_cookie_req(), no?<br></div><div>&gt; =
&gt;<br></div><div>&gt; &gt; Cheers,<br></div><div>&gt; &gt; Matt<br></div>=
<div>&gt; &gt; --<br></div><div>&gt; &gt; Tessares | Belgium | Hybrid Acces=
s Solutions<br></div><div>&gt; &gt;<a target=3D"_blank" href=3D"http://www.=
tessares.net">www.tessares.net</a><br></div></div><div><br></div></div><div=
><br></div></div><br></body></html>
------=_Part_711689_1542745249.1641664690086--

------=_Part_711688_1572048598.1641664690086
Content-Type: application/octet-stream; name=fastopen.pcap
Content-Transfer-Encoding: base64
X-ZM_AttachId: 138609574900880070
Content-Disposition: attachment; filename=fastopen.pcap

1MOyoQIABAAAAAAAAAAAAAAABABxAAAA9cnZYbXSBQBIAAAASAAAAAAEAAEABl5EICTqWQAAht1g
AAAAABA6//6AAAAAAAAAXEQg//4k6ln/AgAAAAAAAAAAAAAAAAAChQCtqQAAAAABAV5EICTqWfXJ
2WH7EwkASAAAAEgAAAAAAgABAAZaMhsDe/0AAIbdYAAAAAAQOv/+gAAAAAAAAFgyG//+A3v9/wIA
AAAAAAAAAAAAAAAAAoUAnMgAAAAAAQFaMhsDe/39ydlh2vAAAEgAAABIAAAAAAQAAQAGXkQgJOpZ
AACG3WAAAAAAEDr//oAAAAAAAABcRCD//iTqWf8CAAAAAAAAAAAAAAAAAAKFAK2pAAAAAAEBXkQg
JOpZ/snZYfb0AQBIAAAASAAAAAACAAEABloyGwN7/QAAht1gAAAAABA6//6AAAAAAAAAWDIb//4D
e/3/AgAAAAAAAAAAAAAAAAAChQCcyAAAAAABAVoyGwN7/QDK2WH+HQcALAAAACwAAAAAAQABAAZa
MhsDe/0AAAgGAAEIAAYEAAFaMhsDe/0KAAABAAAAAAAACgAAAgDK2WEYHgcALAAAACwAAAAABAAB
AAZeRCAk6lkAAAgGAAEIAAYEAAJeRCAk6lkKAAACWjIbA3v9CgAAAQDK2WEgHgcAVAAAAFQAAAAA
AAABAAZaMhsDe/0AAAgARQAARH3rQABABqjGCgAAAQoAAALaChtb58Y2PQAAAADAAvrwFDkAAAIE
BbQEAggKFhfPmQAAAAABAwMHIgIBAR4EAQEAytlhRh4HAGAAAABgAAAAAAQAAQAGXkQgJOpZAAAI
AEUAAFAAAEAAQAYmpgoAAAIKAAABG1vaCq3xqybnxjY+8BL+iBRFAAACBAW0BAIICheGFsQWF8+Z
AQMDByIGqwERsQEBHgwBATfZE3yRphHpAMrZYYIeBwBYAAAAWAAAAAAAAAEABloyGwN7/QAACABF
AABIfexAAEAGqMEKAAABCgAAAtoKG1vnxjY+rfGrJ9AQAfYUPQAAAQEIChYXz5kXhhbEHhQBAb6w
OAPIkSFQN9kTfJGmEekAytlhYR8HAF8AAABfAAAAAAAAAQAGWjIbA3v9AAAIAEUAAE997UAAQAao
uQoAAAEKAAAC2gobW+fGNj6t8asn4BgB9hREAAABAQgKFhfPmReGFsQeFgEBvrA4A8iRIVA32RN8
kaYR6QADAQFhYmMAytlhdx8HAFAAAABQAAAAAAQAAQAGXkQgJOpZAAAIAEUAAEDOvkAAQAZX9woA
AAIKAAABG1vaCq3xqyfnxjZBsBAB/hQ1AAABAQgKF4YWxBYXz5keDCADK5c4+YO1TtYAytlhBSAH
AF8AAABfAAAAAAAAAQAGWjIbA3v9AAAIAEUAAE997kAAQAaouAoAAAEKAAAC2gobW+fGNkGt8asn
4BgB9hREAAABAQgKFhfPmheGFsQeFiANg2L1iCuXOPmDtU7WAAAABAADAQF6enoAytlhFSAHAFAA
AABQAAAAAAQAAQAGXkQgJOpZAAAIAEUAAEDOv0AAQAZX9goAAAIKAAABG1vaCq3xqyfnxjZEsBAB
/hQ1AAABAQgKF4YWxRYXz5oeDCADK5c4+YO1TtkAytlhPiAHAF8AAABfAAAAAAAAAQAGWjIbA3v9
AAAIAEUAAE9970AAQAaotwoAAAEKAAAC2gobW+fGNkSt8asn4BgB9hREAAABAQgKFhfPmheGFsUe
FiANg2L1iCuXOPmDtU7ZAAAABwADAQF6enoAytlhgCAHAFAAAABQAAAAAAQAAQAGXkQgJOpZAAAI
AEUAAEDOwEAAQAZX9QoAAAIKAAABG1vaCq3xqyfnxjZHsBAB/hQ1AAABAQgKF4YWxRYXz5oeDCAD
K5c4+YO1TtwAytlhyiAHAF8AAABfAAAAAAAAAQAGWjIbA3v9AAAIAEUAAE998EAAQAaotgoAAAEK
AAAC2gobW+fGNket8asn4BgB9hREAAABAQgKFhfPmheGFsUeFiANg2L1iCuXOPmDtU7cAAAACgAD
AQF6enoAytlh1yAHAFAAAABQAAAAAAQAAQAGXkQgJOpZAAAIAEUAAEDOwUAAQAZX9AoAAAIKAAAB
G1vaCq3xqyfnxjZKsBAB/hQ1AAABAQgKF4YWxRYXz5oeDCADK5c4+YO1Tt8Aytlh9iAHAF8AAABf
AAAAAAAAAQAGWjIbA3v9AAAIAEUAAE998UAAQAaotQoAAAEKAAAC2gobW+fGNkqt8asn4BgB9hRE
AAABAQgKFhfPmheGFsUeFiANg2L1iCuXOPmDtU7fAAAADQADAQFmZmYAytlhASEHAFAAAABQAAAA
AAQAAQAGXkQgJOpZAAAIAEUAAEDOwkAAQAZX8woAAAIKAAABG1vaCq3xqyfnxjZNsBAB/hQ1AAAB
AQgKF4YWxRYXz5oeDCADK5c4+YO1TuIFytlhBxQJACwAAAAsAAAAAAQAAQAGXkQgJOpZAAAIBgAB
CAAGBAABXkQgJOpZCgAAAgAAAAAAAAoAAAEFytlhbhQJACwAAAAsAAAAAAAAAQAGWjIbA3v9AAAI
BgABCAAGBAACWjIbA3v9CgAAAV5EICTqWQoAAAIMytlhyvEMAEgAAABIAAAAAAQAAQAGXkQgJOpZ
AACG3WAAAAAAEDr//oAAAAAAAABcRCD//iTqWf8CAAAAAAAAAAAAAAAAAAKFAK2pAAAAAAEBXkQg
JOpZDsrZYeZ3CABIAAAASAAAAAACAAEABloyGwN7/QAAht1gAAAAABA6//6AAAAAAAAAWDIb//4D
e/3/AgAAAAAAAAAAAAAAAAAChQCcyAAAAAABAVoyGwN7/SnK2WHAJQ0ASAAAAEgAAAAABAABAAZe
RCAk6lkAAIbdYAAAAAAQOv/+gAAAAAAAAFxEIP/+JOpZ/wIAAAAAAAAAAAAAAAAAAoUArakAAAAA
AQFeRCAk6lkwytlheIEKAEgAAABIAAAAAAIAAQAGWjIbA3v9AACG3WAAAAAAEDr//oAAAAAAAABY
Mhv//gN7/f8CAAAAAAAAAAAAAAAAAAKFAJzIAAAAAAEBWjIbA3v9PMrZYa+wCQBgAAAAYAAAAAAE
AAEABl5EICTqWQAACABFAABQzsNAAEAGV+IKAAACCgAAARtb2gqt8asn58Y2TfARAf4URQAAAQEI
CheHAc0WF8+aHhogHyuXOPmDtU7iRLgxCYNi9YgAAAAAAAEBATzK2WGysAkAXAAAAFwAAAAAAAAB
AAZaMhsDe/0AAAgARQAATH3yQABABqi3CgAAAQoAAALaChtb58Y2Ta3xqyfgEQH2FEEAAAEBCAoW
GLqiF4YWxR4WIB2DYvWIK5c4+YO1TuIAAAAAAAEBATzK2WFCsQkAXAAAAFwAAAAAAAABAAZaMhsD
e/0AAAgARQAATH3zQABABqi2CgAAAQoAAALaChtb58Y2Tq3xqyjgEAH2FEEAAAEBCAoWGLqiF4cB
zR4WIB2DYvWIK5c4+YO1TuIAAAAAAAEBATzK2WFksQkAYAAAAGAAAAAABAABAAZeRCAk6lkAAAgA
RQAAUM7EQABABlfhCgAAAgoAAAEbW9oKrfGrKOfGNk7wEAH+FEUAAAEBCAoXhwHNFhi6oh4aIB8r
lzj5g7VO4kS4MQmDYvWIAAAAAAABAQFBytlhDYULACwAAAAsAAAAAAAAAQAGWjIbA3v9AAAIBgAB
CAAGBAABWjIbA3v9CgAAAQAAAAAAAAoAAAJBytlhLYULACwAAAAsAAAAAAQAAQAGXkQgJOpZAAAI
BgABCAAGBAACXkQgJOpZCgAAAloyGwN7/QoAAAFBytlh3YYLACwAAAAsAAAAAAQAAQAGXkQgJOpZ
AAAIBgABCAAGBAABXkQgJOpZCgAAAgAAAAAAAAoAAAFBytlhL4cLACwAAAAsAAAAAAAAAQAGWjIb
A3v9AAAIBgABCAAGBAACWjIbA3v9CgAAAV5EICTqWQoAAAJiytlhjMUCAEgAAABIAAAAAAQAAQAG
XkQgJOpZAACG3WAAAAAAEDr//oAAAAAAAABcRCD//iTqWf8CAAAAAAAAAAAAAAAAAAKFAK2pAAAA
AAEBXkQgJOpZdsrZYXYYCgBIAAAASAAAAAACAAEABloyGwN7/QAAht1gAAAAABA6//6AAAAAAAAA
WDIb//4De/3/AgAAAAAAAAAAAAAAAAAChQCcyAAAAAABAVoyGwN7/dnK2WGx5AkASAAAAEgAAAAA
BAABAAZeRCAk6lkAAIbdYAAAAAAQOv/+gAAAAAAAAFxEIP/+JOpZ/wIAAAAAAAAAAAAAAAAAAoUA
rakAAAAAAQFeRCAk6lnkytlhsiwLAFsAAABbAAAAAAAAAQAGWjIbA3v9AAAIAEUAAEuZMUAAQAaN
eQoAAAEKAAAC2gwbW2aCX7YAAAAA0AL68BRAAAACBAW0BAIIChYbS0MAAAAAAQMDByIGqwERsQEB
HgQBAWFiY+TK2WEKLQsAWAAAAFgAAAAABAABAAZeRCAk6lkAAAgARQAASAAAQABABiauCgAAAgoA
AAEbW9oMyPFB5WaCX7rQEv6IFD0AAAIEBbQEAggKF4mSbhYbS0MBAwMHHgwBAfWWfF8Tq8MB5MrZ
YUotCwBYAAAAWAAAAAAAAAEABloyGwN7/QAACABFAABImTJAAEAGjXsKAAABCgAAAtoMG1tmgl+6
yPFB5tAQAfYUPQAAAQEIChYbS0MXiZJuHhQBAZZRIf4j/SP89ZZ8XxOrwwHkytlh7S0LAF8AAABf
AAAAAAAAAQAGWjIbA3v9AAAIAEUAAE+ZM0AAQAaNcwoAAAEKAAAC2gwbW2aCX7rI8UHm4BgB9hRE
AAABAQgKFhtLQxeJkm4eFgEBllEh/iP9I/z1lnxfE6vDAQADAQF6enrkytlhHy4LAFAAAABQAAAA
AAQAAQAGXkQgJOpZAAAIAEUAAEAMbUAAQAYaSQoAAAIKAAABG1vaDMjxQeZmgl+9sBAB/hQ1AAAB
AQgKF4mSbhYbS0MeDCAD9QwRzagpjLrkytlhLC4LAF8AAABfAAAAAAAAAQAGWjIbA3v9AAAIAEUA
AE+ZNEAAQAaNcgoAAAEKAAAC2gwbW2aCX73I8UHm4BgB9hREAAABAQgKFhtLQxeJkm4eFiANYViN
Ve+xDjRSKTFZAAAABAADAQF6enrkytlhMC4LAFAAAABQAAAAAAQAAQAGXkQgJOpZAAAIAEUAAEAM
bkAAQAYaSAoAAAIKAAABG1vaDMjxQeZmgl/AsBAB/hQ1AAABAQgKF4mSbhYbS0MeDCAD9QwRzagp
jL3kytlhNi4LAF8AAABfAAAAAAAAAQAGWjIbA3v9AAAIAEUAAE+ZNUAAQAaNcQoAAAEKAAAC2gwb
W2aCX8DI8UHm4BgB9hREAAABAQgKFhtLQxeJkm4eFiANYViNVe+xDjRSKTFcAAAABwADAQF6enrk
ytlhOS4LAFAAAABQAAAAAAQAAQAGXkQgJOpZAAAIAEUAAEAMb0AAQAYaRwoAAAIKAAABG1vaDMjx
QeZmgl/DsBAB/hQ1AAABAQgKF4mSbhYbS0MeDCAD9QwRzagpjMDkytlhPi4LAF8AAABfAAAAAAAA
AQAGWjIbA3v9AAAIAEUAAE+ZNkAAQAaNcAoAAAEKAAAC2gwbW2aCX8PI8UHm4BgB9hREAAABAQgK
FhtLQxeJkm4eFiANYViNVe+xDjRSKTFfAAAACgADAQFmZmbkytlhQC4LAFAAAABQAAAAAAQAAQAG
XkQgJOpZAAAIAEUAAEAMcEAAQAYaRgoAAAIKAAABG1vaDMjxQeZmgl/GsBAB/hQ1AAABAQgKF4mS
bhYbS0MeDCAD9QwRzagpjMPpytlhpyUNACwAAAAsAAAAAAQAAQAGXkQgJOpZAAAIBgABCAAGBAAB
XkQgJOpZCgAAAgAAAAAAAAoAAAHpytlhWCYNACwAAAAsAAAAAAAAAQAGWjIbA3v9AAAIBgABCAAG
BAABWjIbA3v9CgAAAQAAAAAAAAoAAALpytlhXiYNACwAAAAsAAAAAAQAAQAGXkQgJOpZAAAIBgAB
CAAGBAACXkQgJOpZCgAAAloyGwN7/QoAAAHpytlhYCYNACwAAAAsAAAAAAAAAQAGWjIbA3v9AAAI
BgABCAAGBAACWjIbA3v9CgAAAV5EICTqWQoAAAIQy9lhkP4DAEgAAABIAAAAAAIAAQAGWjIbA3v9
AACG3WAAAAAAEDr//oAAAAAAAABYMhv//gN7/f8CAAAAAAAAAAAAAAAAAAKFAJzIAAAAAAEBWjIb
A3v9IcvZYf4BBQBcAAAAXAAAAAAAAAEABloyGwN7/QAACABFAABMmTdAAEAGjXIKAAABCgAAAtoM
G1tmgl/GyPFB5uARAfYUQQAAAQEIChYcN/cXiZJuHhYgHWFYjVXvsQ40UikxYgAAAAAAAQEBIcvZ
YRECBQBgAAAAYAAAAAAEAAEABl5EICTqWQAACABFAABQDHFAAEAGGjUKAAACCgAAARtb2gzI8UHm
ZoJfxvARAf4URQAAAQEICheKfyIWG0tDHhogH/UMEc2oKYzDTepWLWFYjVUAAAAAAAEBASHL2WFM
AgUAXAAAAFwAAAAAAAABAAZaMhsDe/0AAAgARQAATJk4QABABo1xCgAAAQoAAALaDBtbZoJfx8jx
QefgEAH2FEEAAAEBCAoWHDf3F4p/Ih4WIB1hWI1V77EONFIpMWIAAAAAAAEBASHL2WFUAgUAYAAA
AGAAAAAABAABAAZeRCAk6lkAAAgARQAAUAxyQABABho0CgAAAgoAAAEbW9oMyPFB52aCX8fwEAH+
FEUAAAEBCAoXin8iFhw39x4aIB/1DBHNqCmMw03qVi1hWI1VAAAAAAABAQEmy9lhPNcGACwAAAAs
AAAAAAAAAQAGWjIbA3v9AAAIBgABCAAGBAABWjIbA3v9CgAAAQAAAAAAAAoAAAImy9lhPtcGACwA
AAAsAAAAAAQAAQAGXkQgJOpZAAAIBgABCAAGBAABXkQgJOpZCgAAAgAAAAAAAAoAAAEmy9lhxNcG
ACwAAAAsAAAAAAAAAQAGWjIbA3v9AAAIBgABCAAGBAACWjIbA3v9CgAAAV5EICTqWQoAAAImy9lh
BdgGACwAAAAsAAAAAAQAAQAGXkQgJOpZAAAIBgABCAAGBAACXkQgJOpZCgAAAloyGwN7/QoAAAHP
y9lhqDoGAEgAAABIAAAAAAQAAQAGXkQgJOpZAACG3WAAAAAAEDr//oAAAAAAAABcRCD//iTqWf8C
AAAAAAAAAAAAAAAAAAKFAK2pAAAAAAEBXkQgJOpZIczZYQICBQBIAAAASAAAAAACAAEABloyGwN7
/QAAht1gAAAAABA6//6AAAAAAAAAWDIb//4De/3/AgAAAAAAAAAAAAAAAAAChQCcyAAAAAABAVoy
GwN7/Q==
------=_Part_711688_1572048598.1641664690086--

