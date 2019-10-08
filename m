Content-Type: multipart/mixed; boundary="===============5879139681729737085=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] mptcp: disallow setting the MPTCP ULP from
 userspace
Date: Tue, 08 Oct 2019 16:43:11 +0200
Message-ID: <cover.1570545679.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2047

--===============5879139681729737085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

with this series we make

setscokopt(..., IPPROTO_TCP, TCP_ULP, "mptcp", sizeof("mptcp"));

return -1 and set errno to -EOPNOPSUPPORT.

this allows attaching MPTCP ULP only to a TCP socket that has been
created through sock_create_kern().

- Patch 1/2 lets subflow_init() fail with -EOPNOTSUPPORT in case users
  try to setsockopt(..., TCP_ULP) on a TCP socket that has been created
  by a userspace program. I suggest squashing this patch in "mptcp:
  Associate MPTCP context with TCP socket".
- Patch 2/2 includes kselftest code. I suggest squashing it with "mptcp:
  add basic kselftest for mptcp".*** SUBJECT HERE ***

Davide Caratti (2):
  mptcp: subflow: disallow setsockopt(... TCP_ULP, "mptcp")
  selftests: test setsockopt(..., TCP_ULP, "mptcp", ...)

 net/mptcp/subflow.c                           |  7 +++
 .../selftests/net/mptcp/mptcp_connect.c       | 49 +++++++++++++++++--
 .../selftests/net/mptcp/mptcp_connect.sh      | 19 +++++++
 3 files changed, 72 insertions(+), 3 deletions(-)

-- =

2.21.0

--===============5879139681729737085==--
