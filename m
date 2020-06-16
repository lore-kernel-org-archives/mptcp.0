Content-Type: multipart/mixed; boundary="===============5287642821054309684=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/2] mptcp: setsockopt: allow reuseport and
 ip6only
Date: Tue, 16 Jun 2020 02:41:47 +0200
Message-ID: <20200616004149.21233-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4685

--===============5287642821054309684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First patch makes reuseport setsockopt work by copying the mptcp
sockets setting to the newly created subflow socket.

Second patch makes mptcp accept IPV6_V6ONLY by applying the setsockopt
to the initial socket.

First patch addresses:
https://github.com/multipath-tcp/mptcp_net-next/issues/30

Second patch makes sshd work with ipv6 too.

I've tested this with out-of-tree patch that aliases IPPROTO_TCP to
IPPROTO_MPTCP, without these patches I see the behaviour Christoph
describes in the github issue (restart fails, IPV6_V6only error).


--===============5287642821054309684==--
