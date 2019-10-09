Content-Type: multipart/mixed; boundary="===============1948327584196500238=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] One more squash
Date: Tue, 08 Oct 2019 17:25:47 -0700
Message-ID: <alpine.OSX.2.21.1910081720290.38700@crpeter1-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2062

--===============1948327584196500238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


With Florian's branch as a basis:

https://git.breakpoint.cc/cgit/fw/mptcp-next.git/log/?h=3Dexport_sendmsg_re=
base_13

I've squashed one more patch out of the series. "mptcp: Make MPTCP socket =

block/wakeup ignore sk_receive_queue" has been combined with "mptcp: =

Implement MPTCP receive path". The diff of the full series is unchanged.

--
Mat Martineau
Intel
--===============1948327584196500238==--
