Content-Type: multipart/mixed; boundary="===============8609574756570851990=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 00/10] mptcp: cleanup token code
Date: Thu, 29 Aug 2019 11:06:49 +0200
Message-ID: <20190829090659.766-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1742

--===============8609574756570851990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series again marked RFC so noone bothers to squash all of
this into the mptcp tree.

In this second round, I've addressed all comments from Matthieu
and Peter.  As a result, even more code was pruned from token.c
and placed as static helper in subflow.c.

I've added a 'v2' mini-changelog to all affected patches.

 pm.c       |    6 =

 protocol.c |    5 =

 protocol.h |   23 +--
 subflow.c  |  152 +++++++++++++++++++--
 token.c    |  426 +++++++++++++++++++-------------------------------------=
-----
 5 files changed, 277 insertions(+), 333 deletions(-)



--===============8609574756570851990==--
