Content-Type: multipart/mixed; boundary="===============7581796681956991827=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] mptcp: fix for ipv6-related oops
Date: Thu, 21 Nov 2019 16:41:49 +0100
Message-ID: <cover.1574350681.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2651

--===============7581796681956991827==
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

v1 -> v2:
 - address Matt feedback on patches 1 && 2
 - add missing mptcp_v6 proto registration (I don't know why the previous
   iteration of these patches did not explode without that!!! :(((

Paolo Abeni (3):
  selftests: fixup for IPv6 tests
  mptcp: use ipv6-specific proto struct
  mptcp/ipv6: mptcp_v6_prot needs costom destroy.

 net/mptcp/protocol.c                          | 24 +++++++++++--
 .../selftests/net/mptcp/mptcp_connect.sh      | 34 ++++++-------------
 2 files changed, 33 insertions(+), 25 deletions(-)

-- =

2.21.0

--===============7581796681956991827==--
