Content-Type: multipart/mixed; boundary="===============7952231120931276412=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/3] mptcp: fix mistake in path manager interface
Date: Tue, 22 Oct 2019 13:57:17 +0200
Message-ID: <ffbe1b22-3d87-33b6-9ed6-7481754ca5c9@tessares.net>
In-Reply-To: 20191021234152.3091-2-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2255

--===============7952231120931276412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 22/10/2019 01:41, Peter Krystad wrote:
> Do not de-reference NULL pointer immediately after confirming it
> is NULL.
> =

> squashto:  Implement path manager interface commands

Thank you for the patch! I just applied this one but not the other ones =

due to the other discussions started on the last one.

- 166607d720d7: "squashed" patch 1/3 in "mptcp: Implement path manager =

interface commands"
- 088eb1a59555..ecb276617e3b: results

Tests have the same issue as what has been saw this night:


   00:06:43.648 # ns2  MPTCP -> ns3  (10.0.2.2:10027) MPTCP	[ OK ]
   00:06:44.698 # ns2  MPTCP -> ns3  (10.0.2.2:10028) TCP  	[ OK ]
   00:06:45.940 # ns2  TCP   -> ns3  (10.0.2.2:10029) MPTCP	[ OK ]
   00:06:46.992 # ns2  MPTCP -> ns3  (10.0.3.2:10030) MPTCP =

./mptcp_connect.sh: line 16:   797 Terminated              ip netns exec =

${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s ${srv_proto} =

0.0.0.0 < "$sin" > "$sout"
   00:06:47.076 # ./mptcp_connect.sh: line 16:   798 Terminated =

     sleep 1
   00:06:47.108 not ok 1 selftests: mptcp: mptcp_connect.sh # TIMEOUT


Maybe due to a modification in net-next.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7952231120931276412==--
