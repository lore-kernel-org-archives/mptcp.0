Content-Type: multipart/mixed; boundary="===============0887921573362220280=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Design ideas for MPTCP metadata queuing
Date: Fri, 03 Aug 2018 10:43:45 -0700
Message-ID: <alpine.OSX.2.21.1808031036550.13723@bjaszczy-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 694

--===============0887921573362220280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello -

We've been discussing ideas for handling MPTCP metadata (DSS mappings, =

ADD_ADDR, REMOVE_ADDR, etc) with a manageable amount of impact on the TCP =

stack and networking subsystem.

I've written up some design proposals on our wiki: =

https://github.com/multipath-tcp/mptcp_net-next/wiki/Design
(see the "Metadata queuing" section).

I'd appreciate any comments and feedback.


Thanks,

--
Mat Martineau
Intel OTC

--===============0887921573362220280==--
