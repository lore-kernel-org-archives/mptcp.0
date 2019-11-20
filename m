Content-Type: multipart/mixed; boundary="===============5290448968515179217=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] reduce patchset 2 (up to kselftests)
Date: Wed, 20 Nov 2019 20:48:36 +0100
Message-ID: <3aa1e2d0-847f-7f53-c486-5a9445125877@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2628

--===============5290448968515179217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

As discussed at a previous meeting, I just moved some commits linked to =

the manipulation of multiple subflows after the one introducing the =

kselftests.

Just to keep a trace and to allow a review, I did this operation with =

TopGit. But for this kind of operation, if we don't need a "review", =

that's a bit quicker with "git rebase" :)

- 3e77653ecb5f: cut (empty) t/mptcp-Add-path-manager-interface
- 1cb01298549d: cut (empty) t/mptcp-Add-ADD_ADDR-handling
- 25c9462ee09f: cut (empty) =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- 2a1ef2512c28: conflict (Makefile) in =

t/mptcp-new-sysctl-to-control-the-activation-per-NS
- 152ef156123f: tg create t/mptcp-Add-path-manager-interface-v2
- 4569c65e2c58: paste (recreate) t/mptcp-Add-path-manager-interface
- 3cc80d22d759: tg create t/mptcp-Add-ADD_ADDR-handling-v2
- 7928974b360d: paste (recreate) t/mptcp-Add-ADD_ADDR-handling
- 5d24692b5191: tg create =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests-v2
- faf79ec33f1e: paste (recreate) =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- d4fd5437d11b: t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests is now =

on top of t/mptcp-Add-handling-of-incoming-MP_JOIN-requests-v2
- a4c1cf31bee5: conflict (Makefile) in =

t/mptcp-allow-dumping-subflow-context-to-userspace
- abe60f261c3d: conflict (Makefile) in =

t/mptcp-add-MIB-counter-infrastructure
- f1e5ff4a68a1: conflict (Makefile) in t/mptcp-Implement-basic-path-manager
- e73eef882a05..eaa68661fa8c: result (only the order in the Makefile)

The only issue is that now the kselftests with IPv6 no longer works when =

we launch them in the commit that introduces the kselftests :'(

It is easy to reproduce and I have a calltrace but I will send a =

separated email for that.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5290448968515179217==--
