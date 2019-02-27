Content-Type: multipart/mixed; boundary="===============3233103254460311787=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] MPTCP architecture proposal - RFCv7 changes pushed
Date: Wed, 27 Feb 2019 15:58:02 -0800
Message-ID: <alpine.OSX.2.21.1902271551290.26295@gcomella-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1021

--===============3233103254460311787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello -

I've pushed a new revision of the MPTCP kernel architecture proposal:

https://review.gerrithub.io/q/project:multipath-tcp%252Fmptcp_net-next+stat=
us:open

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?h=
=3Dmptcp-proposal


Changes:

  * Added Florian's commits for kselftest/etc

  * Fixed read length bug that Florian noted

  * Fixed compilation without CONFIG_IPV6

  * Fixed DSS re-parsing warning when reading partial skb


Thanks,


--
Mat Martineau
Intel

--===============3233103254460311787==--
