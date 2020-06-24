Content-Type: multipart/mixed; boundary="===============6712413501386089811=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v3 0/3] setsockopt: allow reuseport and
 ip6only
Date: Wed, 24 Jun 2020 21:24:45 +0200
Message-ID: <20200624192448.20837-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4786

--===============6712413501386089811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

3rd iteration.  I've incorporated feedback from Mat, so for
options other than reuseport/reuseaddr the generic handler gets called
instead of returning -EOPNOTSUPP.

I've tested that ssh restart works on a a modified kernel that
enables mptcp for all IPPROTO_TCP sockets.

--===============6712413501386089811==--
