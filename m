Content-Type: multipart/mixed; boundary="===============7311830502448978744=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next on 20200316: conflicts
Date: Mon, 16 Mar 2020 16:58:00 +0100
Message-ID: <ec3664be-cde7-fc1c-c201-f0432246e4e6@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3954

--===============7311830502448978744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Recently, MPTCP-related patches from Paolo have been applied in =

'net-next' repo:

- 58b09919626b (mptcp: create msk early)
- dc093db5cc05 (mptcp: drop unneeded checks)

This created conflicts:

- cf1a8046cf64: conflict in t/mptcp-Add-path-manager-interface
- 09497b43baab: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- 08b1bc302164: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests - part 2
- 5d58ead3f82c: conflict in =

t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- 2737f5aa7672: conflict in =

t/mptcp-update-per-unacked-sequence-on-pkt-reception
- 2d24b3dc7d8a: conflict in t/mptcp-increment-MIB-counters-in-a-few-places

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
--===============7311830502448978744==--
