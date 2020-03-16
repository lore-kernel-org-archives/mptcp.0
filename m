Content-Type: multipart/mixed; boundary="===============0457854518230954196=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 0/3] MP_JOIN self-tests fixes
Date: Mon, 16 Mar 2020 16:09:42 +0100
Message-ID: <cover.1584370791.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3950

--===============0457854518230954196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series addresses the currently known issues in MP_JOIN self-tests.

Due to some races, without these patches I observe intermittent failures (s=
ay
1 out of 3 self-tests fail). With this patches applied, self-tests survived
~200 iterations successfully.

See individual patches for the details.

On top of "mptcp: move msk state update to subflow_syn_recv_sock()"

 net/mptcp/pm.c                                    |   40 ++++++++++++++++-=
-----
 net/mptcp/pm_netlink.c                            |   23 +++---------
 net/mptcp/protocol.c                              |    1 =

 net/mptcp/protocol.h                              |    4 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c |   11 ++++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |    8 +++-
 6 files changed, 55 insertions(+), 32 deletions(-)

--===============0457854518230954196==--
