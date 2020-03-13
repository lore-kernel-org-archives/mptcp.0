Content-Type: multipart/mixed; boundary="===============4424495994420181263=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next on 20200313: conflicts
Date: Fri, 13 Mar 2020 18:46:24 +0100
Message-ID: <f106be37-1a94-25ef-02f0-83e1eaf3c222@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3940

--===============4424495994420181263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Recently, one MPTCP-related patch from Davide has been applied in =

'net-next' repo:

- 767d3ded5fb8 (net: mptcp: don't hang before sending 'MP capable with =

data')

This created conflicts:

- 21a8666f4683: conflict in t/mptcp-Add-path-manager-interface
- c1aa2cd27a83: conflict in =

t/mptcp-update-per-unacked-sequence-on-pkt-reception

I hope they have been resolved as expected.

Tests are all green and the "export" branch has been updated.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4424495994420181263==--
