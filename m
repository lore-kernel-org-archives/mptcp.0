Content-Type: multipart/mixed; boundary="===============6684321596795159520=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Selftests: 1 error last night 20191022
Date: Tue, 22 Oct 2019 13:20:03 +0200
Message-ID: <a517e2f1-dad0-42e4-0740-f9e10b4ad508@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2254

--===============6684321596795159520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Last night I got an error with selftests without KASAN, etc.:


   01:02:11.478 # ns3  MPTCP -> ns1  (10.0.1.1:10036) MPTCP	[ OK ]
   01:02:12.517 # ns3  MPTCP -> ns1  (10.0.1.1:10037) TCP  	[ OK ]
   01:02:13.554 # ns3  TCP   -> ns1  (10.0.1.1:10038) MPTCP	[ OK ]
   01:02:14.596 # ./mptcp_connect.sh: line 16:   850 Terminated =

     cat "$capout"
   01:02:14.627 not ok 1 selftests: mptcp: mptcp_connect.sh # TIMEOUT


I am not sure where this "TIMEOUT" comes from :-/
Any idea?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6684321596795159520==--
