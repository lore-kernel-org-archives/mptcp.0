Content-Type: multipart/mixed; boundary="===============3378805974540582725=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Updated net-next merge
Date: Fri, 18 May 2018 17:10:43 -0700
Message-ID: <alpine.OSX.2.21.1805181657560.16804@johnferg-ivm.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 633

--===============3378805974540582725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello everyone -

I updated the master branch at https://github.com/multipath-tcp/mptcp_net-n=
ext

There was a conflict this time, due to an upstream change in the pacing =

timer callback from hard irq to soft irq context:

https://github.com/multipath-tcp/mptcp_net-next/commit/73a6bab5aa2a83cb7df8=
5805e08bc03b4065aea7


Here's the fixup commit with the relevant changes to tcp_tsq_handler() and =

its call to mptcp_tsq_flags():

https://github.com/multipath-tcp/mptcp_net-next/commit/6ae85f7b54d576613117=
0b363cbeb86e421ced26


--
Mat Martineau
Intel OTC

--===============3378805974540582725==--
