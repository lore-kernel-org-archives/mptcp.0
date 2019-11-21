Content-Type: multipart/mixed; boundary="===============3510182211550561267=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] mptcp: fix for ipv6-related oops
Date: Thu, 21 Nov 2019 13:25:15 +0100
Message-ID: <cover.1574338647.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2640

--===============3510182211550561267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to allocate a larger struct sock for mptcp v6 master sockets,
otherwise inet6_sk() will access mptcp related data instead of
struct ipv6_pinfo.

This should fix the crash reported by Matt.

The protocol.c code changes are split in 2 patches to simplify the
squashing.
(yep, I know we somewhat agreed to big giant rebase, but this specific
should be trivial).

Additionally adds some fixlet for the ipv6 tests

Paolo Abeni (3):
  selftests: fixup for IPv6 tests
  mptcp: use ipv6-specific proto struct
  mptcp/ipv6: mptcp_v6_prot needs costom destroy.

 net/mptcp/protocol.c                          | 17 ++++++++++--
 .../selftests/net/mptcp/mptcp_connect.sh      | 27 +++++++++----------
 2 files changed, 27 insertions(+), 17 deletions(-)

-- =

2.21.0

--===============3510182211550561267==--
