Content-Type: multipart/mixed; boundary="===============1852821206873348100=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] mptcp: add MIB counter infrastructure
Date: Fri, 20 Sep 2019 17:05:12 +0200
Message-ID: <20190920150514.1878-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1888

--===============1852821206873348100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds MIB counters for MPTCP, see patch #1 for more information.

Bottom line is that I tried to follow the advice given earlier by
Eric, i.e. this adds a new mptcp specific pointer to the netns_mib
struct (which is embedded into struct net).

Allocation is deferred until first MPTCP socket is opened.

Comments welcome.



--===============1852821206873348100==--
