Content-Type: multipart/mixed; boundary="===============6974782778907273908=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next on 20200625: conflicts
Date: Thu, 25 Jun 2020 17:53:50 +0200
Message-ID: <07b1ca19-79c2-144f-97c3-d09201fb8565@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4805

--===============6974782778907273908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Recently, MPTCP-related patches from Eric Dumazet have been applied in =

'net-next' repo:

- 9b9e2f250e3e ("tcp: move ipv4_specific to tcp include file")
- b03d2142bea8 ("tcp: move ipv6_specific declaration to remove a warning")

These created conflicts:

- 2c57fdd819ca: conflict in t/mptcp-add-__init-annotation-on-setup-functions

Tests are in progress. The "export" branch will be updated after the tests.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6974782778907273908==--
