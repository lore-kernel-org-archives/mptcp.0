Content-Type: multipart/mixed; boundary="===============6322522368428622240=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 0/7] fallback to TCP on ulp clone failure
Date: Wed, 08 Jan 2020 15:47:17 +0100
Message-ID: <cover.1578487811.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3290

--===============6322522368428622240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series do real TCP fallback for passive MPTCP connection when ULP clone
fails: clear the 'is_mptcp' flag, reset overridden callback, icsk ops and
clear the ULP ctx.

Additionally uses the 'is_mptcp' flag to check for fallback in more places,
as suggested by Mat (patches 2, 4), cope with NULL ctx in
subflow_syn_recv_sock() (patches 3, 7), and restore TCP callback on =

later fallback, too (patch 6) for consistency.

This still uses function pointers to store all the overriden TCP callbacks,
is simpler then other alternatives but waste some space inside the subflow
struct.

The rebased tree is available at:

https://github.com/pabeni/mptcp/tree/mptcp_net-next_export_v6.2

 options.c  |    6 -----
 protocol.c |   16 ++++++--------
 protocol.h |   15 ++++++++++++-
 subflow.c  |   67 ++++++++++++++++++++++++++++++++++++++++----------------=
-----
 4 files changed, 67 insertions(+), 37 deletions(-)

--===============6322522368428622240==--
