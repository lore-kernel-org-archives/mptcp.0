Content-Type: multipart/mixed; boundary="===============4221431140414373907=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next on 20200324: conflicts
Date: Tue, 24 Mar 2020 09:46:52 +0100
Message-ID: <3dc23f12-9664-e473-4b87-6858a06f4fd0@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4052

--===============4221431140414373907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Recently, MPTCP-related patch from Davide has been applied in 'net-next' =

repo:

- 767d3ded5fb8 (net: mptcp: don't hang before sending 'MP capable with =

data')

This created conflicts:

- 02366081040c: conflict in t/mptcp-Add-path-manager-interface
- fc3cbf097321: conflict in =

t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- 501e7cf63225: conflict in =

t/mptcp-update-per-unacked-sequence-on-pkt-reception
- 6ed26433863c..844c9c9ed5a1 -- net/mptcp: result

I hope they have been resolved as expected.

Tests are in progress. The "export" branch will be updated after the tests.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4221431140414373907==--
