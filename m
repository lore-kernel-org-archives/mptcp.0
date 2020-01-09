Content-Type: multipart/mixed; boundary="===============2211858219360469798=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/7] fallback to TCP on ulp clone failure
Date: Thu, 09 Jan 2020 17:41:31 +0100
Message-ID: <cover.1578586484.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3327

--===============2211858219360469798==
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

https://github.com/pabeni/mptcp/tree/mptcp_net-next_export_v7.1

This is on top of export branch(a)b50a38e09bbc6182136836564945a323641a5039
(tag: export/20200109T154238)

v1 -> v2
 - uses sk_is_mptcp() when possible (Mat)
 - drop rendundant checks (Mat)

 options.c  |    7 ------
 protocol.c |   20 ++++++++---------
 protocol.h |   15 ++++++++++++-
 subflow.c  |   68 ++++++++++++++++++++++++++++++++++++++++----------------=
-----
 4 files changed, 68 insertions(+), 42 deletions(-)

--===============2211858219360469798==--
